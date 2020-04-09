FROM alpine

ENTRYPOINT ["/entrypoint"]
RUN apk add --no-cache --update git bash

COPY entrypoint /
