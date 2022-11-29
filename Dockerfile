FROM ruby:2.5.9
RUN apt-get update && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  postgresql-client \
  yarn \
  default-mysql-client \
  dnsutils \
  iputils-ping \
  net-tools \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
WORKDIR /workspace
COPY . .
RUN bundle install
RUN rails assets:precompile
