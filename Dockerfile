FROM golang:stretch

ENV MM_INSTANCE=""
ENV MM_SERVERNAME=""
ENV MM_ACESS_TOKEN=""
ENV MM_USERNAME=""
ENV MM_PASSWORD=""
ENV SLEEPTIMERSEC=3
ENV RUNOVERSEC=1800

RUN apt-get update -y && apt-get dist-upgrade -y && apt-get install jq -y
RUN go get -u github.com/mattermost/mmctl

WORKDIR /mmscripts

COPY start.sh /mmscripts/
RUN chmod +x start.sh


ENTRYPOINT ["/mmscripts/start.sh"]
