FROM alpine:3.19
LABEL maintainer "Mikael Lognseth"

RUN apk add --no-cache postfix \
    && /usr/bin/newaliases

COPY . /

EXPOSE 25

ENTRYPOINT [ "/smtp-relay.sh" ]
