#adapted from https://github.com/mpg-age-bioinformatics/software/blob/main/modkit/0.5.0/Dockerfile
FROM rust:1.91.1-slim AS builder
WORKDIR /workspace

RUN apt-get update && \
    apt-get install -y --no-install-recommends git build-essential pkg-config libssl-dev && \
    git clone --branch v0.6.0 https://github.com/nanoporetech/modkit.git . && \
    cargo build --release

# now smaller image in which we can run modkit
FROM debian:trixie-slim

COPY --from=builder /workspace/target/release/modkit /usr/local/bin/modkit
