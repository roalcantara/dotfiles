# ALIASES
# http://zsh.sourceforge.net/Intro/intro_8.html
alias grc='noglob grc'

# GitHub Copilot
# Use Copilot with the GitHub CLI to get suggestions and explanations for the command line
# https://docs.github.com/en/copilot/using-github-copilot/using-github-copilot-in-the-command-line
if (( $+commands[gh] )); then
  # GitHub Copilot
  alias ghcp='gh copilot'
  # Explain a command
  alias cpe='ghcp explain'
  # Suggest a command
  alias cps='ghcp suggest'
fi

# PS
# alias ps!='/bin/ps'
# alias ps='PID=$(grc ps -afxAcmo user,pmem | fzf --multi --header-lines=1 --preview "grc ps o args {2}; grc ps mu {2}") && test ! -z "$PID" && echo "$PID" | awk "{print $2}" | xargs -r kill -9'

# https://phoenixnap.com/kb/diff-color
alias diff='diff --color -u'

# Grep history
alias hgrep='fc -Dlim "*$@*" 1'

# HTOP
# Improved top (interactive process viewer)
# https://htop.dev
if (( $+commands[htop] )); then
  alias top!=$(which top)
  alias top=htop
fi

# BAT
# A cat(1) clone with wings
# https://github.com/sharkdp/bat#configuration-file
if (( $+commands[bat] )); then
  export BAT_PAGER="${PAGER}"
  alias cat!='$(which cat)'
  alias cat=bat
fi

# Read system manual pages (man) using bat as the manual page formatter.
# https://github.com/eth-p/bat-extras/blob/master/doc/batman.md
if (( $+commands[batman] )); then
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
  alias man!=$(which man)
  alias man=batman
fi

# Open-source code editor
# https://code.visualstudio.com/insiders
if (( $+commands[code-insiders] )); then
  alias codei=code-insiders
fi

# YARN
if (( $+commands[yarn] )); then
  alias y='yarn'
  alias ya='yarn add'
  alias yad='yarn add --dev'
  alias yap='yarn add --peer'
  alias yb='yarn build'
  alias yba='yarn build:all'
  alias ybp='yarn build:prod'
  alias yc='yarn clear'
  alias yr='yarn reset'
  alias ycc='yarn cache clean'
  alias yd='yarn dev'
  alias yga='yarn global add'
  alias ygl='yarn global list'
  alias ygr='yarn global remove'
  alias ygu='yarn global upgrade'
  alias yh='yarn help'
  alias yi='yarn init'
  alias yl='yarn lint'
  alias yla='yarn lint:all'
  alias ylf='yarn lint --fix'
  alias yls='yarn list'
  alias yout='yarn outdated'
  alias yp='yarn pack'
  alias ys='yarn start'
  alias ysr='yarn serve'
  alias ysp='yarn serve:prod'
  alias yt='yarn test'
  alias yta='yarn test:all'
  alias yuc='yarn global upgrade && yarn cache clean'
  alias yui='yarn upgrade-interactive'
  alias yuil='yarn upgrade-interactive --latest'
  alias yv='yarn upgrade'
  alias yup='yarn version'
  alias yw='yarn workspace'
  alias yws='yarn workspaces'
fi

# MAKE
if (( $+commands[make] )); then
  alias mkb='make build'
  alias mkr='make run'
  alias mkri='make runIt'
  alias mkp!='make prune'
  alias mkr!='make remove'
  alias mkl='/bin/cat -e -t -v Makefile'
fi

# Taskfile
# Task is a task runner / build tool that aims to be simpler and easier to use than, for example, GNU Make.
# https://taskfile.dev/
if (( $+commands[gotask] )); then
  alias gt='gotask'                            # List non-hidden folders and files inline
fi

# Kubernets
# Short alias to set/show context/namespace (only works for bash and bash-compatible shells, current context to be set before using kn to set namespace)
# https://kubernetes.io/docs/reference/kubectl/cheatsheet/#kubectl-context-and-configuration
if (( $+commands[kubectl] )); then
  alias k=kubectl
  alias kx='f() { [ "$1" ] && kubectl config use-context $1 || kubectl config current-context ; } ; f'
  alias kn='f() { [ "$1" ] && kubectl config set-context --current --namespace $1 || kubectl config view --minify | grep namespace | cut -d" " -f6 ; } ; f'
fi

# TASK WARRIOR ALIASES
if (( $+commands[task] )); then
  alias tws='task'
  alias twa='tws add'
  alias twe='tws modify'
  alias twc='tws completed'
  alias twp='tws projects'
  alias twt='tws project:tecban'
  alias twd='tws projec:dots'
  alias twc='tws context list'
  alias twn='tws context none'
  alias twi='tws context isolutions'
  alias twh='tws context home'
  alias tww='tws context work'
  alias twr='tws reports'
  alias tl='tldr --list | fzf --ansi | xargs tldr'
fi
