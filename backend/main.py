from fastapi import FastAPI, Depends, HTTPException
from pydantic import BaseModel
from recommender import recommend_papers
from fastapi.middleware.cors import CORSMiddleware
from sqlalchemy.orm import Session
from database import SessionLocal, engine
import models

models.Base.metadata.create_all(bind=engine)


app = FastAPI(
    title="Research Paper Recommender API",
    description="Hybrid ML + Semantic Search API",
    version="1.0"
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # allow all (for dev)
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# =========================
# REQUEST MODEL
# =========================
class QueryRequest(BaseModel):
    query: str
    top_k: int = 10


# =========================
# ROOT ENDPOINT
# =========================
@app.get("/")
def home():
    return {"message": "🚀 Research Paper Recommender API is running"}


# =========================
# RECOMMEND ENDPOINT
# =========================
@app.post("/recommend")
def recommend(data: QueryRequest):
    result = recommend_papers(data.query, data.top_k)
    return result

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


class UserCreate(BaseModel):
    username: str
    email: str
    password: str

class UserLogin(BaseModel):
    email: str
    password: str

@app.post("/register")
def register(user: UserCreate, db: Session = Depends(get_db)):
    
    existing_user = db.query(models.User).filter(models.User.email == user.email).first()
    
    if existing_user:
        raise HTTPException(status_code=400, detail="User already exists")

    new_user = models.User(
        username=user.username,
        email=user.email,
        password=user.password
    )

    db.add(new_user)
    db.commit()
    db.refresh(new_user)

    return {"message": "User registered successfully"}


@app.post("/login")
def login(user: UserLogin, db: Session = Depends(get_db)):

    existing_user = db.query(models.User).filter(models.User.email == user.email).first()

    if not existing_user or existing_user.password != user.password:
        raise HTTPException(status_code=400, detail="Invalid credentials")

    return {
        "message": "Login successful",
        "user_id": existing_user.id,
        "username": existing_user.username
    }


class UpdateUser(BaseModel):
    email: str
    username: str = None
    password: str = None

@app.put("/update-user")
def update_user(data: UpdateUser, db: Session = Depends(get_db)):

    user = db.query(models.User).filter(models.User.email == data.email).first()

    if not user:
        raise HTTPException(status_code=404, detail="User not found")

    if data.username:
        user.username = data.username

    if data.password:
        user.password = data.password

    db.commit()
    db.refresh(user)

    return {"message": "User updated successfully"}


class SavePaperRequest(BaseModel):
    user_id: int
    title: str
    authors: str
    summary: str
    category: str
    terms: str
    first_author: str
    published_date: str


@app.post("/save-paper")
def save_paper(data: SavePaperRequest, db: Session = Depends(get_db)):

    existing = db.query(models.SavedPaper).filter(
        models.SavedPaper.user_id == data.user_id,
        models.SavedPaper.title == data.title
    ).first()

    if existing:
        return {"message": "Already saved"}

    paper = models.SavedPaper(
        user_id=data.user_id,
        title=data.title,
        authors=data.authors,
        summary=data.summary,
        category=data.category,
        terms=data.terms,
        first_author=data.first_author,
        published_date=data.published_date,
    )

    db.add(paper)
    db.commit()

    return {"message": "Saved", "paper_id": paper.id}

@app.get("/get-library/{user_id}")
def get_library(user_id: int, db: Session = Depends(get_db)):
    papers = db.query(models.SavedPaper).filter(models.SavedPaper.user_id == user_id).all()

    return [
        {
            "id": p.id,
            "title": p.title,
            "authors": p.authors,
            "summary": p.summary,
            "category": p.category,
            "terms": p.terms,
            "first_author": p.first_author,
            "published_date": p.published_date,
        }
        for p in papers
    ]


@app.delete("/delete-paper/{paper_id}")
def delete_paper(paper_id: int, db: Session = Depends(get_db)):
    paper = db.query(models.SavedPaper).filter(models.SavedPaper.id == paper_id).first()

    if not paper:
        raise HTTPException(status_code=404, detail="Not found")

    db.delete(paper)
    db.commit()
    return {"message": "Deleted"}

@app.get("/get-user/{user_id}")
def get_user(user_id: int, db: Session = Depends(get_db)):
    user = db.query(models.User).filter(models.User.id == user_id).first()

    if not user:
        raise HTTPException(status_code=404, detail="User not found")

    return {
        "username": user.username,
        "email": user.email
    }