#!/bin/bash

set -e

# install IDMEFv2 connectors
cd /idmefv2-connectors
pip install --break-system-packages --force-reinstall .

python3 -m idmefv2.connectors.wazuh -c /etc/wazuh-idmefv2.conf
