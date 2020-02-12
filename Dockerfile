FROM alpine

ENTRYPOINT ["/entrypoint"]
RUN apk add --update git bash

COPY entrypoint /
