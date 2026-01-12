#! /bin/sh

set -e

# install IDMEFv2 connectors
cd /idmefv2-connectors
pip install --force-reinstall --editable .

# Prepare log file (path is defined in connector configuration file)
mkdir -p /var/log/idmefv2
touch /var/log/idmefv2/zoneminder-connector.log
chown www-data.www-data -R /var/log/idmefv2

# run the zobeminder startup script
/etc/my_init.d/startup.sh
