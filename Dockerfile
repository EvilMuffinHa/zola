FROM rust:slim AS builder

RUN apt-get update -y && \
  apt-get install -y make g++ libssl-dev

WORKDIR /app
COPY . .

RUN cargo build --release


FROM gcr.io/distroless/cc
COPY --from=builder /app/target/release/zola /bin/zola
ENTRYPOINT [ "/bin/zola" ]
