#!/bin/bash
set -e

echo "Running DB migrations..."
bundle exec rake db:migrate

echo "Starting Rails server..."
bundle exec rails server -b 0.0.0.0 -p 3000
