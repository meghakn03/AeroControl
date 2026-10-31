FROM rust:1.85.1-bookworm AS builder
WORKDIR /app
COPY Cargo.toml Cargo.lock ./
COPY proto proto
COPY backend backend
RUN cargo build --release --locked -p aerocontrol
FROM debian:bookworm-slim
RUN useradd --system --uid 10001 aero
COPY --from=builder /app/target/release/aerocontrol /usr/local/bin/aerocontrol
USER aero
ENV AEROCONTROL_ADDR=0.0.0.0:50051
EXPOSE 50051
ENTRYPOINT ["aerocontrol"]
