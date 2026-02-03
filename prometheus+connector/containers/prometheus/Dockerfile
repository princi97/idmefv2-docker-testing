FROM prom/prometheus:latest

COPY ./files/prometheus.yml /etc/prometheus/prometheus.yml
COPY ./files/alert.rules.yml /etc/prometheus/alert.rules.yml

CMD [ "--config.file=/etc/prometheus/prometheus.yml", "--storage.tsdb.path=/prometheus" ]
