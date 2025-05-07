# Stage 1: Build the React app
FROM node:18 AS build

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2: Serve the app with nginx
FROM nginx:stable-alpine

# Copy build output to nginx html dir
COPY --from=build /app/build /usr/share/nginx/html

# Replace default nginx config with custom one
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
