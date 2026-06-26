# Python 3.10 slim version use karenge
FROM python:3.10-slim

# Sirf opencv aur image processing ke liye zaroori minimal system libraries
RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Sabse pehle requirements copy karein
COPY requirements.txt .

# requirements.txt ke packages install karein
RUN pip install --no-cache-dir -r requirements.txt

# YAHAN HAI TRICK: Compiled dlib aur face_recognition direct install karenge
RUN pip install --no-cache-dir dlib-bin face_recognition

# Project ka baki code copy karein
COPY . .

CMD ["gunicorn", "--bind", "0.0.0.0:10000", "app:app"]
