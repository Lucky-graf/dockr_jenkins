#!/bin/bash

#install jenkins
sudo apt-get update
sudo apt upgrade
sudo apt search openjdk
sudo apt install openjdk-11-jdk
sudo apt install openjdk-11-jdk
sudo apt install ca-certificates
sudo wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get install jenkins
sudo apt-get update
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
sudo service jankinse status
