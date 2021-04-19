#getting OS
From debian:buster

#os update and basic tools
RUN apt-get update && apt-get upgrade -y && apt-get -y install wget && apt-get -y install vim
RUN apt-get -y install php
#Installing Nginx
RUN apt-get -y install nginx
#Installing PHP
RUN apt-get -y install php7.3 php-mysql php-fpm php-pdo php-gd php-cli php-mbstring
#MySQL
RUN apt-get -y install mariadb-server

#nous met dans le bon repo
WORKDIR /var/www/html/
#on va chercher phpmyadmin
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.1/phpMyAdmin-5.0.1-english.tar.gz
RUN tar -xf phpMyAdmin-5.0.1-english.tar.gz && rm -rf phpMyAdmin-5.0.1-english.tar.gz
RUN mv phpMyAdmin-5.0.1-english phpmyadmin
#on copie le fichier de configuration de phpmyadmin dans phpmyadmin
COPY ./srcs/config.inc.php phpmyadmin
#on va chercher wordpress
RUN wget https://wordpress.org/latest.tar.gz
RUN tar -xvzf latest.tar.gz && rm -rf latest.tar.gz
#encore une fois
COPY ./srcs/wp-config.php /var/www/html
#Set up le certificat ssl
RUN openssl req -x509 -nodes -days 365 -subj "/C=FR/ST=France/L=Paris/O=42/OU=42paris/CN=localhost" -newkey rsa:2048 -keyout /etc/ssl/nginx-selfsigned.key -out /etc/ssl/nginx-selfsigned.crt;
#autorisations
RUN chown -R www-data:www-data *
RUN chmod -R 755 /var/www/*
#éxécution du bash de setup
COPY ./srcs/setup.sh ./
CMD bash setup.sh