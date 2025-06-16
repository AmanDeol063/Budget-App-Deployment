FROM ruby:3.1

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Set the working directory
WORKDIR /myapp

# ✅ Copy only the Rails app directory into the container
COPY Budget-App/ /myapp

# ✅ Copy your entrypoint script and make it executable
COPY entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

# ✅ Install bundler and the app's dependencies
RUN gem install bundler
RUN bundle install

ENTRYPOINT ["/usr/bin/entrypoint.sh"]

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
