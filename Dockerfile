# Use the official Ruby image
FROM ruby:3.3.4

# Install Node.js and Yarn for Rails asset management
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g yarn

# Set up the working directory
WORKDIR /app

# Install dependencies
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install

# Copy the Rails application
COPY . /app

# Expose the Rails port
EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
