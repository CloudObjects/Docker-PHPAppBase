FROM centos:7
MAINTAINER "Lukas Rosenstock"

# Enable EPEL repository (required for lighttpd)
RUN rpm -Uvh http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

# Enable Webtatic repository (required for PHP7)
RUN rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm

# Install all required packages through yum
RUN yum install -y --exclude=httpd --skip-broken lighttpd lighttpd-fastcgi \
  php71w php71w-opcache php71w-common php71w-pecl-apcu php71w-pdo php71w-mysql \
  php71w-xml php71w-mbstring php71w-gd php71w-pecl-redis php71w-soap zip unzip

# Add configuration files
ADD lighttpd.conf.php /tmp/

# Open HTTP Port
EXPOSE 80

# Set up starter script
ADD start.sh /tmp/

# Launch starter script
CMD ["/bin/sh", "/tmp/start.sh"]
