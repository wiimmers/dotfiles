# DPP Environment Variables
source $ZDOTDIR/.dpp
source $ZDOTDIR/.cloudsmith

# Package managers configuration
export PIP_CONFIG_FILE=$XDG_CONFIG_HOME/pip/pip.conf
export PNPM_HOME=/opt/homebrew/bin
eval "$(/opt/homebrew/bin/brew shellenv)"


# Zscaler CA Bundle
export REQUESTS_CA_BUNDLE=$XDG_CONFIG_HOME/zscaler/curl-ca-bundle.pem
export SSL_CA_FILE=$XDG_CONFIG_HOME/zscaler/curl-ca-bundle.pem
export AWS_CA_BUNDLE=$XDG_CONFIG_HOME/zscaler/curl-ca-bundle.pem
export ZSCALER_BUNDLE=$XDG_CONFIG_HOME/zscaler/curl-ca-bundle.pem

# Less configuration
export LESS=-FRX
