# Stage 1: Build the Express app
FROM node:18 AS builder

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

# Stage 2: Serve with Nginx as a proxy
FROM nginx:alpine

# Copy Nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80
EXPOSE 80

# Stage 3: Run the Express app
FROM node:18

WORKDIR /app

COPY --from=builder /app /app

EXPOSE 3000

CMD ["npm", "start"]
