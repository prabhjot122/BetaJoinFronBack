#!/bin/bash
set -e

# Variables (update these if your paths are different)
FRONTEND_DIR=~/JoiningBetarepo/Frontend/Beta-Frontend2
FRONTEND_BUILD_DIR=$FRONTEND_DIR/build/client
BACKEND_FRONTEND_DIR=~/JoiningBetarepo/Frontend/Beta-Frontend2
DOCKER_COMPOSE_FILE=~/JoiningBetarepo/docker-compose.prod.external-mysql-linux.yml

# 1. Build the frontend
cd $FRONTEND_DIR
echo "[1/4] Installing frontend dependencies..."
npm install

echo "[2/4] Building frontend..."
npm run build

# 2. Copy build to backend repo
mkdir -p $BACKEND_FRONTEND_DIR
echo "[3/4] Copying build to backend repo..."
cp -r $FRONTEND_BUILD_DIR/* $BACKEND_FRONTEND_DIR/

# 3. Rebuild and restart Docker
cd $BACKEND_DIR
echo "[4/4] Rebuilding and restarting Docker containers..."
docker-compose -f $DOCKER_COMPOSE_FILE build
docker-compose -f $DOCKER_COMPOSE_FILE up -d

echo "=== Frontend deployed and served via Docker Nginx! ==="
echo "Visit: https://www.lawvriksh.com" 
