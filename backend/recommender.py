import os
import pickle
import pandas as pd
import numpy as np
from sklearn.metrics.pairwise import cosine_similarity
from sentence_transformers import SentenceTransformer

# =========================
# BASE PATH (IMPORTANT)
# =========================
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

# =========================
# LOAD MODELS
# =========================
model_lr = pickle.load(open(os.path.join(BASE_DIR, "models/model_lr.pkl"), "rb"))
model_nb = pickle.load(open(os.path.join(BASE_DIR, "models/model_nb.pkl"), "rb"))
model_svm = pickle.load(open(os.path.join(BASE_DIR, "models/model_svm.pkl"), "rb"))

vectorizer = pickle.load(open(os.path.join(BASE_DIR, "models/vectorizer.pkl"), "rb"))
mlb = pickle.load(open(os.path.join(BASE_DIR, "models/mlb.pkl"), "rb"))
threshold = pickle.load(open(os.path.join(BASE_DIR, "models/threshold.pkl"), "rb"))
embeddings = pickle.load(open(os.path.join(BASE_DIR, "models/embeddings.pkl"), "rb"))

# sentence transformer
with open(os.path.join(BASE_DIR, "models/embedding_model.txt")) as f:
    model_name = f.read().strip()

model_st = SentenceTransformer(model_name)

# dataset
df = pd.read_csv(os.path.join(BASE_DIR, "data/processed_dataset.csv"))
df["text"] = df["titles"] + " " + df["summaries"]

print("✅ Models and data loaded successfully!")


# =========================
# MAIN FUNCTION
# =========================
def recommend_papers(query, top_k=10):

    query_text = query

    # 🔹 Step 1: Predict labels
    vec = vectorizer.transform([query_text])
    
    p1 = model_lr.predict_proba(vec)
    p2 = model_nb.predict_proba(vec)
    p3 = model_svm.decision_function(vec)

    # normalize SVM scores
    p3 = (p3 - p3.min()) / (p3.max() - p3.min())

    probs = (0.5*p1 + 0.3*p2 + 0.2*p3)
    probs = np.power(probs, 1.2)

    idx = np.where(probs[0] >= threshold)[0]

    # ensure at least 2 labels
    if len(idx) < 2:
        idx = np.argsort(probs[0])[-2:]

    labels = [mlb.classes_[i] for i in idx]

    # 🔹 Step 2: Filter dataset
    mask = df["terms"].apply(lambda x: any(label in x for label in labels))
    filtered_df = df[mask]

    if len(filtered_df) == 0:
        filtered_df = df
        filtered_embeddings = embeddings
    else:
        filtered_embeddings = embeddings[mask.values]

    # 🔹 Step 3: Semantic similarity
    query_emb = model_st.encode([query_text])
    sim = cosine_similarity(query_emb, filtered_embeddings)[0]

    # 🔹 Step 4: Sort results
    sorted_idx = np.argsort(sim)[::-1][:top_k]

    results = filtered_df.iloc[sorted_idx].copy()
    results["similarity_score"] = sim[sorted_idx]

    # 🔹 Step 5: Return JSON-ready output
    return {
        "predicted_labels": labels,
        "recommendations": results[[
            "titles",
            "category",
            "authors",
            "first_author",
            "terms",
            "published_date",
            "summaries",
            "similarity_score"
        ]].to_dict(orient="records")
    }