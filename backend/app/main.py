from fastapi import FastAPI

from app.api.test_db import router as test_db_router

app = FastAPI(
    title="Vendor Portal System",
    description="Vendor Invoice Processing Portal",
    version="1.0.0"
)

app.include_router(test_db_router)


@app.get("/")
def root():
    return {"message": "Vendor Portal Backend Running"}


@app.get("/health")
def health_check():
    return {"status": "healthy"}