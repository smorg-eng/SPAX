#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}Stopping any running containers...${NC}"
docker-compose down

echo -e "${GREEN}Removing old volumes...${NC}"
docker volume rm $(docker volume ls -q) 2>/dev/null || true

echo -e "${GREEN}Building fresh containers...${NC}"
docker-compose build

echo -e "${GREEN}Starting containers...${NC}"
docker-compose up -d

# Wait for containers to be healthy
echo -e "${GREEN}Waiting for containers to be ready...${NC}"
sleep 5

# Check container status
if [ "$(docker-compose ps --status running | wc -l)" -gt 1 ]; then
    echo -e "${GREEN}All containers are running!${NC}"
    docker-compose ps
else
    echo -e "${RED}Some containers failed to start. Check logs:${NC}"
    docker-compose logs
fi