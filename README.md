# 📄 Research Paper Recommendation System

A hybrid machine learning system that recommends relevant research papers based on user input (title, abstract, or keywords).
The system combines **multi-label classification** and **similarity-based retrieval** for accurate and efficient recommendations.

---

## 🚀 Features

* 🔍 Accepts flexible input (title / abstract / keywords)
* 🧠 Predicts research domains (e.g., `cs.AI`, `cs.CV`, `cs.LG`)
* 📑 Recommends top similar research papers
* ⚡ Hybrid approach: Classification + TF-IDF similarity
* 📊 Works on large-scale arXiv dataset
* 🧾 Returns detailed results including:

  * Title
  * Authors
  * Category
  * Published Date
  * Summary

---

## 🧠 Methodology

The system follows a **hybrid pipeline**:

1. **Text Vectorization**

   * TF-IDF (unigrams + bigrams)

2. **Multi-label Classification**

   * Logistic Regression (One-vs-Rest)
   * Multinomial Naive Bayes
   * Ensemble approach

3. **Label-based Filtering**

   * Predicted labels are used to narrow down search space

4. **Similarity Matching**

   * Cosine similarity applied on filtered dataset

---

## 🏗️ Project Structure

```
research-paper-recommender/
│
├── src/
│   ├── train.ipynb
│   ├── predict.ipynb
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

Due to size limitations, the dataset is not included in this repository.

👉 Download from:
**[Add your dataset link here]**

After downloading, place it in:

```
data/
```

---

## ⚙️ Installation

```bash
git clone https://github.com/Heeren10/Research-Paper_Recommendation_System.git
cd Research-Paper_Recommendation_System
pip install -r requirements.txt
```

---

## ▶️ Usage

1. Open Jupyter Notebook:

```bash
jupyter notebook
```

2. Run notebooks in order:

   * `train.ipynb`
   * `recommender.ipynb`

3. Enter a query such as:

```
deep learning for medical image analysis
```

---

## 🧪 Example Output

```
Predicted Labels: ['cs.CV', 'cs.LG']

Recommended Papers:
- Title: ...
- Authors: ...
- Category: ...
- Published Date: ...
- Summary: ...
```

---

## 📈 Results

* Micro F1 Score: ~0.65–0.75
* Macro F1 Score: ~0.20–0.30
* Balanced Precision and Recall

---

## 🛠️ Tech Stack

* Python
* Scikit-learn
* Pandas / NumPy
* TF-IDF Vectorization
* Cosine Similarity
* Jupyter Notebook

---

* 🔥 Semantic search using Sentence Transformers
* ⚡ Faster retrieval using FAISS
* 🌐 Web interface (Streamlit / React + FastAPI)
* 📊 Improved ranking (recency + relevance)
