FROM alpine:latest

ENV TZ=Australia/Sydney

RUN apk update && \
    apk add --no-cache apache2 && \
    rm -rf /var/cache/apk/* && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apk add --no-cache python3 py3-pip && \
    pip3 install awscli

RUN aws s3 cp s3://belong-coding-challenge/belong-test.html /var/www/localhost/htdocs/ --region ap-southeast-2

EXPOSE 80 443

RUN addgroup -S appgroup && \
    adduser -S appuser -G appgroup

USER appuser

CMD ["httpd", "-D", "FOREGROUND"]
