#!/bin/bash

# Test Jekyll build script
echo "Testing Jekyll build..."

# Try to build the site
if command -v bundle &> /dev/null; then
    echo "Using Bundler..."
    bundle exec jekyll build
else
    echo "Using direct Jekyll..."
    jekyll build
fi

if [ $? -eq 0 ]; then
    echo "Build successful!"
    echo "Site built in _site directory"
    echo "You can preview with: bundle exec jekyll serve"
else
    echo "Build failed. Check the error messages above."
fi
