import os
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from urllib.parse import quote_plus

# Read environment variables
DB_HOST = os.environ.get("DATABASE_HOST")
DB_PORT = os.environ.get("DATABASE_PORT")
DB_NAME = os.environ.get("DATABASE_NAME")
DB_USER = os.environ.get("DATABASE_USER")
DB_PASSWORD = os.environ.get("DATABASE_PASSWORD")

# Encode password safely for URL
ENCODED_PASSWORD = quote_plus(DB_PASSWORD)

DATABASE_URL = (
    f"postgresql+psycopg2://{DB_USER}:{ENCODED_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"
)

engine = create_engine(
    DATABASE_URL,
    pool_pre_ping=True
)

SessionLocal = sessionmaker(
    autocommit=False,
    autoflush=False,
    bind=engine
)


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()