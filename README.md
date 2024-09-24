# MongoDB No AVX

This repository contains a Dockerfile for building MongoDB without AVX support. It's designed to be deployed using Easypanel on your server.

## Contents

- `Dockerfile`: Builds MongoDB 7.0.14 from source with a patch to disable AVX support.
- `init-mongo.sh`: Initialization script for MongoDB.

## Features

- MongoDB 7.0.14 built from source
- AVX support disabled
- Initialization script included for first-time setup

## Deployment with Easypanel

To deploy this MongoDB image using Easypanel:

1. Fork this repository to your GitHub account.
2. In Easypanel, create a new service.
3. Choose "GitHub" as the deployment method.
4. Select this repository and the branch you want to deploy.
5. Configure the following environment variables:
   - `MONGO_INITDB_ROOT_USERNAME`: Root username for MongoDB
   - `MONGO_INITDB_ROOT_PASSWORD`: Root password for MongoDB
   - `MONGO_USER`: Username for the UniFi database
   - `MONGO_PASS`: Password for the UniFi database
   - `MONGO_DBNAME`: Name of the UniFi database (usually 'unifi')
   - `MONGO_AUTHSOURCE`: Authentication source (usually 'admin')
6. Set the port to 27017.
7. Deploy the service.

## Connecting to UniFi Controller

Ensure that your UniFi Controller is configured to use this MongoDB instance. You may need to update the MongoDB connection settings in your UniFi Controller configuration.

## Note

This image is built without AVX support, which may affect performance but increases compatibility with older CPU architectures.

## License

This project is open-source and available under the [MIT License](LICENSE).
