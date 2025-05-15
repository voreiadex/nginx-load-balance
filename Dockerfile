FROM nginx:1.25.3-alpine

# Обновляем SSL-сертификаты и добавляем инструменты для диагностики
RUN apk update && \
    apk add --no-cache \
    ca-certificates \
    curl \
    openssl && \
    rm -rf /var/cache/apk/*

# Копируем конфиг
COPY nginx.conf /etc/nginx/nginx.conf

# Тестовый скрипт для проверки подключения
RUN echo '#!/bin/sh\n\
echo "Testing SSL connections..."\n\
openssl s_client -connect pastebin-clone-1.onrender.com:443 -showcerts </dev/null\n\
openssl s_client -connect pastebin-clone-nk19.onrender.com:443 -showcerts </dev/null\n\
echo "Starting Nginx..."\n\
exec nginx -g "daemon off;"' > /docker-entrypoint.d/init.sh && \
    chmod +x /docker-entrypoint.d/init.sh

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]