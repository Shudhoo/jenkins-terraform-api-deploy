#!/bin/bash

sudo apt update -y
sudo apt install -y python3 python3-pip python3-virtualenv git
cd /home/ubuntu
virtualenv flask
source flask/bin/activate
git clone https://github.com/rahulwagh/python-mysql-db-proj-1.git
sleep 20


cd python-mysql-db-proj-1
pip install -r requirements.txt
echo 'Waiting for 30 seconds before running the app.py'
sleep 30
setsid python3 -u app.py &

echo "Flask app is now running in the background."
