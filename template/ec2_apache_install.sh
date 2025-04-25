#!/bin/bash

# Update system packages
sudo apt update -y

# Install Python 3, pip, and virtualenv
sudo apt install -y python3 python3-pip python3-virtualenv git

# Go to the home directory
cd /home/ubuntu

# Create a virtual environment named 'flask'
virtualenv flask

# Activate the virtual environment
source flask/bin/activate

# Clone the Flask + MySQL project repo
git clone https://github.com/rahulwagh/python-mysql-db-proj-1.git

# Sleep for 20 seconds (optional, wait for repo to clone properly)
sleep 20

# Change to the project directory
cd python-mysql-db-proj-1

# Install Flask and other dependencies from requirements.txt
pip install -r requirements.txt

# Install any additional missing packages manually if needed
# pip install pymysql

# Wait for 30 seconds before running the app
echo 'Waiting for 30 seconds before running the app.py'
sleep 30

# Run the app.py in the background
setsid python3 -u app.py &

# Final message
echo "✅ Flask app is now running in the background."
