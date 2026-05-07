source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZDOTDIR/aliases.zsh
source $ZDOTDIR/bid.zsh
source $ZDOTDIR/history.zsh
source $ZDOTDIR/starship.zsh
source $ZDOTDIR/title.zsh
source $ZDOTDIR/vi.zsh
source $ZDOTDIR/wez.zsh
source $ZDOTDIR/rvm.zsh

export NVM_DIR="$XDG_CONFIG_HOME/nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"


setopt autocd

# ClaudeCode
export PATH=$PATH:$HOME/.local/bin
