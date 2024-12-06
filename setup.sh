#!/bin/bash

# vm-setup.sh
echo "Starting VM setup..."

# Update system
echo "Updating system packages..."
sudo apt update && sudo apt upgrade -y

# Install Git
echo "Installing Git..."
sudo apt install git -y
git --version

# Configure Git
echo "Configuring Git..."
git config --global user.name "Sam Muldrow"
git config --global user.email "smuldrow118@gmail.com"

# Generate SSH key
echo "Generating SSH key..."
ssh-keygen -t ed25519 -C "smuldrow118@gmail.com" -f ~/.ssh/id_ed25519 -N ""

# Start SSH agent and add key
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# Display public key
echo "Your SSH public key (add this to GitHub):"
cat ~/.ssh/id_ed25519.pub

# Install Docker
echo "Installing Docker..."
sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker

# Install Docker Compose
echo "Installing Docker Compose..."
sudo apt install docker-compose -y

# Add user to docker group
echo "Adding user to docker group..."
sudo usermod -aG docker $USER

# Install Node.js
echo "Installing Node.js..."
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install nodejs -y

# Verify installations
echo "Verifying installations..."
echo "Git version:"
git --version
echo "Docker version:"
docker --version
echo "Docker Compose version:"
docker-compose --version
echo "Node.js version:"
node --version
echo "npm version:"
npm --version

echo "Setup complete! Please log out and log back in for group changes to take effect."
