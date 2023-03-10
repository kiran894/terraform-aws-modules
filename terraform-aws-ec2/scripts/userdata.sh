#! /bin/bash

sudo apt update -y

sudo apt install apache2 -y

sudo systemctl enable httpd

sudo service httpd start

sudo echo "<h1>Welcome Aboard - Impressico</h1>" | sudo tee /var/www/html/index.html
