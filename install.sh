#!/bin/bash

# Switch to superuser
sudo su

# Update package list
echo "Updating package list..."
sudo apt update

# Install AWS CLI
echo "Downloading AWS CLI..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo apt install unzip -y
echo "Unzipping AWS CLI..."
unzip awscliv2.zip
echo "Installing AWS CLI..."
sudo ./aws/install

# Install kubectl
echo "Downloading kubectl..."
curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.19.6/2021-01-05/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin
echo "kubectl installed. Version:"
kubectl version --short --client

# Install eksctl
echo "Downloading eksctl..."
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
echo "eksctl installed. Version:"
eksctl version

# Install Docker
echo "Installing Docker dependencies..."
sudo apt-get update
sudo apt-get install ca-certificates curl -y

echo "Adding Docker's official GPG key..."
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo "Adding Docker repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

echo "Installing Docker..."
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
echo "Docker installed."
