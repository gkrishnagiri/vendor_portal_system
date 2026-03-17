from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from sqlalchemy import text

from app.db.database import get_db

router = APIRouter(prefix="/invoices", tags=["Invoices"])


@router.get("/")
def get_invoices(db: Session = Depends(get_db)):

    query = text("""
        SELECT invoice_txn_id,
               vendor_id,
               invoice_number,
               invoice_date,
               invoice_amount,
               currency_code,
               po_number,
               validation_status
        FROM invoicing.vendor_invoice_transactions
        ORDER BY invoice_txn_id
    """)

    result = db.execute(query).fetchall()

    invoices = []

    for row in result:
        invoices.append({
            "invoice_txn_id": row[0],
            "vendor_id": row[1],
            "invoice_number": row[2],
            "invoice_date": str(row[3]),
            "invoice_amount": float(row[4]),
            "currency_code": row[5],
            "po_number": row[6],
            "validation_status": row[7]
        })

    return invoices