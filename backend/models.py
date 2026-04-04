from sqlalchemy import Column, Integer, String, ForeignKey
from database import Base

class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    username = Column(String, unique=True)
    email = Column(String, unique=True)
    password = Column(String)


class SavedPaper(Base):
    __tablename__ = "saved_papers"

    id = Column(Integer, primary_key=True)
    user_id = Column(Integer, ForeignKey("users.id"))

    title = Column(String)
    authors = Column(String)
    category = Column(String)
    terms = Column(String)
    first_author = Column(String)
    published_date = Column(String)
    summary = Column(String)