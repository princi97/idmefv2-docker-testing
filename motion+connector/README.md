# IDMEFv2 docker testing: Motion + IDMEFv2 connector

## Prerequisites

Before starting this application, a github repository must be cloned:
- https://github.com/IDMEFv2/idmefv2-connectors

## Services

This application defines the following services:
- `motion`: container running the Motion video surveillance software system (https://motion-project.github.io//)

> [!NOTE]
> the IDMEFv2 connector runs *inside* the `motion` container; this because the connector must have access to various locations inside the file system used by motion and redefining all these locations using docker volumes would make the `docker-compose.yml` way too complicated.

## Included services

This application includes the following services:
- `testserver`: a simple Python HTTP server validating IDMEFv2 messages received in POST requests (see [../testserver](../testserver))

## Environment variables

This application environment variables are:

| Variable                     | Required | Default value                       | Description                                                                   |
| ---------------------------- | -------- | ----------------------------------- | ----------------------------------------------------------------------------- |
| MOTION_VIDEO_DEVICE          | Yes      | None                                | Video device path (for instance `/dev/video0`)                                |
| IDMEFV2_CONNECTORS_GIT       | Yes      | None                                | Directory where `idmefv2-connectors` github repository was cloned             |
| CONNECTOR_CONFIG_FILE        | No       | `./files/motion-idmefv2.conf`       | Connector configuration file                                                  |


## Volumes

This application uses the following volumes:

| Service          | Volume type  | Source                                          | Target                                          |
| ---------------- | ------------ | ----------------------------------------------- | ----------------------------------------------- |
| motion           | volume       | `motionjson_log`                                | `/var/log/motion`                               |
| zm               | bind         | `${IDMEFV2_CONNECTORS_GIT}`                     | `/idmefv2-connectors`                           |

[^1]: directory relative to the location of the `docker-compose.yml`

## Exposed interfaces

This application exposes the following interfaces:

- http://localhost:8080/ : motion web console
- http://localhost:8081/ : Camera 1 stream

## Additional information

Application containers use logging to display their output, which can therefore be viewed using `docker logs`.
