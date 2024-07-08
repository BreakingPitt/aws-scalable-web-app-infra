#!/bin/bash

# Update package list and upgrade all packages
yum update -y

# Install nginx and php 
yum install -y nginx php-fpm php-zlib php-iconv php-gd php-mbstring php-fileinfo php-curl php-mysql

# Download and install latest wordpress version from wordpress.org
wget www.wordpress.org/latest.zip
unzip latest.zip
rm latest.zip
mv wordpress/* html/
rm -r latest.zip wordpress

# Ensure nginx and mysql services are enabled and running
systemctl enable nginx
systemctl start nginx

# Create a basic PHP info page to test PHP processing
echo "<?php phpinfo(); ?>" > /var/www/html/info.php

# Set proper permissions for web root directory
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

# Notify that the configuration script is done
echo "The system is updated and the LEMP stack (Nginx, PHP, MySQL) is installed"
