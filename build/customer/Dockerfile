FROM php:5.6-cli
LABEL maintainer="RezaB r-beygi@hotmail.com"

#RUN apt-get update && apt-get install -y php5-mysql php5-gd libapache2-mod-php5 apache2

COPY a2billing.conf /etc/
COPY customer /var/www/a2billing/
RUN chown -R www-data:www-data /var/www/a2billing