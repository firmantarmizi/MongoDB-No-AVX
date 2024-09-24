# MongoDB 4.4 for UniFi Controller

This repository contains a Dockerfile for running MongoDB 4.4, specifically configured for use with UniFi Controller. It's designed to be deployed using Easypanel on your server.

## Contents

- `Dockerfile`: Sets up MongoDB 4.4 with configurations suitable for UniFi Controller.
- `init-mongo.sh`: Initialization script for MongoDB.

## Features

- MongoDB 4.4
- Pre-configured for UniFi Controller
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

This image uses MongoDB 4.4, which is known to be compatible with UniFi Controller. It does not require AVX support, making it suitable for a wide range of CPU architectures.

## License

This project is open-source and available under the [MIT License](LICENSE).
