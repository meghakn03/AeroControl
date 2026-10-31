FROM ghcr.io/cirruslabs/flutter:3.29.3 AS builder
WORKDIR /app
COPY frontend .
RUN flutter pub get && flutter build web --release --pwa-strategy=none --dart-define=API_URL=/
FROM nginx:1.27-alpine
COPY deploy/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/build/web /usr/share/nginx/html
EXPOSE 80
