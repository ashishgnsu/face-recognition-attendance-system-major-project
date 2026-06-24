# Step 1: AI/Data Science ki pre-built image use karna jisme dlib, cmake sab pehle se hai
FROM datamachines/cudagl-tensorflow-opencv:11.4.2-2.7.0-gpu-ubuntu20.04

# Step 2: Set working directory
WORKDIR /app

# Step 3: Python default setup aur pip upgrade
RUN apt-get update && apt-get install -y python3-pip && \
    pip3 install --no-cache-dir --upgrade pip

# Step 4: Requirements copy aur baki bache packages install karna
COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt

# Step 5: Python bindings aur face_recognition setup
RUN pip3 install --no-cache-dir face_recognition

# Step 6: Code copy karna
COPY . .

# Step 7: App run gunicorn ke sath
CMD ["gunicorn", "--bind", "0.0.0.0:10000", "app:app"]
