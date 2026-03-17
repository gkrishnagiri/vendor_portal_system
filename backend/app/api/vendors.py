from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from sqlalchemy import text

from app.db.database import get_db

router = APIRouter(prefix="/vendors", tags=["Vendors"])


@router.get("/")
def get_vendors(db: Session = Depends(get_db)):

    query = text("""
        SELECT vendor_id, vendor_code, vendor_name, vendor_title
        FROM invoicing.vendors
        ORDER BY vendor_id
    """)

    result = db.execute(query).fetchall()

    vendors = []

    for row in result:
        vendors.append({
            "vendor_id": row[0],
            "vendor_code": row[1],
            "vendor_name": row[2],
            "vendor_title": row[3]
        })

    return vendors