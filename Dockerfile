FROM rust:1.61-alpine3.14 as builder

RUN USER=root cargo new --bin example-project
WORKDIR ./example-project
COPY ./Cargo.toml ./Cargo.toml
RUN cargo build --release
RUN rm src/*.rs
ADD . ./
RUN rm ./target/release/example-project*
RUN cargo build --release

FROM debian:buster-slim
ARG APP=/usr/src/app
RUN apt-get update \
    && apt-get install -y ca-certificates tzdata \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 8000

ENV TZ=Etc/UTC \
    APP_USER=appuser

RUN groupadd $APP_USER \
    && useradd -g $APP_USER $APP_USER \
    && mkdir -p ${APP}

COPY --from=builder /example-project/target/release/example-project ${APP}/example-project

RUN chown -R $APP_USER:$APP_USER ${APP}

USER $APP_USER
WORKDIR ${APP}

CMD ["./example-project"]