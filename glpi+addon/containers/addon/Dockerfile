FROM ubuntu:noble

# install git and python
RUN apt-get update -qq; apt-get install -y git python3 python3-pip ; apt-get clean

# extra utils
RUN apt-get update -qq; apt-get install -y curl ; apt-get clean

COPY --chmod=0755 ./files/entrypoint.sh /
CMD [ "/entrypoint.sh" ]
