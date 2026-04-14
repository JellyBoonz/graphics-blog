# Development Setup

This project uses Ruby 3.2.10 via rbenv with OpenSSL 1.1 to ensure compatibility with all dependencies.

## Quick Start

Use the provided script:
```bash
./dev.sh
```

Or manually:
```bash
eval "$(rbenv init -)"
export SSL_CERT_FILE=/opt/homebrew/etc/ca-certificates/cert.pem
bundle exec jekyll serve
```

## Environment Setup

Add to your `~/.zshrc` (or `~/.bashrc`):
```bash
# rbenv
eval "$(rbenv init -)"

# SSL certificates for Ruby/OpenSSL 1.1
export SSL_CERT_FILE=/opt/homebrew/etc/ca-certificates/cert.pem
```

## Ruby Version

The project uses Ruby 3.2.10 (specified in `.ruby-version`). This version was compiled with OpenSSL 1.1 to ensure `eventmachine` gem compatibility.

## Troubleshooting

If you get SSL certificate errors:
- Make sure `SSL_CERT_FILE` is set to `/opt/homebrew/etc/ca-certificates/cert.pem`
- Verify OpenSSL 1.1 is installed: `ls /opt/homebrew/opt/openssl@1.1`

If you get "command not found: jekyll":
- Run `bundle install` first
- Make sure you're using the correct Ruby version: `rbenv local 3.2.10`
