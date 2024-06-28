# Use the official Nginx image from the Docker Hub
FROM nginx:latest

# Remove the default Nginx welcome page
RUN rm /usr/share/nginx/html/index.html

# Copy the custom welcome page to the Nginx directory
COPY index.html /usr/share/nginx/html/

# Expose port 80
EXPOSE 80
