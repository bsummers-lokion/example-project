FROM rust as planner
WORKDIR app
RUN cargo install cargo-chef
COPY . .
RUN cargo chef prepare --recipe-path recipe.json

FROM rust as cacher
WORKDIR app
RUN cargo install cargo-chef
COPY --from=planner /app/recipe.json recipe.json
RUN cargo chef cook --release --recipe-path recipe.json

FROM rust as builder
RUN USER=root cargo new --bin example-project
WORKDIR ./example-project
COPY ./Cargo.toml ./Cargo.toml
# Copy cached dependencies from above
COPY --from=cacher /app/target target
COPY --from=cacher /usr/local/cargo /usr/local/cargo

RUN cargo build --release --bin app

FROM rust as runtime
WORKDIR app
COPY --from=builder /app/target/release/app .
ENTRYPOINT ["./app"]