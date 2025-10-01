# ===== STAGE 1: Build Ionic App =====
FROM node:22.13.1 as build

# Set working directory
WORKDIR /app

# Copy dependency files and install dependencies
COPY package*.json ./
RUN npm install -g @ionic/cli
RUN npm install

# Copy the rest of the app files
COPY . .

# Build Ionic app
RUN ionic build --prod

# ===== STAGE 2: Serve with Nginx =====
FROM nginx:alpine

# Copy built app from first stage
COPY --from=build /app/www /usr/share/nginx/html

# Expose HTTP port
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
