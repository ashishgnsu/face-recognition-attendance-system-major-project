# Step 1: Base image jisme pehle se Python 3.11 aur saare C++ compilers hain
FROM python:3.11-slim

# Step 2: System dependencies install karna jo dlib aur OpenCV ko chahiye
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libgstreamer1.0-0 \
    libgl1-mesa-glx \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# Step 3: Working directory set karna
WORKDIR /app

# Step 4: Sabse pehle requirements copy aur install karna (taaki cache bana rahe)
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Step 5: Baki bacha saara code copy karna
COPY . .

# Step 6: Flask app run karne ke liye gunicorn use karna
CMD ["gunicorn", "--bind", "0.0.0.0:10000", "app:app"]
