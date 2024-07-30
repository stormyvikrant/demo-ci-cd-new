# Use the official Node.js image to build the app
FROM node:20 AS build

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of your application
COPY . .

# Build the Angular app
RUN npm run build --prod

# Use the official Nginx image to serve the app
FROM nginx:alpine

# Copy the built app to Nginx's HTML directory
COPY --from=build /app/dist/project1 /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
