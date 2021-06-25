# Rails Project Development environment
### Base Image ###
FROM ruby:2.6.7-slim

### Builder Stage ###
## Install Debian Slim Rails Build Package Requirements
# Install Build Tools (glibc) & MIME (DB) Info & Postgresql & Node
#  (-y for no user prompt) 
RUN apt update && apt install -y build-essential \
  shared-mime-info \
  postgresql postgresql-contrib libpq-dev \
  nodejs \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

## Install Gemfile for dependencies
WORKDIR /app
COPY Gemfile Gemfile.lock ./

## Bundle Install
RUN gem install bundler:2.2.19 && bundle _2.2.19_ install

### Dev Environment ###
# ASSUME source is docker volumed into the image
# Add git and vim at least
# Note for this Bootstrap, I am eating the additional layer
# of the RUN command to show only needed for dev
RUN apt update && apt install -y git vim

# Command Line (in docker)
#CMD bash

# Keep it alive in (k8s, docker-compose)
CMD tail -f /dev/null

## Thar be dragons
#CMD bin/rails server --port 3000 --binding 0.0.0.0
# This is the command start rails in the container but...
#CMD bundle exec rails s -b 0.0.0.0