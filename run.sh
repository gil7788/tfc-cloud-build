#!/bin/sh
echo "Hello, world! The time is $(date)."


# Test environment variables
source ./environments/config.sh

# Iterate through and print all environment variables
for var in $(compgen -A variable); do
  echo "$var=${!var}"
done


echo "Installing darkhttpd..."
# Install darkhttpd
apk add --no-cache darkhttpd
echo "darkhttpd installed."

echo "Serving files..."
# Serve files from the current directory on port 8080
darkhttpd . --port 8080
echo "Files served."

