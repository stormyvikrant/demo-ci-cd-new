# Step 1: Build the Angular application
FROM node:20 AS build

# Set the working directory
WORKDIR /demoapp

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application files
COPY . .

# Build the application for production
RUN npm run build --prod

# Step 2: Serve the application using a web server
FROM nginx:alpine

# Copy the build output to the Nginx HTML folder
COPY --from=build /app/dist/project1 /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
