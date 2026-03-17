from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from sqlalchemy import text

from app.db.database import get_db

router = APIRouter(prefix="/purchase-orders", tags=["Purchase Orders"])


@router.get("/")
def get_purchase_orders(db: Session = Depends(get_db)):

    query = text("""
        SELECT po_id, po_number, vendor_id, po_date, total_amount, status
        FROM invoicing.purchase_orders
        ORDER BY po_id
    """)

    result = db.execute(query).fetchall()

    pos = []

    for row in result:
        pos.append({
            "po_id": row[0],
            "po_number": row[1],
            "vendor_id": row[2],
            "po_date": str(row[3]),
            "total_amount": float(row[4]),
            "status": row[5]
        })

    return pos