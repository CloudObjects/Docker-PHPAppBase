# Docker-PHPAppBase

This is a Docker image for PHP apps. It allows deployment of source code either by mounting a folder, download at runtime from a ZIP file which can be located on any HTTP server accessible to the running container or by building a new container image using this image as the base.

## Creating compatible PHP apps

The directory structure of a PHP app compatible with this container should have a `web` directory which contains an `index.php` file. All requests for files that do not exist in the `web` directory are URL-rewritten to this entry file. Other directories can be used to store files which do not need to be exposed through the webserver, such as classes, dependencies and configuration.

## Installed packages

The image is created as an _automated build_ on the Docker Hub. At the time of writing, the latest image contains:

* CentOS 7
* [lighttpd 1.4.45](https://www.lighttpd.net/2017/1/14/1.4.45/) with mod\_fastcgi and mod\_rewrite (installed from EPEL)
* PHP 7.0.16 with opcache, pecl-apcu, pdo, mysql, xml, mbstring, gd, pecl-redis (installed from [Webtatic](https://webtatic.com))

## How to run

### Mounting external source

    docker run cloudobjects/php-app-base -p 80:80 -v /path/to/source:/var/www/app

### Deploying application from ZIP file

    docker run cloudobjects/php-app-base -p 80:80 -e PACKAGE_ZIP_URL=http://example.com/source.zip

### Building new image

    # Dockerfile
    FROM cloudobjects/php-app-base
    ADD / /var/www/app/

## Advanced configuration

You can specify the number of FastCGI PHP processes for handling incoming requests by setting the `PHP_PROCESS_COUNT` environment variable when running the container.

## Links

* [cloudobjects/php-app-base on the Docker Hub](https://hub.docker.com/r/cloudobjects/php-app-base/)
* ["Docker Base Containers" on the CloudObjects Blog](https://blog.cloudobjects.io/devops/opensource/2017/03/06/docker-base-containers/)
* ["Docker PHP App Base Container" on the CloudObjects Blog](https://blog.cloudobjects.io/devops/opensource/2017/03/23/docker-php-app-base/)