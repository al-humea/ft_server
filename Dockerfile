# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: al-humea <al-humea@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/28 15:33:23 by al-humea          #+#    #+#              #
#    Updated: 2021/04/29 11:51:05 by al-humea         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#I hate this project.
FROM debian:buster

LABEL maintainer="al-humea@student.42.fr"

RUN apt-get update && apt-get upgrade -y
RUN apt-get -y install	nginx \
						wget \
						mariadb-server