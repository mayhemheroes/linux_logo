# Build Stage:
FROM --platform=linux/amd64 ubuntu:20.04 as builder

## Install build dependencies.
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential make

## Add Source Code
ADD . /linux_logo
WORKDIR /linux_logo

## Build Step
RUN ./configure
RUN make

# Package Stage
FROM debian:bullseye-slim
COPY --from=builder /linux_logo/linux_logo /
