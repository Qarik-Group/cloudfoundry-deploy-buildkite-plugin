FROM alpine:3.11

RUN apk add --no-cache curl bash jq

# install 'cf' into /usr/bin/cf
RUN CF_CLI_VERSION=6.50.0 && \
  curl -L "https://packages.cloudfoundry.org/stable?release=linux64-binary&version=${CF_CLI_VERSION}&source=github-rel" | tar -C /usr/bin -xvz cf

WORKDIR /workspace

RUN addgroup -g 100000 buildkite && \
  adduser -G buildkite -u 100000 -D buildkite

USER buildkite
