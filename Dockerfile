FROM ruby:2.5
RUN apt-get update && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  postgresql-client \
  yarn \
  default-mysql-client \
  dnsutils \
  iputils-ping \
  net-tools
WORKDIR /workspace
COPY . .
RUN bundle install
