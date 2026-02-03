# IDMEFv2 docker testing: Prometheus + IDMEFv2 connector

## Prerequisites

Before starting this application, a github repository must be cloned:
- https://github.com/princi97/idmefv2-connectors.git

## Services

This application defines the following services:
- `prometheus`: container running Prometheus monitoring system (https://prometheus.io/)
- `prometheus.idmefv2`: container running the Prometheus IDMEFv2 connector

## Included services

This application includes the following services:
- `testserver`: a simple Python HTTP server validating IDMEFv2 messages received in POST requests (see [../testserver](../testserver))

## Environment variables

This application environment variables are:

| Variable                     | Required | Default value                           | Description                                                                   |
| ---------------------------- | -------- | --------------------------------------- | ----------------------------------------------------------------------------- |
| IDMEFV2_CONNECTORS_GIT       | Yes      | None                                    | Directory where `idmefv2-connectors` github repository was cloned             |
| CONNECTOR_CONFIG_FILE        | No       | `./files/prometheus-idmefv2.conf`       | Connector configuration file                                                  |

## Volumes

This application uses the following volumes:

| Service              | Volume type  | Source                                          | Target                                          |
| -------------------- | ------------ | ----------------------------------------------- | ----------------------------------------------- |
| prometheus           | bind         | `./containers/prometheus/files/prometheus.yml`  | `/etc/prometheus/prometheus.yml`                |
| prometheus           | bind         | `./containers/prometheus/files/alert.rules.yml` | `/etc/prometheus/alert.rules.yml`               |
| prometheus.idmefv2   | bind         | `${IDMEFV2_CONNECTORS_GIT}`                     | `/idmefv2-connectors`                           |

## Exposed interfaces

| Service    | Port  | Description                |
| ---------- | ----- | -------------------------- |
| prometheus | 9592  | Prometheus web UI and API  |

## Additional information

Application containers use logging to display their output, which can therefore be viewed using `docker logs`.

The Prometheus connector polls the Prometheus API at `/api/v1/alerts` endpoint to retrieve active alerts and converts them to IDMEFv2 format. The polling interval can be configured in the connector configuration file.
