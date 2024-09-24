# Use the official MongoDB 4.4 image as base
FROM mongo:4.4

# Set environment variables
ENV MONGO_INITDB_ROOT_USERNAME=${MONGO_INITDB_ROOT_USERNAME}
ENV MONGO_INITDB_ROOT_PASSWORD=${MONGO_INITDB_ROOT_PASSWORD}
ENV MONGO_USER=${MONGO_USER}
ENV MONGO_PASS=${MONGO_PASS}
ENV MONGO_DBNAME=${MONGO_DBNAME}
ENV MONGO_AUTHSOURCE=${MONGO_AUTHSOURCE}

# Copy the initialization script
COPY init-mongo.sh /docker-entrypoint-initdb.d/

# Set execute permissions for the init script
RUN chmod +x /docker-entrypoint-initdb.d/init-mongo.sh

# Expose MongoDB port
EXPOSE 27017

# Set the entry point
ENTRYPOINT ["mongod", "--bind_ip_all"]
