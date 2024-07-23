FROM ruby:3.0-bullseye as base
RUN apt-get update -qq && apt-get install -y build-essential apt-utils libpq-dev nodejs
WORKDIR /app/
ENV APP_HOME /app/

RUN gem install bundler
COPY Gemfile* ./
RUN bundle install

CMD ["/bin/sh", "-c", "bash"]