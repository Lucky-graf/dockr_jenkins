FROM ubuntu/apache2:latest

RUN apt update
RUN apt -y install git
RUN rm -rf /var/www/html
RUN git clone https://github.com/Oleksandr0007/HTMLandCSS.git var/www/html
EXPOSE 80
