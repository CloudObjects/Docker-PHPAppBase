FROM centos:7
MAINTAINER "Lukas Rosenstock"

# Enable EPEL repository (required for lighttpd)
RUN rpm -Uvh http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

# Enable Webtatic repository
RUN rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm

# Install all required packages through yum
RUN yum install -y --exclude=httpd --skip-broken lighttpd lighttpd-fastcgi \
  php56w php56w-opcache php56w-common php56w-pecl-apcu php56w-pdo php56w-mysql \
  php56w-xml php56w-mbstring php56w-gd php56w-pecl-redis php56w-pecl-gearman \
  libgearman unzip

# Add configuration files
ADD lighttpd.conf.php /tmp/

# Open HTTP Port
EXPOSE 80

# Set up starter script
ADD start.sh /tmp/

# Launch starter script
CMD ["/bin/sh", "/tmp/start.sh"]
