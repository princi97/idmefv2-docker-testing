FROM ubuntu:noble

RUN apt-get update -qq; apt-get install -y openssh-server rsyslog ; apt-get clean

RUN mkdir /var/run/sshd ; chmod 0755 /var/run/sshd

COPY --chmod=0644 ./files/rsyslog.conf /etc
COPY --chmod=0755 ./files/entrypoint.sh /

EXPOSE 22

CMD ["/entrypoint.sh"]
