# PJ Wickwire <pjpeterww@gmail.com>
# Browser
#
if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

# Editors

export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'

# Language

if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi

# Paths

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

# get usr/bin and usr/local/bin
# make usr/local/bin go first so that packages i add are used before 
# those from mac 
export PATH="/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:$PATH"
# go
export GOPATH="$HOME/go"
# rust
export PATH="$PATH:$HOME/.cargo/bin"
# ruby
export rvm_path="$HOME/.rvm"

export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"

# node stuff
export NVM_DIR="$HOME/.nvm"
# bahh dont wanna search for my other version of ndoe that's in my brew

[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

[[ -f /etc/profile.d/vte.sh ]] && . /etc/profile.d/vte.sh
eval $(thefuck --alias)

alias bi="bundle install --binstubs=.bin"
export PATH="./.bin:$PATH"
# fuzzy finder
# cool script to use fzf to checkout shit
# https://github.com/pawelduda/fzf-live-repl
# https://github.com/junegunn/fzf#fuzzy-completion-for-bash-and-zsh
[ -f ~/.fzf.zsh ] && . "~/.fzf.zsh"

# aliases

# package manager git instead of default git
alias git="/usr/local/bin/git"

# CareOf specific 
alias careof="cd $HOME/Development/careof"
alias cweb="cd $HOME/Development/careof/web"
alias cnweb="cd $HOME/Development/careof/next-web"
alias wms="cd $HOME/Development/careof/wms"
alias cmobile="cd $HOME/Development/careof/mobile"

alias list="ruby ~/Development/projects/async_slack_standup.rb"

# make sure to download `ttab` to npm -- nice shortcut pkg for opening new tabs
start_web() {
  ttab "cweb && rails s" && ttab "cweb && bundle exec sidekiq -C config/sidekiq_staging.yml"
}

# Applications

alias canary="open -a Google\ Chrome\ Canary --args --disable-web-security --user-data-dir=$HOME"
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
alias zombies="ps -ef | grep [e]mber"

# git
alias gp="git push"
alias qc="git commit --amend --no-edit --no-verify"
alias ga="git add"
alias gs="git status"
alias gc="git checkout"

# dokcer
alias dcb="docker-compose build"
alias dca="docker attach beenverified_com_bvapp_1"
alias dup="docker-compose up -d"

# rails
alias be="bundle exec" 

# package.json dependenceiese
alias redoshit="rm -rf node_modules/ && \
    rm -rf package-lock.json && \
    npm cache clean --force && \
    rm -rf tmp/ && \
    rm -rf dist-*/ && \
    npm install
"
# https://www.tecmint.com/find-top-large-directories-and-files-sizes-in-linux/
alias find-fatties="du -hs * | sort -rh | head -10"
alias find-fattest"du -hs * | sort -rh | head"

# randoms
# check whether out
alias nyw="curl wttr.in/NewYork"

# f'n flux doesn't always quit - but when you force it to quit 
# it doesn't reset the screen
alias flux='open /Applications/Flux.app'

alias grabf="ps aux | grep [F]lux"

# moving to methods
countfiles(){
  ls -lq . | wc -l
}

# Specifically for flux but 
# the -10 tag BUS kills things safely
# but then sometimes it doesn

ks() {
  kill -10 $(ps aux | grep [F]lux | awk '{print $2}')
}

# pidof isn't built in
_pidof() {
  ps aux | grep ${1}
}

alias me="cd ~/Development/pajamaw.github.io && code ~/Development/pajamaw.github.io"

alias dev="cd ~/Development"

alias ali="code ~/.zprofile"
alias edu="cd ~/Development/Education"

alias bb="brightness 1"

alias js="jekyll serve"

nali() {
  echo "Updating shell profile..."
  source ~/.zprofile
}

pali() {
  echo "Saving shell profile to github..."
  yes | cp -r ~/.zprofile ~/shellSetup/
  yes | cp -r ~/.zprezto ~/shellSetup/
  yes | cp -r ~/.zpreztorc ~/shellSetup/
  yes | cp -r ~/.zlogin ~/shellSetup/
  yes | cp -r ~/.zlogout ~/shellSetup/
  yes | cp -r ~/.zshenv ~/shellSetup/
  yes | cp -r ~/.zshrc ~/shellSetup/
  yes | cp -r ~/Brewfile ~/shellSetup/
  current_directory=$(pwd)
  cd ~/shellSetup
  git add .
  git commit -m "Updated Shell scripts"
  git push
  cd $current_directory
}

weather() {
  curl wttr.in/${1:-NewYork}
}

sendit() {
  rvm use 2.6.6
  if [[ "$PWD" = "/Users/pjwickwire/Development/pajamaw.github.io" && "$(git branch --show-current)" = "master" ]]; then
    jekyll build
    git add .
    git commit -m "$(date +%b' '%d' '%Y): Updates"
    git push
    git checkout gh-pages
    git rebase master
    git push -f
    git checkout master
    echo "Updated site"
  else 
    echo "Cannot 'sendit' currently in $PWD on $(git branch --show-current)"
  fi
}

checkFlux() {
  i="10"
  while [ $i -lt 15 ]
  do
    flux
    sleep 2
    `kill -${i} $(ps aux | grep '[F]lux' | awk '{print $2}')`
    echo `${i} flag just ran run`
    sleep 1
    i=$[$i+1]
  done
}

starredRepos() {
  STARS=$(curl -sI https://api.github.com/users/$USER/starred?per_page=1|egrep '^Link'|egrep -o 'page=[0-9]+'|tail -1|cut -c6-)
  PAGES=$((658/100+1))

  echo You have $STARS starred repositories.
  echo

  for PAGE in `seq $PAGES`; do
      curl -sH "Accept: application/vnd.github.v3.star+json" "https://api.github.com/users/$USER/starred?per_page=100&page=$PAGE"| jq -r '.[]|[.starred_at,.repo.full_name]|@tsv'
  done

  echo
}

_brew() {
  if [[ $1 == "install" || $1 == "tap" ]]; then
    echo "Running brew super()"
    command brew $@
    brew bundle dump --force --describe
    yes | mv Brewfile ~/
  else 
    echo "Running normal brew"
    command brew $@
  fi
}

find_pids() {
  pgrep "${1}" || true
}

find_ports() {
    (ss -lptnOH "sport = :${1}" | grep -oP "\w+=\d+" | awk -F= '/pid/ {print $NF}' | sort -nu) || true
}

kill_pids() {
  if [ ${@+x} ]; then
      ps "${@}"
      [ -z ${DEBUG+x} ] && (kill -9 "${@}")
  else
      echo "No matching PIDs found"
  fi
}

fuckruby() {
  pids=(
      find_pids rspec
      find_pids spring
      find_ports 3000
  )
  kill_pids "${pids[@]}"
  echo "ruby fucked"
}

web-lint() {
  reek && rubocop
}

nocache() {
  sudo killall -HUP mDNSResponder
}