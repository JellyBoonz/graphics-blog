#!/bin/bash

# Jelly Renders Blog Setup Script
echo "🚀 Setting up Jelly Renders blog..."

# Check if Ruby is installed
if ! command -v ruby &> /dev/null; then
    echo "❌ Ruby is not installed. Please install Ruby 2.7+ first."
    exit 1
fi

# Check Ruby version
ruby_version=$(ruby -v | cut -d' ' -f2 | cut -d'p' -f1)
echo "📦 Ruby version: $ruby_version"

# Install Xcode Command Line Tools if on macOS
if [[ "$OSTYPE" == "darwin"* ]]; then
    if ! xcode-select -p &> /dev/null; then
        echo "🔧 Installing Xcode Command Line Tools..."
        xcode-select --install
    fi
fi

# Try to install dependencies
echo "📚 Installing Jekyll dependencies..."

# Option 1: Try with bundle
if command -v bundle &> /dev/null; then
    echo "Using Bundler..."
    bundle install --path vendor/bundle
    if [ $? -eq 0 ]; then
        echo "✅ Dependencies installed successfully!"
        echo "🌐 Starting Jekyll server..."
        bundle exec jekyll serve --livereload
    else
        echo "⚠️ Bundle install failed, trying alternative..."
    fi
fi

# Option 2: Try direct gem install
if [ $? -ne 0 ]; then
    echo "Trying direct gem installation..."
    gem install github-pages
    if [ $? -eq 0 ]; then
        echo "✅ GitHub Pages gem installed!"
        echo "🌐 Starting Jekyll server..."
        jekyll serve --livereload
    else
        echo "❌ Installation failed. Please check the error messages above."
        echo ""
        echo "💡 Troubleshooting tips:"
        echo "1. Install Xcode Command Line Tools: xcode-select --install"
        echo "2. Use a Ruby version manager like rbenv or rvm"
        echo "3. Try running: gem install github-pages"
        echo "4. Check your Ruby version (needs 2.7+)"
    fi
fi
