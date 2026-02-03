#!/bin/sh

BACKUP="/etc/motion/motion.conf.bak"
if [ ! -f "$BACKUP" ]; then
  ./configure.sh
fi

# install IDMEFv2 connectors
cd /idmefv2-connectors
echo Installing connector dependencies
pip install --force-reinstall --editable .
# simplify path of script
rm -f /motion2json.sh
ln -s /idmefv2-connectors/idmefv2/connectors/motion/motion2json.sh /motion2json.sh

# Initialize the motion detection log file
mkdir -p /var/log/motion/
touch /var/log/motion/events.json

# start the connector
python3 -m idmefv2.connectors.motion -c /etc/motion-idmefv2.conf &

motion -n
