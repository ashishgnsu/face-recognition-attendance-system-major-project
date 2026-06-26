# Python 3.10 image use karein (Kyunki aapka system Python 3.10 par hai)
FROM python:3.10-slim

# Linux ke zaroori tools aur C++ compiler install karein dlib ke liye
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libopenblas-dev \
    liblapack-dev \
    libx11-dev \
    libgtk-3-dev \
    && rm -rf /var/lib/apt/lists/*

# Work directory set karein
WORKDIR /app

# Sabse pehle requirements copy aur install karein
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Ab dlib aur face_recognition install karein (bina wheel file ke)
RUN pip install --no-cache-dir dlib face_recognition

# Pura project code copy karein
COPY . .

# Gunicorn ke zariye Flask app ko run karein
CMD ["gunicorn", "--bind", "0.0.0.0:10000", "app:app"]
