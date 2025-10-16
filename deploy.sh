#!/bin/bash

# Jelly Renders Blog Deployment Script
echo "Deploying Jelly Renders blog to GitHub Pages..."

# Check if we're in a git repository
if [ ! -d ".git" ]; then
    echo "Not in a git repository. Initializing..."
    git init
    git remote add origin git@github.com:JellyBoonz/graphics-blog.git
fi

# Add all files
echo "Adding files to git..."
git add .

# Commit changes
echo "Committing changes..."
git commit -m "Update blog content - $(date)"

# Push to GitHub
echo "Pushing to GitHub..."
git push -u origin main

echo "Deployment complete!"
echo "Your blog will be available at: https://JellyBoonz.github.io/graphics-blog"
echo ""
echo "Note: It may take a few minutes for GitHub Pages to build and deploy your site."
