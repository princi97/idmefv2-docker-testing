FROM ubuntu:noble

RUN apt-get update -qq; apt-get install -y clamav clamav-freshclam clamav-testfiles clamav-daemon clamdscan ; apt-get clean

RUN freshclam

CMD [ "sleep", "infinity"]
