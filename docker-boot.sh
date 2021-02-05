#!/bin/sh

#docker run -d -p 80:80 -p 443:443 \
#    --name nginx \
#    -v $(pwd)/nginx/conf.d:/etc/nginx/conf.d:ro \
#    -v $(pwd)/nginx/htpasswd:/etc/nginx/htpasswd:ro \
#    -v $(pwd)/nginx/certs:/etc/nginx/certs:ro \
#    -v $(pwd)/nginx/vhost.d:/etc/nginx/vhost.d:ro \
#    -v $(pwd)/nginx/html:/usr/share/nginx/html:ro \
#    nginx
#
#docker run -d \
#    --name nginx-gen \
#    --volumes-from nginx \
#    -v $(pwd)/nginx/conf.d:/etc/nginx/conf.d:rw \
#    -v /var/run/docker.sock:/tmp/docker.sock:ro \
#    -v $(pwd)/docker-gen/nginx.tmpl:/etc/docker-gen/templates/nginx.tmpl:ro \
#    -e "DEFAULT_HOST=zeropage.org" \
#    jwilder/docker-gen -notify-sighup nginx -watch /etc/docker-gen/templates/nginx.tmpl /etc/nginx/conf.d/default.conf

docker run -d -p 80:80 -p 443:443 \
    --name nginx-proxy \
    -v $(pwd)/nginx/htpasswd:/etc/nginx/htpasswd:ro \
    -v $(pwd)/nginx/certs:/etc/nginx/certs:ro \
    -v $(pwd)/nginx/vhost.d:/etc/nginx/vhost.d:ro \
    -v $(pwd)/nginx/html:/usr/share/nginx/html:ro \
    -v $(pwd)/docker-gen/nginx.tmpl:/app/nginx.tmpl:ro \
    -v /var/run/docker.sock:/tmp/docker.sock:ro \
    jwilder/nginx-proxy

docker run -d \
    --name nginx-letsencrypt \
    -v $(pwd)/nginx/certs:/etc/nginx/certs:rw \
    -v $(pwd)/nginx/vhost.d:/etc/nginx/vhost.d:rw \
    -v $(pwd)/nginx/html:/usr/share/nginx/html:rw \
    -v /var/run/docker.sock:/var/run/docker.sock:ro \
    -e NGINX_PROXY_CONTAINER=nginx-proxy \
    jrcs/letsencrypt-nginx-proxy-companion

docker run -d \
    --name xpressengine \
    -v /data/xpressengine/app:/var/www/html:ro \
    -v /data/xpressengine/files:/var/www/html/files:rw \
    -e VIRTUAL_PROTO=fastcgi \
    -e VIRTUAL_PORT=9000 \
    -e "VIRTUAL_HOST=zeropage.org,www.zeropage.org" \
    -e "VIRTUAL_ROOT=/var/www/html" \
    -e "LETSENCRYPT_HOST=zeropage.org,www.zeropage.org" \
    -e "LETSENCRYPT_EMAIL=zeropage@zeropage.org" \
    php:5.5-fpm

docker run -d \
    --name moniwiki \
    -v /data/moniwiki/app:/var/www/html:ro \
    -v /data/moniwiki/data:/var/www/html/data:rw \
    -v /data/moniwiki/pds:/var/www/html/pds:rw \
    -v /data/moniwiki/_cache:/var/www/html/_cache:rw \
    -e VIRTUAL_PROTO=fastcgi \
    -e VIRTUAL_PORT=9000 \
    -e "VIRTUAL_HOST=wiki.zeropage.org" \
    -e "VIRTUAL_ROOT=/var/www/html" \
    -e "LETSENCRYPT_HOST=wiki.zeropage.org" \
    -e "LETSENCRYPT_EMAIL=zeropage@zeropage.org" \
    php:5.5-fpm
