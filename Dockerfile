FROM centos:7
LABEL maintainer="Lukas Rosenstock"

# Enable EPEL repository (required for lighttpd)
RUN rpm -Uvh http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

# Enable Webtatic repository (required for PHP7)
RUN rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm

# Install all required packages through yum
RUN yum install -y --exclude=httpd --skip-broken lighttpd lighttpd-fastcgi \
  php72w php72w-opcache php72w-common php72w-pecl-apcu php72w-pdo php72w-mysql \
  php72w-xml php72w-mbstring php72w-gd php72w-pecl-redis php72w-soap php72w-pecl-imagick zip unzip

# Add configuration files
ADD lighttpd.conf.php /tmp/

# Open HTTP Port
EXPOSE 80

# Set up starter script
ADD start.sh /tmp/

# Launch starter script
CMD ["/bin/sh", "/tmp/start.sh"]
