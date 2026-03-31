from fastapi import FastAPI
from pydantic import BaseModel
from recommender import recommend_papers
from fastapi.middleware.cors import CORSMiddleware

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