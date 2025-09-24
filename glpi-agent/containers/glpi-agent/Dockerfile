FROM ubuntu:noble

ARG GLPI_AGENT_INSTALLER_URL

ADD ${GLPI_AGENT_INSTALLER_URL} /tmp/glpi-agent-linux-installer.pl

# install dmidecode
RUN apt-get update -qq; apt-get install -y dmidecode ; apt-get clean

# RUN perl /tmp/glpi-agent-linux-installer.pl

CMD ["sleep", "infinity"]
