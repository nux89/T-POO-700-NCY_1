# Utilization of official Elixir image
FROM elixir:1.14-alpine

# Install build dependencies & git
RUN apk add --no-cache build-base git inotify-tools nodejs npm

# Create app directory
WORKDIR /app

# Install Hex and Rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# Copy phoenix application
COPY ./api /app

# Install dependencies and compile
RUN mix deps.get && mix compile

EXPOSE 4000

CMD ["mix", "phx.server"]
