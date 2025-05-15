FROM nginx:alpine


RUN apk update && \
    apk add --no-cache ca-certificates curl && \
    rm -rf /var/cache/apk/*


COPY nginx.conf /etc/nginx/nginx.conf

RUN echo '#!/bin/sh\n\
echo "Testing server connections..."\n\
curl -vk https://pastebin-clone-1.onrender.com || true\n\
curl -vk https://pastebin-clone-nk19.onrender.com || true\n\
echo "Starting Nginx..."\n\
exec nginx -g "daemon off;"' > /docker-entrypoint.d/start.sh && \
    chmod +x /docker-entrypoint.d/start.sh

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]