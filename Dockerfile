FROM ruby:3.2.2

# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs postgresql-client

# Remove any existing Yarn installation
RUN apt-get remove --purge -y yarn

# Install the latest version of Yarn (compatible with Webpacker)
RUN curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | tee /etc/apt/trusted.gpg.d/yarn.asc
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install yarn

RUN curl -o /wait-for-it.sh https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh && chmod +x /wait-for-it.sh

# Set work directory
RUN mkdir -p /app
WORKDIR /app

# Copy gemfile and install dependencies
COPY Gemfile* /app/
RUN bundle install

# Copy the app
COPY . /app/

# Expose 3000 port
EXPOSE 3000

# Default command
CMD ["bin/dev"]
