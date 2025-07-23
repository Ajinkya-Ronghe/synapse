#!/bin/bash
set -e

echo "🔧 Installing dependencies..."
sudo apt update
sudo apt install -y lsb-release curl gnupg python3-pip virtualenv libffi-dev libssl-dev python3-dev libjpeg-dev build-essential unzip wget

echo "📦 Adding Matrix Synapse repo..."
curl -fsSL https://packages.matrix.org/debian/matrix-org-archive-keyring.gpg | sudo tee /usr/share/keyrings/matrix-org-archive-keyring.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/matrix-org-archive-keyring.gpg] https://packages.matrix.org/debian/ $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/matrix-org.list
sudo apt update

echo "🚀 Installing Synapse..."
sudo apt install -y matrix-synapse

echo "🔐 Registering default admin user..."
sudo register_new_matrix_user -u admin -p adminpass -a -c /etc/matrix-synapse/homeserver.yaml http://localhost:8008

echo "🔄 Restarting Synapse..."
sudo systemctl enable matrix-synapse
sudo systemctl restart matrix-synapse

echo "🌍 Setting up Ngrok tunnel..."
wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-stable-linux-amd64.zip
unzip ngrok-stable-linux-amd64.zip
./ngrok authtoken usr_2ytn2obYanPjUqXBd9CiwFXdwLM
./ngrok http 8008
