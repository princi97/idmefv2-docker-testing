# IDMEFv2 docker testing: ModSecurity + IDMEFv2 connector

## Prerequisites

Before starting this application, a github repository must be cloned:
- https://github.com/princi97/idmefv2-connectors.git

## Services

This application defines the following services:
- `waf`: container running ModSecurity WAF with OWASP Core Rule Set (https://github.com/coreruleset/modsecurity-crs-docker), acting as a reverse proxy.
- `app`: container running a demo application (httpbin).
- `modsecurity.idmefv2`: container running the ModSecurity IDMEFv2 connector.

## Included services

This application includes the following services:
- `testserver`: a simple Python HTTP server validating IDMEFv2 messages received in POST requests (see [../testserver](../testserver))

## Environment variables

This application environment variables are:

| Variable                     | Required | Default value                           | Description                                                                   |
| ---------------------------- | -------- | --------------------------------------- | ----------------------------------------------------------------------------- |
| IDMEFV2_CONNECTORS_GIT       | Yes      | None                                    | Directory where `idmefv2-connectors` github repository was cloned             |
| CONNECTOR_CONFIG_FILE        | No       | `./files/modsecurity-idmefv2.conf`      | Connector configuration file                                                  |

## Volumes

This application uses the following volumes:

| Service              | Volume type  | Source                                          | Target                                          |
| -------------------- | ------------ | ----------------------------------------------- | ----------------------------------------------- |
| waf                  | bind         | `./logs/modsec_audit.log`                       | `/var/log/modsec_audit.log`                     |
| waf                  | bind         | `./logs/modsec_error.log`                       | `/var/log/modsec_error.log`                     |
| modsecurity.idmefv2  | bind         | `${IDMEFV2_CONNECTORS_GIT}`                     | `/idmefv2-connectors`                           |
| modsecurity.idmefv2  | bind         | `./logs/modsec_audit.log`                       | `/var/log/modsec_audit.log`                     |

## Exposed interfaces

| Service | Port  | Description                                      |
| ------- | ----- | ------------------------------------------------ |
| waf     | 8080  | WAF Reverse Proxy (protects the demo app on 80)  |

## Additional information

Application containers use logging to display their output, which can therefore be viewed using `docker logs`.

The ModSecurity connector tails the `modsec_audit.log` file (in JSON format) to detect security events and converts them to IDMEFv2 format. The WAF is configured to write audit logs to this shared file.
