FROM centos:7
MAINTAINER "Lukas Rosenstock"

# Enable EPEL repository (required for lighttpd)
RUN rpm -Uvh http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

# Enable Webtatic repository (required for PHP7)
RUN rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm

# Install all required packages through yum
RUN yum install -y --exclude=httpd --skip-broken lighttpd lighttpd-fastcgi \
  php70w php70w-opcache php70w-common php70w-pecl-apcu php70w-pdo php70w-mysql \
  php70w-xml php70w-mbstring php70w-gd php70w-pecl-redis php70w-soap zip unzip

# Add configuration files
ADD lighttpd.conf.php /tmp/

# Open HTTP Port
EXPOSE 80

# Set up starter script
ADD start.sh /tmp/

# Launch starter script
CMD ["/bin/sh", "/tmp/start.sh"]
