#!/bin/bash

#Apache instull

sudo apt update
sudo apt install apache2
sudo ufw app list
sudo ufw allow 'Apache'
sudo ufw status
sudo systemctl status apache2
echo Apache instull successful!



#take info from users

read -p "Input name your site(It is name your repository):" NAMESITE
read -p "Addres link on your site:" GITLINK
read -p "Addres domen on your site (site.com):" DNSNAME
read -p "Add your email(email@posht.com):" EMAIL
read -p "Input name user: " USERNAME

VAR='${APACHE_LOG_DIR}'

#config file

sudo cat > /etc/apache2/sites-available/$DNSNAME.conf << EOF
<VirtualHost *:80>
ServerAdmin $EMAIL
ServerName $DNSNAME
ServerAlias www.$DNSNAME
DocumentRoot /var/www/$NAMESITE
ErrorLog $VAR/error.log
CustomLog $VAR/access.log combined
</VirtualHost>
EOF

#setting folder for site and clone


sudo git clone $GITLINK /var/www/$NAMESITE
chown -R $USERNAME:$USERNAME /var/www/$NAMESITE
sudo chmod -R 755 /var/www/$NAMESITE #your_domain


#configure apach

sudo a2ensite $DNSNAME.conf
sudo a2dissite 000-default.conf
sudo service apache2 restart


#install PHP

sudo apt install php7.4 php7.4-mysql php-common php7.4-cli php7.4-json php7.4-common php7.4-opcache libapache2-mod-php7.4
sudo systemctl restart apache2
echo '<?php phpinfo(); ?>' | sudo tee -a /var/www/$NAMESITE/phpinfo.php > /dev/null
sudo rm -rf /var/www/$NAMESITE/phpinfo.php

#install mysql

sudo apt install mariadb-server mariadb-client
sudo systemctl status mariadb
sudo mysql_secure_installation

#install Doker and Doker compous

sudo apt-get update
sudo apt-get install \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg \
  lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
sudo docker run hello-world
sudo apt-get update

#Install Doker Compouse

sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
docker-compose --version
sudo usermod -aG docker ${USER}


