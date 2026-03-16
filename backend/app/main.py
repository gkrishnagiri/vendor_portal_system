from fastapi import FastAPI

app = FastAPI(
    title="Vendor Portal System",
    description="Vendor Invoice Processing Portal",
    version="1.0.0"
)

@app.get("/")
def root():
    return {"message": "Vendor Portal Backend Running"}

@app.get("/health")
def health_check():
    return {"status": "healthy"}