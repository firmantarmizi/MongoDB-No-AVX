# Use the official MongoDB 4.4 image as base
FROM mongo:4.4

# Copy the initialization script
COPY init-mongo.sh /docker-entrypoint-initdb.d/

# Set execute permissions for the init script
RUN chmod +x /docker-entrypoint-initdb.d/init-mongo.sh

# Expose MongoDB port
EXPOSE 27017

# Set the entry point
ENTRYPOINT ["mongod", "--bind_ip_all"]
