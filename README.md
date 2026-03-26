# 📄 Research Paper Recommendation System

A **hybrid AI-powered recommendation system** that suggests relevant research papers based on user input (title, abstract, or keywords).
The system combines **multi-label classification** and **semantic similarity using Sentence Transformers** for highly accurate recommendations.

---

## 🚀 Features

* 🔍 Accepts flexible input (title / abstract / keywords)
* 🧠 Predicts research domains (e.g., `cs.AI`, `cs.CV`, `cs.LG`)
* 📑 Recommends top similar research papers
* ⚡ Hybrid approach: **ML classification + semantic embeddings**
* 🧠 Semantic understanding using **Sentence Transformers**
* 📊 Works on large-scale arXiv dataset (~135k papers)

---

## 🧠 Methodology

The system follows a **hybrid pipeline**:

### 1. Text Processing

* Combine **title + summary**
* TF-IDF vectorization (unigram + bigram)

### 2. Multi-label Classification

* Logistic Regression (One-vs-Rest)
* Multinomial Naive Bayes
* Linear SVM
* Ensemble prediction

### 3. Label-based Filtering

* Predicted labels narrow down candidate papers

### 4. Semantic Similarity (🔥 Core Upgrade)

* Sentence Transformer (`all-MiniLM-L6-v2`)
* Cosine similarity on embeddings

---

## 🏗️ Project Structure

```
research-paper-recommender/
│
├── src/
│   ├── train.ipynb
│   ├── recommender.ipynb
│
├── data/            # (ignored in Git)
├── models/          # (ignored in Git)
│
├── requirements.txt
├── README.md
└── .gitignore
```

---

## 📊 Dataset

Due to size limitations, the dataset is not included.

👉 Download from: **[Add your dataset link here]**

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

## ▶️ Usage

```bash
jupyter notebook
```

Run notebooks:

1. `train.ipynb`
2. `recommender.ipynb`

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

* **F1 Micro:** ~0.70 – 0.75
* **F1 Macro:** ~0.25 – 0.30
* Strong recall and balanced predictions

---

## 🛠️ Tech Stack

* Python
* Scikit-learn
* Pandas / NumPy
* Sentence Transformers
* Cosine Similarity
* Jupyter Notebook

---

## 🔮 Future Work

* ⚡ FAISS for fast similarity search
* 🌐 FastAPI backend + frontend UI
* 📊 Hybrid ranking (recency + relevance)
* 🤖 BERT / SciBERT fine-tuning

---

## 🧠 Key Insight

> Classification predicts **“what topic”**,
> Embeddings capture **“how similar”**,
> Together → **powerful recommendation system**

---
