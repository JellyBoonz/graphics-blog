# Deployment Guide for Jelly Renders Blog

## Issues Fixed

✅ **GitHub Pages Configuration**: Updated URLs and baseurl settings
✅ **Content Security Policy**: Fixed MathJax configuration to work with GitHub Pages
✅ **GitHub Actions**: Configured automated deployment workflow
✅ **Gemfile**: Simplified to use GitHub Pages compatible gems

## Quick Deployment Steps

### 1. Push to GitHub
```bash
git init
git add .
git commit -m "Initial blog setup with fixes"
git remote add origin git@github.com:JellyBoonz/graphics-blog.git
git push -u origin main
```

### 2. Enable GitHub Pages
1. Go to your repository: https://github.com/JellyBoonz/graphics-blog
2. Click **Settings** tab
3. Scroll down to **Pages** section
4. Under **Source**, select **GitHub Actions**
5. Save the settings

### 3. Wait for Deployment
- GitHub will automatically run the deployment workflow
- Check the **Actions** tab to monitor progress
- Your site will be available at: https://jellyboonz.github.io/graphics-blog

## What Was Fixed

### MathJax CSP Issues
- Switched from MathJax 3 to MathJax 2.7.7 (more GitHub Pages compatible)
- Updated configuration to avoid CSP violations
- Removed problematic favicon reference

### GitHub Pages Configuration
- Fixed case sensitivity in URLs (jellyboonz vs JellyBoonz)
- Updated GitHub Actions workflow to use correct baseurl
- Simplified Gemfile to avoid native extension issues

### Deployment Workflow
- Configured GitHub Actions for automatic deployment
- Uses Ruby 3.1 and GitHub Pages compatible gems
- Builds with correct baseurl for subdirectory deployment

## Testing Locally (Optional)

If you want to test locally:

```bash
# Install GitHub Pages gem
gem install github-pages

# Serve locally
jekyll serve --baseurl "/graphics-blog"

# Or build only
jekyll build --baseurl "/graphics-blog"
```

## Troubleshooting

### If GitHub Actions fails:
1. Check the Actions tab for error messages
2. Ensure GitHub Pages is enabled in repository settings
3. Verify the workflow file syntax is correct

### If MathJax doesn't render:
1. Check browser console for CSP errors
2. The MathJax 2.7.7 configuration should work with GitHub Pages
3. Mathematical equations should render as: `$E = mc^2$` and `$$\int_{-\infty}^{\infty} e^{-x^2} dx$$`

### If site doesn't load:
1. Verify the URL: https://jellyboonz.github.io/graphics-blog
2. Check that GitHub Pages is enabled
3. Wait a few minutes after deployment

## Next Steps

1. **Customize Content**: Edit the example post and about page
2. **Add Your Posts**: Create new posts in `_posts/` directory
3. **Customize Styling**: Modify `assets/css/style.css`
4. **Add Images**: Place images in `assets/images/` directory

Your blog is now ready for technical writing about computer graphics! 🚀
