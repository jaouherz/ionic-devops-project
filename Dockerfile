# Stage 1: Build Ionic app
FROM node:22-alpine as builder
WORKDIR /app
COPY package*.json ./
RUN npm install -g @ionic/cli
RUN npm install
COPY . .
RUN ionic build --prod

# Stage 2: Serve with nginx
FROM nginx:alpine
COPY --from=builder /app/www /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
