FROM centos:8
LABEL maintainer="Lukas Rosenstock"

# Enable Remi's repository
RUN dnf install -y dnf-utils http://rpms.remirepo.net/enterprise/remi-release-8.rpm

# Install PHP8 + modules
RUN dnf module install -y php:remi-8.0 \
  && dnf install -y php-{cli,fpm,mysqlnd,zip,devel,gd,mbstring,curl,xml,pear,bcmath,json,gmp,intl,redis,sodium}

# Install lighttpd and helper modules
RUN dnf install -y lighttpd lighttpd-fastcgi zip unzip

# Add configuration files
ADD lighttpd.conf.php /tmp/

# Open HTTP Port
EXPOSE 80

# Set up starter script
ADD start.sh /tmp/

# Launch starter script
CMD ["/bin/sh", "/tmp/start.sh"]
