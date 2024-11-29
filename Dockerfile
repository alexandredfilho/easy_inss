# Use a ruby official image in the base
FROM ruby:3.2.2

# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs yarn

RUN curl -o /wait-for-it.sh https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh && chmod +x /wait-for-it.sh

# Set work directory
RUN mkdir -p /app
WORKDIR /app
RUN yarn install

# Copy gemfile and install dependencies
COPY Gemfile* /app/
RUN bundle install

# Copy the app
COPY . /app/

# Expose 3000 port
EXPOSE 3000

# Default command
CMD ["bin/dev"]
