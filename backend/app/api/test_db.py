from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from sqlalchemy import text

from app.db.database import get_db

router = APIRouter()


@router.get("/test-db")
def test_database_connection(db: Session = Depends(get_db)):
    
    query = text("SELECT vendor_id, vendor_name FROM invoicing.vendors LIMIT 5")
    
    result = db.execute(query).fetchall()

    vendors = []

    for row in result:
        vendors.append({
            "vendor_id": row[0],
            "vendor_name": row[1]
        })

    return {
        "message": "Database connection successful",
        "vendors": vendors
    }