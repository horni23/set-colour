FROM debian
USER root
RUN apt update && apt upgrade; \
    apt install -y apache2 libapache2-mod-wsgi-py3 python3-pip; \
    pip3 install flask flask_restful sqlalchemy; \
    mkdir -p /var/www/html/python/templates;
ADD board.wsgi /var/www/html/python/
ADD colour.db /var/www/html/python/
ADD templates/index.html /var/www/html/python/templates
ADD herrhornberger.de.conf /etc/apache2/sites-enabled
RUN chmod +x /var/www/html/python/board.wsgi; \
    chmod +w /var/www/html/python/colour.db; \
    chown -R www-data /var/www/html/python; \
    rm /var/www/html/index.html;
EXPOSE 80
CMD ["apachectl", "-D", "FOREGROUND"]