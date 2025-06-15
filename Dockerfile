FROM ruby:3.1

# Install dependencies
RUN apt-get update -qq && apt-get install -y \
  nodejs \
  yarn \
  postgresql-client \
  build-essential \
  libpq-dev \
  imagemagick

# Set working directory
WORKDIR /myapp

# Install gems
COPY Gemfile* ./
RUN gem install bundler && bundle install

# Add the rest of the app
COPY . .

# Add and set entrypoint script
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Expose Rails default port
EXPOSE 3000

# Start the server
CMD ["rails", "server", "-b", "0.0.0.0"]
