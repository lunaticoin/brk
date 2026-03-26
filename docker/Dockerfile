FROM rust:1.93-bookworm AS builder

RUN apt-get update && apt-get install -y pkg-config libssl-dev && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY Cargo.toml Cargo.lock rust-toolchain.toml ./
COPY website website
COPY modules modules
COPY crates crates
RUN rm -rf crates/brk_website/website \
    && ln -s ../../website crates/brk_website/website \
    && rm -rf website/scripts/modules \
    && ln -s ../../modules website/scripts/modules \
    && cargo build --release --locked

FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y ca-certificates curl gosu && rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash brk

COPY --from=builder /app/target/release/brk /usr/local/bin/brk
COPY docker/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

RUN mkdir -p /home/brk/.brk

EXPOSE 3110

WORKDIR /home/brk

ENTRYPOINT ["entrypoint.sh"]
