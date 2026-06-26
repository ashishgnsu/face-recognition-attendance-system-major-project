# Python 3.10 slim version use karenge
FROM python:3.10-slim

# Opencv aur image processing ke liye minimal system libraries
RUN apt-get update && apt-get install -y \
    libgl1 \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Sabse pehle requirements copy karein
COPY requirements.txt .

# requirements.txt ke packages install karein
RUN pip install --no-cache-dir -r requirements.txt

# TRICK: Pehle pre-compiled dlib-bin install karenge
RUN pip install --no-cache-dir dlib-bin

# Fir face_recognition ko bina uski dlib dependency ke forced install karenge
RUN pip install --no-cache-dir face_recognition --no-dependencies

# face_recognition ke liye jo ek baki models package bacha tha use alag se install kar denge
RUN pip install --no-cache-dir face-recognition-models

# Project ka baki code copy karein
COPY . .

CMD ["gunicorn", "--bind", "0.0.0.0:10000", "app:app"]
