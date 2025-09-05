#!/bin/bash
set -e

echo "[INFO] Installing Docker..."
sudo apt-get update -y
sudo apt-get install -y docker.io
sudo systemctl enable docker
sudo systemctl start docker

echo "[INFO] Joining Swarm..."
# Replace this with the actual join command from manager output
# Example:
# sudo docker swarm join --token <TOKEN> <MANAGER-IP>:2377
