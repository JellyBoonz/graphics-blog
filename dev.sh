# No changes needed, just reading the file.

#!/bin/bash
# Development script for Jelly Renders blog
# Sets up the correct Ruby environment and runs Jekyll

# Initialize rbenv
eval "$(rbenv init -)"

# Set SSL certificate path for OpenSSL 1.1
export SSL_CERT_FILE=/opt/homebrew/etc/ca-certificates/cert.pem

# Ensure we're using the correct Ruby version
cd "$(dirname "$0")"
rbenv local 3.2.10

# Run Jekyll
bundle exec jekyll serve "$@"
