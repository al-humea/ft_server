# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: al-humea <al-humea@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/28 15:33:23 by al-humea          #+#    #+#              #
#    Updated: 2021/04/29 16:39:34 by al-humea         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#I hate this project.
FROM debian:buster

LABEL maintainer="al-humea@student.42.fr"

RUN apt-get update && apt-get upgrade -y
RUN apt-get -y install	nginx \
						wget \
						mariadb-server

WORKDIR /var/www/html

RUN wget https://wordpress.org/latest.tar.gz
RUN tar -xzvf latest.tar.gz
RUN rm -rf latest.tar.gz

RUN openssl req -x509 -nodes -days 365 -subj "/C=FR/ST=France/L=Paris/O=42/OU=42Paris/CN=alhumea" -newkey rsa:2048 -keyout /etc/ssl/localhost.key -out /etc/ssl/localhost.crt;

COPY srcs/start.sh /var/www/html
COPY srcs/default-conf /etc/nginx/sites-available/default

CMD bash start.sh