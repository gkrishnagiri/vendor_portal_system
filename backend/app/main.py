from fastapi import FastAPI

from app.api.test_db import router as test_db_router
from app.api.vendors import router as vendors_router
from app.api.purchase_orders import router as po_router
from app.api.invoices import router as invoices_router


app = FastAPI(
    title="Vendor Portal System",
    description="Vendor Invoice Processing Portal",
    version="1.0.0"
)

app.include_router(test_db_router)
app.include_router(vendors_router)
app.include_router(po_router)
app.include_router(invoices_router)


@app.get("/")
def root():
    return {"message": "Vendor Portal Backend Running"}


@app.get("/health")
def health_check():
    return {"status": "healthy"}