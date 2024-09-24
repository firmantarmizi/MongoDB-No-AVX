# Use Ubuntu as the base image
FROM ubuntu:20.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    python3 \
    python3-pip \
    build-essential \
    libssl-dev \
    libcurl4-openssl-dev \
    liblzma-dev \
    libsasl2-dev \
    libsnappy-dev \
    zlib1g-dev \
    pkg-config \
    libzstd-dev \
    patch \
    && rm -rf /var/lib/apt/lists/*

# Install scons and other Python dependencies
RUN pip3 install scons pymongo pymodm motor pymongocrypt dnspython \
    typing-extensions packaging requests pyyaml requirements-parser

# Clone MongoDB repository
RUN git clone --branch r7.0.14 https://github.com/mongodb/mongo.git /mongo
WORKDIR /mongo

# Download and apply the patch
RUN curl -sfLo mongodb-avx2.patch https://github.com/AmazedMender16/mongodb-no-avx-patch/raw/master/patches/mongodb-avx2.patch \
    && patch -p1 < mongodb-avx2.patch

# Build MongoDB
RUN python3 buildscripts/scons.py --disable-warnings-as-errors --ssl MONGO_VERSION=7.0.14 -j $(nproc) mongod

# Create a new stage for the final image
FROM ubuntu:20.04

# Copy the built MongoDB binary
COPY --from=0 /mongo/build/install/bin/mongod /usr/local/bin/

# Set up MongoDB directories
RUN mkdir -p /data/db /data/configdb \
    && chown -R root:root /data/db /data/configdb

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
