#!/bin/sh
echo "Hello, world! The time is $(date)."


# Test environment variables
source ./environments/config.sh

# Iterate through and print all environment variables
for var in $(compgen -A variable); do
  echo "$var=${!var}"
done
