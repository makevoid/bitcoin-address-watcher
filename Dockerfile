# FROM debian:stable # ruby 2.3

# ruby 2.5
FROM debian:testing

RUN apt update -y
RUN apt install -y ruby-dev git
RUN gem i bundler
RUN apt install -y build-essential
WORKDIR /app

RUN mkdir -p /app/.bundle

COPY docker/.bundle-config .bundle/config

COPY Gemfile*  /app/
RUN bundle --deployment

COPY .   /app

ENV RACK_ENV production

WORKDIR /app

CMD bundle exec rake
