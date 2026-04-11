# 📄 Research Paper Recommendation System

A **full-stack AI-powered recommendation system** that suggests relevant research papers based on user input such as title, abstract, or keywords.

This project combines **Machine Learning (multi-label classification)** and **Semantic Search (Sentence Transformers)** to deliver highly accurate and context-aware recommendations.

---

## 🌐 Live System Overview

* 🧠 **Backend:** FastAPI (ML + API layer)
* 📱 **Frontend:** Flutter (Web/App UI)
* 🗄️ **Database:** SQLite (user + saved papers)
* 🤖 **ML Models:** TF-IDF + SVM + Sentence Transformers

---

## 🚀 Features

* 🔍 Flexible input (title / abstract / keywords)
* 🧠 Predicts research domains (e.g., `cs.AI`, `cs.CV`, `cs.LG`)
* 📑 Top-K research paper recommendations
* ⭐ Save / remove papers (user library)
* 👤 User authentication (login/register)
* ✏️ Profile update with prefilled data
* ⚡ Hybrid recommendation system
* 🧠 Semantic understanding using **Sentence Transformers**
* 📊 Works on large-scale dataset (~135k papers)

---

## 🧠 Methodology

The system follows a **Hybrid Recommendation Pipeline**:

### 1. Text Preprocessing

* Combine **title + summary**
* Clean and normalize text
* Remove noise and rare labels

### 2. Feature Engineering

* TF-IDF Vectorization

  * Unigram + Bigram
  * Stopword removal
  * Frequency filtering

### 3. Multi-label Classification

* Logistic Regression (One-vs-Rest)
* Multinomial Naive Bayes
* Linear SVM (best performing)
* Dynamic label selection (threshold + top-k)

### 4. Candidate Filtering

* Predicted labels narrow down search space

### 5. Semantic Similarity (🔥 Core Component)

* Sentence Transformer: `all-MiniLM-L6-v2`
* Cosine similarity between embeddings
* Retrieves most relevant papers

---

## 🏗️ Project Structure

```
research-paper-recommender/
│
├── backend/               # FastAPI backend
│   ├── main.py
│   ├── recommender.py
│   ├── database.py
│   ├── models.py
│
├── flutter_app/           # Flutter frontend
│   ├── lib/
│   ├── pubspec.yaml
│
├── src/                   # ML notebooks
│   ├── train.ipynb
│   ├── recommender.ipynb
│
├── data/                  # (ignored)
├── models/                # (ignored)
│
├── requirements.txt
├── README.md
└── .gitignore
```

---

## 📊 Dataset

Due to size limitations, dataset is not included.

👉 Download from: **[Add Dataset Link Here]**

Place inside:

```
data/
```

---

## ⚙️ Installation

```bash
git clone https://github.com/Heeren10/Research_Paper_Recommendation_System.git
cd Research_Paper_Recommendation_System
pip install -r requirements.txt
```

---

## ▶️ Run Project

### 🔹 Backend (FastAPI)

```bash
cd backend
uvicorn main:app --reload
```

Open:

```
http://127.0.0.1:8000/docs
```

---

### 🔹 Frontend (Flutter)

```bash
cd flutter_app
flutter run
```

---

## 🧪 Example

**Input:**

```
deep learning for medical image analysis
```

**Output:**

```
Predicted Labels: ['cs.CV', 'cs.LG']

Top Recommendations:
- Title: ...
- Authors: ...
- Similarity Score: ...
- Summary: ...
```

---

## 📈 Results

* ✅ **F1 Micro:** ~0.70 – 0.75
* ⚖️ **F1 Macro:** ~0.25 – 0.30
* 🔁 Strong recall and balanced predictions
* 🚀 Significant improvement using hybrid approach

---

## 🛠️ Tech Stack

### 🔹 Machine Learning

* Scikit-learn
* TF-IDF
* Multi-label classification
* Sentence Transformers

### 🔹 Backend

* FastAPI
* SQLAlchemy
* SQLite

### 🔹 Frontend

* Flutter (Web & App)

### 🔹 Tools

* Pandas / NumPy / Scikit Learn
* Jupyter Notebook

---

## 🔐 Authentication System

* User registration & login
* Session handling using SharedPreferences
* Profile update support
* Secure API-based authentication

---

## 📚 Key Insight

> Classification predicts **“what topic”**,
> Embeddings capture **“how similar”**,
> Together → **powerful hybrid recommendation system**

---

## 🔮 Future Improvements

* ⚡ FAISS for faster similarity search
* 🌐 Cloud deployment (Render / AWS)
* 📊 Personalized recommendations (user history)
* 🤖 BERT / SciBERT fine-tuning
* 🎯 Ranking optimization (recency + relevance)

---

