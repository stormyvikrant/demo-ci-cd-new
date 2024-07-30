# Step 1: Build the Angular application
FROM node:20 AS build
WORKDIR /app

# Copy only package.json and package-lock.json first for caching
COPY package*.json ./
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the application
RUN npm run build --prod --base-href /demo-ci-cd-new/  # Adjust base href as needed

# Step 2: Serve the Angular application using Nginx
FROM nginx:alpine

# Copy the built Angular files to Nginx html directory
COPY --from=build /app/dist/project1 /usr/share/nginx/html

# Copy the custom Nginx configuration file
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
