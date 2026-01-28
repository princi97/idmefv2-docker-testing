# IDMEFv2 docker testing: Zoneminder + IDMEFv2 connector

## Prerequisites

Before starting this application, a github repository must be cloned:
- https://github.com/IDMEFv2/idmefv2-connectors

## Services

This application defines the following services:
- `zm`: container running the Zoneminder video surveillance software system (https://zoneminder.com/)
- `db`: MySQL database server for Zoneminder

> [!NOTE]
> the IDMEFv2 connector runs *inside* the `zm` container; this because the connector must have access to various locations inside the file system used by zoneminder and redefining all these locations using docker volumes would make the `docker-compose.yml` way too complicated.

## Included services

This application includes the following services:
- `testserver`: a simple Python HTTP server validating IDMEFv2 messages received in POST requests (see [../testserver](../testserver))

## Environment variables

This application environment variables are:

| Variable                     | Required | Default value                       | Description                                                                   |
| ---------------------------- | -------- | ----------------------------------- | ----------------------------------------------------------------------------- |
| IDMEFV2_CONNECTORS_GIT       | Yes      | None                                | Directory where `idmefv2-connectors` github repository was cloned             |
| CONNECTOR_CONFIG_FILE        | No       | `./files/zoneminder-idmefv2.conf`   | Connector configuration file                                                  |
| TZ                           | Yes      | None                                | bla bla (for instance `Europe/Paris`)                                         |
| ZM_DB_HOST                   | Yes      | None                                | MySQL server hostname (for instance `db`)                                     |
| ZM_DB_PORT                   | Yes      | None                                | MySQL server port (for instance `3306`)                                       |
| ZM_DB_NAME                   | Yes      | None                                | MySQL Zoneminder database name (for instance `zm`)                            |
| ZM_DB_USER                   | Yes      | None                                | MySQL Zoneminder database user (for instance `zm`)                            |
| ZM_DB_PASS                   | Yes      | None                                | MySQL Zoneminder database password (for instance `zm`)                        |

## Volumes

This application uses the following volumes:

| Service          | Volume type  | Source                                          | Target                                          |
| ---------------- | ------------ | ----------------------------------------------- | ----------------------------------------------- |
| zm               | volume       | `zmjson_log`                                    | `/var/log/zmjson`                               |
| zm               | bind         | `${IDMEFV2_CONNECTORS_GIT}`                     | `/idmefv2-connectors`                           |
| db               | bind         | `./storage/mysql` [^1]                          | `/var/lib/mysql`                                |

[^1]: directory relative to the location of the `docker-compose.yml`

## Exposed interfaces

This application exposes the following interfaces:

- http://localhost:8080/zm/ : zoneminder web console

## Additional information

Application containers use logging to display their output, which can therefore be viewed using `docker logs`.
