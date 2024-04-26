#!/bin/bash
apt update -y
apt install fontconfig openjdk-17-jre -y
wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
apt-get update -y
apt-get install jenkins -y

# Install Python3 and pip3 (if not already installed)
apt install python3-pip -y

# Install AWS CLI
pip3 install awscli

apt update
apt install docker.io -y
