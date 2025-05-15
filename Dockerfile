FROM nginx:1.25-alpine 

RUN apk add --no-cache ca-certificates

COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]