FROM nginx:alpine

RUN apk update && \
    apk add ca-certificates curl && \
    rm -rf /var/cache/apk/*

COPY nginx.conf /etc/nginx/nginx.conf

RUN echo '#!/bin/sh\n\
curl -vk https://pastebin-clone-1.onrender.com\n\
curl -vk https://pastebin-clone-nk19.onrender.com\n\
nginx -t\n\
nginx -g "daemon off;"' > /start.sh && \
    chmod +x /start.sh

EXPOSE 80
CMD ["/start.sh"]