export XDG_CONFIG_HOME="$HOME/dotfiles"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# Zscaler bundles must be declared in .zshenv for non-interactive shells
# This was a problem when claude-code attempted to use tools making network calls
export REQUESTS_CA_BUNDLE=$XDG_CONFIG_HOME/zscaler/curl-ca-bundle.pem
export SSL_CA_FILE=$XDG_CONFIG_HOME/zscaler/curl-ca-bundle.pem
export SSL_CERT_FILE=$XDG_CONFIG_HOME/zscaler/curl-ca-bundle.pem
export AWS_CA_BUNDLE=$XDG_CONFIG_HOME/zscaler/curl-ca-bundle.pem
export ZSCALER_BUNDLE=$XDG_CONFIG_HOME/zscaler/curl-ca-bundle.pem
export NODE_EXTRA_CA_CERTS=$XDG_CONFIG_HOME/zscaler/curl-ca-bundle.pem
