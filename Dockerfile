FROM ruby:2.7.4-slim
RUN mkdir /app
WORKDIR /app/
RUN apt-get update -y
RUN apt-get install -y git build-essential libpq-dev nodejs
RUN gem install bundler -v '1.15'
COPY Gemfile /app/
COPY Gemfile.lock /app/
RUN bundle install
ADD . /app/
CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]
EXPOSE 3000
