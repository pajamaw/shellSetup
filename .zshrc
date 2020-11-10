# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
# echo $ZDOTDIR
# source "${ZDOTDIR:-$HOME}/.zprofile"
# this isn't always getting executed it looks like
# https://medium.com/@rajsek/zsh-bash-startup-files-loading-order-bashrc-zshrc-etc-e30045652f2e
# broot is okay but i don't really use it
# source /Users/pjwickwire/Library/Preferences/org.dystroy.broot/launcher/bash/br

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export FONTAWESOME_NPM_AUTH_TOKEN="506C6E43-F020-4DE6-A2E5-DD47C5395967"