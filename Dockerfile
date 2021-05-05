# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: al-humea <al-humea@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/28 15:33:23 by al-humea          #+#    #+#              #
#    Updated: 2021/05/05 23:34:52 by al-humea         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#I hate this project.
FROM debian:buster

LABEL maintainer="al-humea@student.42.fr"

RUN apt-get update && apt-get upgrade -y
RUN apt-get -y install	nginx \
						wget \
						mariadb-server
RUN apt-get -y install php
RUN apt-get -y install php7.3-fpm php7.3-common php7.3-mysql php7.3-gmp php7.3-curl php7.3-intl php7.3-mbstring php7.3-xmlrpc php7.3-gd php7.3-xml php7.3-cli php7.3-zip php7.3-soap php7.3-imap


RUN mkdir /var/www/coolwebsite
WORKDIR /var/www/coolwebsite
RUN touch info.php && echo "<?php phpinfo(); ?>" >> info.php


#downloading phpmyadmin
RUN mkdir phpmyadmin
RUN  wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
RUN tar -xvf phpMyAdmin-4.9.0.1-all-languages.tar.gz --strip-components 1 -C /var/www/coolwebsite/phpmyadmin
RUN rm -rf phpMyAdmin-4.9.0.1-all-languages.tar.gz

#downloading wordpress
RUN wget https://wordpress.org/latest.tar.gz
RUN tar -xzvf latest.tar.gz
RUN rm -rf latest.tar.gz

#creating ssl key
RUN mkdir /etc/nginx/ssl
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/nginx/ssl/coolwebsite.pem -keyout /etc/nginx/ssl/coolwebsite.key -subj "/C=FR/ST=Paris/L=Paris/O=42Paris/OU=alhumea/CN=coolwebsite"

#Copying my srcs to correct locations + removing default site enabled on port 80
COPY srcs/start.sh /var/www/coolwebsite
COPY srcs/default-conf /etc/nginx/sites-available/coolwebsite
COPY srcs/wp-config.php /var/www/coolwebsite/wordpress/.
COPY srcs/phpmyadmin.inc.php /var/www/coolwebsite/phpmyadmin/config.inc.php

#Enabling coolwebsite / disabling default one
RUN ln -s /etc/nginx/sites-available/coolwebsite /etc/nginx/sites-enabled/coolwebsite
RUN rm /etc/nginx/sites-enabled/default

#Env var for auto index
ENV NGINX_AUTOINDEX=1

CMD bash start.sh