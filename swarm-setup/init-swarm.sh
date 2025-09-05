#!/bin/bash
set -e

echo "[INFO] Installing Docker..."
sudo apt-get update -y
sudo apt-get install -y docker.io
sudo systemctl enable docker
sudo systemctl start docker

echo "[INFO] Initializing Docker Swarm..."
sudo docker swarm init --advertise-addr $(hostname -I | awk '{print $1}')

echo "[INFO] Manager node initialized. Worker join command:"
sudo docker swarm join-token worker | grep "docker swarm join"
