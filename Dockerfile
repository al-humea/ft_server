# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: al-humea <al-humea@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/28 09:06:41 by al-humea          #+#    #+#              #
#    Updated: 2021/04/28 09:14:55 by al-humea         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

#MAJ + utilitaire
RUN apt-get update && apt-get install -y procps && apt-get install nano && apt-get install -y wget
#PHP + NGINX + MYSQL
RUN apt-get -y install php7.3-fpm php7.3-common php7.3-mysql php7.3-gmp php7.3-curl php7.3-intl php7.3-mbstring php7.3-xmlrpc php7.3-gd php7.3-xml php7.3-cli php7.3-zip php7.3-soap php7.3-imap
RUN apt-get -y install wget
RUN apt-get -y install nginx
RUN apt-get -y install mariadb-server

COPY ./srcs/setup_container.sh ./
COPY ./srcs/nginx.conf ./tmp/nginx-conf
COPY ./srcs/config.inc.php ./tmp/config.inc.php
COPY ./srcs/wp-config.php ./tmp/wp-config.php

CMD bash setup_container.sh