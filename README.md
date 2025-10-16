# Jelly Renders

A minimal Jekyll blog optimized for technical writing about computer graphics, rendering, and mathematical concepts. Built with simplicity, readability, and responsiveness in mind.

## Features

- **Minimal Design**: Clean, distraction-free layout focused on content readability
- **Mathematical Notation**: Full MathJax support for LaTeX equations
- **Syntax Highlighting**: Beautiful code syntax highlighting with Rouge
- **Responsive**: Mobile-friendly design that works on all devices
- **GitHub Pages Ready**: Optimized for deployment on GitHub Pages
- **Fast Loading**: Minimal dependencies and optimized assets

## Quick Start

### Prerequisites

- Ruby 2.7 or higher (recommended: use rbenv or rvm)
- Bundler gem
- Git
- Xcode Command Line Tools (for macOS)

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/JellyBoonz/graphics-blog.git
   cd graphics-blog
   ```

2. **Install dependencies:**
   ```bash
   # Option 1: Use GitHub Pages gem (recommended)
   bundle install --path vendor/bundle
   
   # Option 2: If you have permission issues, try:
   gem install github-pages
   ```

3. **Run locally:**
   ```bash
   # If using bundle
   bundle exec jekyll serve
   
   # If using direct gem install
   jekyll serve
   ```

4. **View your site:**
   Open [http://localhost:4000](http://localhost:4000) in your browser

### Troubleshooting Installation

**If you encounter Ruby/gem installation issues:**

1. **Install Xcode Command Line Tools:**
   ```bash
   xcode-select --install
   ```

2. **Use a Ruby version manager (recommended):**
   ```bash
   # Install rbenv
   brew install rbenv
   
   # Install a newer Ruby version
   rbenv install 3.1.0
   rbenv local 3.1.0
   
   # Install bundler
   gem install bundler
   ```

3. **Alternative: Use GitHub Codespaces or similar cloud environment**

## Project Structure

```
graphics-blog/
├── _config.yml          # Site configuration
├── _layouts/            # HTML templates
│   ├── default.html     # Base layout
│   └── post.html        # Post layout
├── _posts/              # Blog posts
│   └── 2025-01-01-example-post.md
├── assets/              # Static assets
│   └── css/
│       └── style.css    # Custom styles
├── index.md             # Homepage
├── about.md             # About page
├── Gemfile              # Ruby dependencies
└── README.md            # This file
```

## Creating New Posts

### Method 1: Manual Creation

1. Create a new file in `_posts/` with the format: `YYYY-MM-DD-title.md`
2. Add the required front matter:

```yaml
---
layout: post
title: "Your Post Title"
date: 2025-01-01 10:00:00 -0000
categories: [Category1, Category2]
tags: [tag1, tag2, tag3]
author: "Your Name"
---
```

3. Write your content in Markdown below the front matter

### Method 2: Using Jekyll Commands

```bash
bundle exec jekyll post "Your Post Title"
```

This will create a new post with the current date and proper front matter.

## Writing Tips

### Mathematical Notation

Use LaTeX syntax for mathematical expressions:

**Inline math:** `$E = mc^2$` → $E = mc^2$

**Display math:** `$$\int_{-\infty}^{\infty} e^{-x^2} dx = \sqrt{\pi}$$`

### Code Blocks

Use triple backticks with language specification:

````markdown
```cpp
#include <iostream>
int main() {
    std::cout << "Hello, World!" << std::endl;
    return 0;
}
```
````

### Images

Place images in the `assets/images/` directory and reference them:

```markdown
![Alt text](/assets/images/image-name.png)
*Caption for the image*
```

## Customization

### Site Configuration

Edit `_config.yml` to customize:

- Site title and description
- Author information
- Social media links
- Navigation menu
- Plugin settings

### Styling

Modify `assets/css/style.css` to customize:

- Colors and typography
- Layout and spacing
- Responsive breakpoints
- Print styles

### Layouts

Customize templates in `_layouts/`:

- `default.html`: Base template with header, navigation, and footer
- `post.html`: Individual post template with metadata

## Deployment

### GitHub Pages

1. **Push to GitHub:**
   ```bash
   git add .
   git commit -m "Initial blog setup"
   git push origin main
   ```

2. **Enable GitHub Pages:**
   - Go to your repository settings
   - Navigate to "Pages" section
   - Select "GitHub Actions" as the source
   - The GitHub Actions workflow will automatically deploy your site

3. **Wait for deployment:**
   - GitHub Pages will build and deploy your site
   - Access it at `https://jellyboonz.github.io/graphics-blog`

### Custom Domain (Optional)

1. Add a `CNAME` file to the root with your domain
2. Configure DNS settings to point to GitHub Pages
3. Update the `url` in `_config.yml`

## Development

### Local Development

```bash
# Serve with live reload
bundle exec jekyll serve --livereload

# Build for production
bundle exec jekyll build

# Clean and rebuild
bundle exec jekyll clean && bundle exec jekyll serve
```

### Troubleshooting

**Common issues:**

1. **Ruby version conflicts:**
   ```bash
   rbenv install 3.0.0
   rbenv local 3.0.0
   ```

2. **Bundle install fails:**
   ```bash
   bundle update
   bundle install
   ```

3. **MathJax not rendering:**
   - Check browser console for errors
   - Ensure MathJax script is loading
   - Verify LaTeX syntax is correct

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test locally
5. Submit a pull request

## License

This project is open source and available under the [MIT License](LICENSE).

## Acknowledgments

- [Jekyll](https://jekyllrb.com/) - Static site generator
- [MathJax](https://www.mathjax.org/) - Mathematical notation rendering
- [Rouge](https://github.com/rouge-ruby/rouge) - Syntax highlighting
- [GitHub Pages](https://pages.github.com/) - Hosting platform

## Support

If you encounter any issues or have questions:

1. Check the [Jekyll documentation](https://jekyllrb.com/docs/)
2. Search existing [GitHub issues](https://github.com/yourusername/graphics-blog/issues)
3. Create a new issue with detailed information

---

**Happy blogging!** 🚀
