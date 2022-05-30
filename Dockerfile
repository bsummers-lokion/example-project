FROM rust:latest as builder

RUN rustup target add x86_64-unknown-linux-musl
RUN apt update && apt install -y musl-tools musl-dev
RUN update-ca-certificates

# Create a user
ENV USER=lucky
ENV UID=10001

RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "/nonexsistent" \
    --shell "/sbin/nologin" \
    --no-create-home \
    --uid "${UID}" \
    "${USER}"

WORKDIR /jackpot

COPY ./ .

RUN cargo build --target x86_64-unknown-linux-musl --release

FROM scratch

COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /etc/group /etc/group

WORKDIR /jackpot

COPY --from=builder /jackpot/target/x86_64-unknown-linux-musl/release/app ./

USER lucky:lucky

CMD ["/jackpot/app"]