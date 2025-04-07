# shellcheck shell=bash disable=SC1090,SC2155,SC1091,SC1088,SC1036
# https://gnu.org/savannah-checkouts/gnu/bash/manual/bash.html#Bash-Startup-Files

# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# Contains system-wide environment initialization
# Read and executed when Bash is invoked as an interactive login shell - unless if ~/.bash_profile or ~/.bash_login exists!
# https://linuxize.com/post/bashrc-vs-bash-profile

# COLORS, TERM & PATH {
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
export LS_COLORS='bd=0;38;2;154;237;254;48;2;51;51;51:su=0:rs=0:cd=0;38;2;255;106;193;48;2;51;51;51:sg=0:mh=0:*~=0;38;2;102;102;102:mi=0;38;2;0;0;0;48;2;255;92;87:ex=1;38;2;255;92;87:do=0;38;2;0;0;0;48;2;255;106;193:ow=0:tw=0:ca=0:or=0;38;2;0;0;0;48;2;255;92;87:so=0;38;2;0;0;0;48;2;255;106;193:pi=0;38;2;0;0;0;48;2;87;199;255:st=0:no=0:ln=0;38;2;255;106;193:fi=0:di=0;38;2;87;199;255:*.p=0;38;2;90;247;142:*.c=0;38;2;90;247;142:*.m=0;38;2;90;247;142:*.a=1;38;2;255;92;87:*.h=0;38;2;90;247;142:*.o=0;38;2;102;102;102:*.d=0;38;2;90;247;142:*.z=4;38;2;154;237;254:*.r=0;38;2;90;247;142:*.t=0;38;2;90;247;142:*.pm=0;38;2;90;247;142:*.hh=0;38;2;90;247;142:*.cr=0;38;2;90;247;142:*.7z=4;38;2;154;237;254:*.nb=0;38;2;90;247;142:*.pp=0;38;2;90;247;142:*css=0;38;2;90;247;142:*.md=0;38;2;243;249;157:*.kt=0;38;2;90;247;142:*.sh=0;38;2;90;247;142:*.js=0;38;2;90;247;142:*.td=0;38;2;90;247;142:*.ps=0;38;2;255;92;87:*.gz=4;38;2;154;237;254:*.di=0;38;2;90;247;142:*.hi=0;38;2;102;102;102:*.cs=0;38;2;90;247;142:*.as=0;38;2;90;247;142:*.hs=0;38;2;90;247;142:*.xz=4;38;2;154;237;254:*.jl=0;38;2;90;247;142:*.vb=0;38;2;90;247;142:*.mn=0;38;2;90;247;142:*.go=0;38;2;90;247;142:*.el=0;38;2;90;247;142:*.bz=4;38;2;154;237;254:*.lo=0;38;2;102;102;102:*.ko=1;38;2;255;92;87:*.bc=0;38;2;102;102;102:*.py=0;38;2;90;247;142:*.cc=0;38;2;90;247;142:*.so=1;38;2;255;92;87:*.rm=0;38;2;255;180;223:*.pl=0;38;2;90;247;142:*.fs=0;38;2;90;247;142:*.ex=0;38;2;90;247;142:*.gv=0;38;2;90;247;142:*.ts=0;38;2;90;247;142:*.rs=0;38;2;90;247;142:*.la=0;38;2;102;102;102:*.rb=0;38;2;90;247;142:*.ml=0;38;2;90;247;142:*.cp=0;38;2;90;247;142:*.ui=0;38;2;243;249;157:*.wv=0;38;2;255;180;223:*.ll=0;38;2;90;247;142:*.tex=0;38;2;90;247;142:*.epp=0;38;2;90;247;142:*.fsx=0;38;2;90;247;142:*.sty=0;38;2;102;102;102:*.mir=0;38;2;90;247;142:*.erl=0;38;2;90;247;142:*.zst=4;38;2;154;237;254:*.eps=0;38;2;255;180;223:*.tml=0;38;2;243;249;157:*.vcd=4;38;2;154;237;254:*.awk=0;38;2;90;247;142:*hgrc=0;38;2;165;255;195:*TODO=1:*.log=0;38;2;102;102;102:*.tgz=4;38;2;154;237;254:*.tmp=0;38;2;102;102;102:*.sbt=0;38;2;90;247;142:*.aif=0;38;2;255;180;223:*.m4v=0;38;2;255;180;223:*.bat=1;38;2;255;92;87:*.fnt=0;38;2;255;180;223:*.bbl=0;38;2;102;102;102:*.tif=0;38;2;255;180;223:*.wmv=0;38;2;255;180;223:*.ipp=0;38;2;90;247;142:*.bin=4;38;2;154;237;254:*.bmp=0;38;2;255;180;223:*.blg=0;38;2;102;102;102:*.exe=1;38;2;255;92;87:*.cxx=0;38;2;90;247;142:*.toc=0;38;2;102;102;102:*.swp=0;38;2;102;102;102:*.dpr=0;38;2;90;247;142:*.deb=4;38;2;154;237;254:*.xlr=0;38;2;255;92;87:*.flv=0;38;2;255;180;223:*.vim=0;38;2;90;247;142:*.htc=0;38;2;90;247;142:*.pid=0;38;2;102;102;102:*.img=4;38;2;154;237;254:*.pod=0;38;2;90;247;142:*.ps1=0;38;2;90;247;142:*.wav=0;38;2;255;180;223:*.pgm=0;38;2;255;180;223:*.bz2=4;38;2;154;237;254:*.xls=0;38;2;255;92;87:*.zsh=0;38;2;90;247;142:*.wma=0;38;2;255;180;223:*.swf=0;38;2;255;180;223:*.avi=0;38;2;255;180;223:*.gvy=0;38;2;90;247;142:*.vob=0;38;2;255;180;223:*.cfg=0;38;2;243;249;157:*.ini=0;38;2;243;249;157:*.psd=0;38;2;255;180;223:*.ogg=0;38;2;255;180;223:*.php=0;38;2;90;247;142:*.iso=4;38;2;154;237;254:*.tar=4;38;2;154;237;254:*.m4a=0;38;2;255;180;223:*.dll=1;38;2;255;92;87:*.cgi=0;38;2;90;247;142:*.com=1;38;2;255;92;87:*.csx=0;38;2;90;247;142:*.ics=0;38;2;255;92;87:*.bib=0;38;2;243;249;157:*.fls=0;38;2;102;102;102:*.jar=4;38;2;154;237;254:*.def=0;38;2;90;247;142:*.sxw=0;38;2;255;92;87:*.arj=4;38;2;154;237;254:*.apk=4;38;2;154;237;254:*.pdf=0;38;2;255;92;87:*.htm=0;38;2;243;249;157:*.doc=0;38;2;255;92;87:*.zip=4;38;2;154;237;254:*.png=0;38;2;255;180;223:*.out=0;38;2;102;102;102:*.dot=0;38;2;90;247;142:*.elm=0;38;2;90;247;142:*.bst=0;38;2;243;249;157:*.lua=0;38;2;90;247;142:*.ods=0;38;2;255;92;87:*.clj=0;38;2;90;247;142:*.dmg=4;38;2;154;237;254:*.xcf=0;38;2;255;180;223:*.tbz=4;38;2;154;237;254:*.hpp=0;38;2;90;247;142:*.pro=0;38;2;165;255;195:*.ilg=0;38;2;102;102;102:*.git=0;38;2;102;102;102:*.pyo=0;38;2;102;102;102:*.tcl=0;38;2;90;247;142:*.rar=4;38;2;154;237;254:*.ppt=0;38;2;255;92;87:*.bcf=0;38;2;102;102;102:*.rtf=0;38;2;255;92;87:*.xml=0;38;2;243;249;157:*.csv=0;38;2;243;249;157:*.pps=0;38;2;255;92;87:*.mp3=0;38;2;255;180;223:*.asa=0;38;2;90;247;142:*.sql=0;38;2;90;247;142:*.fsi=0;38;2;90;247;142:*.ind=0;38;2;102;102;102:*.yml=0;38;2;243;249;157:*.cpp=0;38;2;90;247;142:*.inl=0;38;2;90;247;142:*.mkv=0;38;2;255;180;223:*.ltx=0;38;2;90;247;142:*.idx=0;38;2;102;102;102:*.bak=0;38;2;102;102;102:*.c++=0;38;2;90;247;142:*.bsh=0;38;2;90;247;142:*.kts=0;38;2;90;247;142:*.rst=0;38;2;243;249;157:*.hxx=0;38;2;90;247;142:*.pyc=0;38;2;102;102;102:*.fon=0;38;2;255;180;223:*.gif=0;38;2;255;180;223:*.jpg=0;38;2;255;180;223:*.pas=0;38;2;90;247;142:*.inc=0;38;2;90;247;142:*.sxi=0;38;2;255;92;87:*.rpm=4;38;2;154;237;254:*.svg=0;38;2;255;180;223:*.kex=0;38;2;255;92;87:*.nix=0;38;2;243;249;157:*.mpg=0;38;2;255;180;223:*.mp4=0;38;2;255;180;223:*.ttf=0;38;2;255;180;223:*.exs=0;38;2;90;247;142:*.ppm=0;38;2;255;180;223:*.mov=0;38;2;255;180;223:*.pyd=0;38;2;102;102;102:*.txt=0;38;2;243;249;157:*.mid=0;38;2;255;180;223:*.xmp=0;38;2;243;249;157:*.aux=0;38;2;102;102;102:*.bag=4;38;2;154;237;254:*.tsx=0;38;2;90;247;142:*.mli=0;38;2;90;247;142:*.odt=0;38;2;255;92;87:*.pkg=4;38;2;154;237;254:*.otf=0;38;2;255;180;223:*.pbm=0;38;2;255;180;223:*.odp=0;38;2;255;92;87:*.h++=0;38;2;90;247;142:*.dox=0;38;2;165;255;195:*.ico=0;38;2;255;180;223:*.html=0;38;2;243;249;157:*.mpeg=0;38;2;255;180;223:*.bash=0;38;2;90;247;142:*.lisp=0;38;2;90;247;142:*.opus=0;38;2;255;180;223:*.h264=0;38;2;255;180;223:*.yaml=0;38;2;243;249;157:*.diff=0;38;2;90;247;142:*.docx=0;38;2;255;92;87:*.webm=0;38;2;255;180;223:*.tiff=0;38;2;255;180;223:*.orig=0;38;2;102;102;102:*.java=0;38;2;90;247;142:*.jpeg=0;38;2;255;180;223:*.make=0;38;2;165;255;195:*.tbz2=4;38;2;154;237;254:*.rlib=0;38;2;102;102;102:*.hgrc=0;38;2;165;255;195:*.pptx=0;38;2;255;92;87:*.xlsx=0;38;2;255;92;87:*.toml=0;38;2;243;249;157:*.lock=0;38;2;102;102;102:*.conf=0;38;2;243;249;157:*.flac=0;38;2;255;180;223:*.psm1=0;38;2;90;247;142:*.less=0;38;2;90;247;142:*.purs=0;38;2;90;247;142:*.epub=0;38;2;255;92;87:*.dart=0;38;2;90;247;142:*.psd1=0;38;2;90;247;142:*.json=0;38;2;243;249;157:*.fish=0;38;2;90;247;142:*README=0;38;2;40;42;54;48;2;243;249;157:*.class=0;38;2;102;102;102:*.cabal=0;38;2;90;247;142:*.dyn_o=0;38;2;102;102;102:*.ipynb=0;38;2;90;247;142:*.patch=0;38;2;90;247;142:*.xhtml=0;38;2;243;249;157:*.cache=0;38;2;102;102;102:*shadow=0;38;2;243;249;157:*.shtml=0;38;2;243;249;157:*.scala=0;38;2;90;247;142:*.swift=0;38;2;90;247;142:*.toast=4;38;2;154;237;254:*passwd=0;38;2;243;249;157:*.mdown=0;38;2;243;249;157:*.cmake=0;38;2;165;255;195:*.flake8=0;38;2;165;255;195:*.groovy=0;38;2;90;247;142:*.config=0;38;2;243;249;157:*.gradle=0;38;2;90;247;142:*.dyn_hi=0;38;2;102;102;102:*LICENSE=0;38;2;153;153;153:*COPYING=0;38;2;153;153;153:*INSTALL=0;38;2;40;42;54;48;2;243;249;157:*TODO.md=1:*.matlab=0;38;2;90;247;142:*.ignore=0;38;2;165;255;195:*.desktop=0;38;2;243;249;157:*.gemspec=0;38;2;165;255;195:*Makefile=0;38;2;165;255;195:*setup.py=0;38;2;165;255;195:*Doxyfile=0;38;2;165;255;195:*TODO.txt=1:*.DS_Store=0;38;2;102;102;102:*.fdignore=0;38;2;165;255;195:*.kdevelop=0;38;2;165;255;195:*README.md=0;38;2;40;42;54;48;2;243;249;157:*configure=0;38;2;165;255;195:*.markdown=0;38;2;243;249;157:*.cmake.in=0;38;2;165;255;195:*COPYRIGHT=0;38;2;153;153;153:*.rgignore=0;38;2;165;255;195:*.gitignore=0;38;2;165;255;195:*CODEOWNERS=0;38;2;165;255;195:*.gitconfig=0;38;2;165;255;195:*SConstruct=0;38;2;165;255;195:*.localized=0;38;2;102;102;102:*Dockerfile=0;38;2;243;249;157:*.scons_opt=0;38;2;102;102;102:*INSTALL.md=0;38;2;40;42;54;48;2;243;249;157:*.synctex.gz=0;38;2;102;102;102:*Makefile.am=0;38;2;165;255;195:*INSTALL.txt=0;38;2;40;42;54;48;2;243;249;157:*Makefile.in=0;38;2;102;102;102:*.gitmodules=0;38;2;165;255;195:*MANIFEST.in=0;38;2;165;255;195:*LICENSE-MIT=0;38;2;153;153;153:*.travis.yml=0;38;2;90;247;142:*.fdb_latexmk=0;38;2;102;102;102:*configure.ac=0;38;2;165;255;195:*appveyor.yml=0;38;2;90;247;142:*CONTRIBUTORS=0;38;2;40;42;54;48;2;243;249;157:*.applescript=0;38;2;90;247;142:*.clang-format=0;38;2;165;255;195:*CMakeLists.txt=0;38;2;165;255;195:*.gitattributes=0;38;2;165;255;195:*LICENSE-APACHE=0;38;2;153;153;153:*CMakeCache.txt=0;38;2;102;102;102:*CONTRIBUTORS.md=0;38;2;40;42;54;48;2;243;249;157:*.sconsign.dblite=0;38;2;102;102;102:*requirements.txt=0;38;2;165;255;195:*CONTRIBUTORS.txt=0;38;2;40;42;54;48;2;243;249;157:*package-lock.json=0;38;2;102;102;102:*.CFUserTextEncoding=0;38;2;102;102;102'
export TERM="${TERM:-xterm-256color}"
if [ "$TERM" = "xterm-ghostty" ]; then
  export SNACKS_GHOSTTY=true
fi
# }

# HOMEBREW {
# https://brew.sh
# Determine Homebrew prefix based on OS and architecture
OS_ARCH="$(uname -s | tr '[:upper:]' '[:lower:]'):$(uname -m)"
typeset -A HOMEBREW_PREFIXES=(
  ["darwin:arm64"]=/opt/homebrew
  ["darwin:x86_64"]=/usr/local
  ["linux:x86_64"]="$HOME/.linuxbrew"
  ["default"]=/usr/local # fallback
)
export HOMEBREW_PREFIX="${HOMEBREW_PREFIX:-${HOMEBREW_PREFIXES[$OS_ARCH]:-${HOMEBREW_PREFIXES[default]}}}"
export HOMEBREW_BIN=$HOMEBREW_PREFIX/bin
export HOMEBREW_SHARE=$HOMEBREW_PREFIX/share
export HOMEBREW_NO_ENV_HINTS=1                                 # Hide hints
export HOMEBREW_NO_ANALYTICS=1                                 # Disabled analytics
export HOMEBREW_BAT=true                                       # Use bat for the brew cat command
export HOMEBREW_BAT_THEME=dracula                              # Use this as the bat theme for syntax highlighting
export HOMEBREW_BUNDLE_DUMP_NO_VSCODE=1                        # Don't dump vscode extensions
export HOMEBREW_BUNDLE_FILE=$XDG_CONFIG_HOME/homebrew/Brewfile # https://docs.brew.sh/Manpage#bundle-subcommand
eval "$("$HOMEBREW_BIN"/brew shellenv)"
# }

# [N]VIM {
# +BundleInstall +qall, Install all vim bundles
# https://superuser.com/a/874924/389767
if [ -f "$HOMEBREW_BIN"/nvim ]; then
  # shellcheck disable=SC2155
  export EDITOR="$HOMEBREW_BIN/nvim --listen ${XDG_DATA_HOME:-$HOME/.local/state}/nvim/nvimsocket"
  export VIM_PATH=$XDG_CONFIG_HOME/nvim
  export MYVIMRC=$VIM_PATH/init.lua
  export NVIM_LOG_FILE=$XDG_CACHE_HOME/nvim/.nvimlog
  alias vim=nvim
  alias vi=nvim
else
  # shellcheck disable=SC2155
  export EDITOR=$(command -v vim || command -v vi)
  alias vi=vim
fi
# }

# ZSH {
export SHELL=$HOMEBREW_BIN/zsh
# }

# LESS {
# https://linuxize.com/post/less-command-in-linux/
export LESS='-RF'
export LESS_HOME=$XDG_CONFIG_HOME/less
export LESS_CACHE_HOME=$XDG_CACHE_HOME/less
export LESSKEY=$LESS_CACHE_HOME/keys
export LESSHISTFILE=$XDG_CACHE_HOME/history/lesshist
export LESS_ADVANCED_PREPROCESSOR=1
# }

# EDITOR {
export VISUAL=$EDITOR
export SUDO_EDITOR=$EDITOR
export GIT_EDITOR="$EDITOR -c 'startinsert'"
export LAUNCH_EDITOR=$EDITOR
# }

# if running bash
if [ -n "$BASH_VERSION" ]; then
  # the default umask is set in /etc/profile; for setting the umask
  # for ssh logins, install and configure the libpam-umask package.
  #umask 022

  # include .bashrc if it exists
  if [ -f ~/.bashrc ]; then
    # Read by bash when interactive non-login shell is started
    # `--norc` file option inhibited this
    # `--rcfile` file option forces bash to read and execute commands from a given file - instead of ~/.bashrc
    . ~/.bashrc
  fi

  # don't put duplicate lines or lines starting with space in the history.
  # See bash(1) for more options
  HISTCONTROL=ignoreboth

  # make less more friendly for non-text input files, see lesspipe(1)
  if [ -x /usr/bin/lesspipe ]; then
    eval "$(SHELL:-/bin/sh lesspipe)"
  fi

  # Alias definitions.
  # You may want to put all your additions into a separate file like
  # ~/.bash_aliases, instead of adding them here directly.
  # See /usr/share/doc/bash-doc/examples in the bash-doc package.
  if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
  fi
fi

# EZA {
# A modern replacement for ls
# https://eza.rocks
# if type eza >/dev/null; then
export EXA_COLORS="ln=04;01;38;5;205:ex=01;38;5;10:bl=38;5;220:ga=36:gd=31:gm=33:gn=38;5;160:gr=34:gt=37:gu=35;1:gv=33:gw=1;34:gx=1;32:lc=37:sb=32:sf=37:sn=32:su=37:tr=34:tw=1;34:tx=1;35:ue=1;35:un=38;5;160:ur=1;32:uu=1;36:uw=1;34:ux=1;32"
# fi
# }

# GNUPG {
# The GNU Privacy Guard
# https://www.gnupg.org/documentation/manuals/gnupg/GPG-Configuration.html
# if type gpg >/dev/null; then
# needed for git PGP-signed commits
# also needed for sops
export GPG_TTY=$(tty)
export GNUPGHOME=$XDG_CONFIG_HOME/gnupg
# fi
# }

# WAKATIME {
# WakaTime command line interface
# https://github.com/wakatime/wakatime#wakatime
export WAKATIME_HOME=$XDG_CONFIG_HOME/wakatime
# }

# MODULAR/MOJO {
export MODULAR_HOME=$XDG_DATA_HOME/modular
# }

# RUST {
# Rustup is an installer for the systems programming language Rust
# https://rust-lang.github.io/rustup/installation/index.html

# Some details are omitted, run with `RUST_BACKTRACE=full` for a verbose backtrace
export RUST_BACKTRACE=full # or export RUST_BACKTRACE=1 for a short backtrace
# export RUST_LOG=info      # for logging

# Rustup home directory - stores installed toolchains and configuration options
# export RUSTUP_HOME=$XDG_DATA_HOME/rustup

# Cargo home directory - stores registry index and cached packages
export CARGO_HOME=$XDG_DATA_HOME/cargo
# }

# RUBY {
# A dynamic, open source programming language with a focus on simplicity and productivity
# https://github.com/TaKO8Ki/frum/issues/126#issuecomment-1520174616
export CPATH=$HOMEBREW_PREFIX/include
export LIBRARY_PATH=$HOMEBREW_PREFIX/lib

# RUBY GEMS {
# RubyGems is a package manager for the Ruby programming language
# https://guides.rubygems.org/command-reference/#gem-environment
export GEM_HOME=$HOMEBREW_PREFIX/opt/gems
# }

# RUBY-BUILD {
# Compile and install different versions of Ruby
# https://github.com/rbenv/ruby-build
# YJIT is a new method-based just-in-time compiler for CRuby
export RUBY_CONFIGURE_OPTS="--enable-yjit"

# Where to cache downloaded package files. (Default: ~/.rbenv/cache if invoked as rbenv plugin)
export RUBY_BUILD_CACHE_PATH=$XDG_CACHE_HOME/ruby-build
# }
# }

# GLOW {
# Create and view interactive cheatsheets on the command-line
# https://github.com/cheat/cheat#autocompletion
export GLOW_CONFIG_PATH=$XDG_CONFIG_HOME/glow/conf.yml
# }

# GOPASS {
# The slightly more awesome standard unix password manager for teams
# https://github.com/gopasspw/gopass/blob/master/docs/config.md
# if type gopass >/dev/null; then
export GOPASS_CONFIG_HOME=$XDG_CONFIG_HOME/gopass
export GOPASS_CONFIG=$GOPASS_CONFIG_HOME/config
export GOPASS_HOMEDIR=$HOME
export PASSWORD_STORE_DIR=$XDG_DATA_HOME/gopass/password-store
export PASSWORD_STORE_CLIP_TIME=45 #secs
export PASSWORD_STORE_ENABLE_EXTENSIONS=true pass
# fi
# }

# GIT-SECRET {
# A bash tool to store private data inside a git repo
# https://git-secret.io/
# https://dev.to/vinitjogani/a-guide-to-git-secret-49g3
export SECRETS_DIR=.secret       # sets the directory where git-secret stores its files, defaults to .gitsecret. It can be changed to any valid directory name.
export SECRETS_EXTENSION=.secret # sets the secret files extension
# export SECRETS_GPG_COMMAND=$XDG_BIN_HOME/gpg # sets the gpg alternatives, defaults to gpg
# }

# MISE {
# A polyglot tool version manager. It replaces tools like asdf, nvm, pyenv, rbenv, etc.
# https://mise.jdx.dev/
export MISE_CACHE_DIR=$XDG_CACHE_HOME/mise
# }

# NPM {
# https://docs.npmjs.com/cli/v7/commands/npm-config
# https://docs.npmjs.com/cli/v7/configuring-npm/npmrc
# npm config ls -l
# if type npm >/dev/null; then
export NO_UPDATE_NOTIFIER=1 # Opt out notiification https://www.npmjs.com/package/update-notifier#user-settings
# fi
# }

# NODE REPL {
# https://nodejs.org/api/repl.html#repl_environment_variable_options
# if type node >/dev/null; then
export NODE_NO_WARNINGS=1 # silence all process warnings
# fi
# }

# PNPM_HOME {
# https://pnpm.io
# if type pnpm >/dev/null; then
export PNPM_HOME=~/.local/bin
# fi
# }

# RIPGREP {
# A utility that combines the usability of The Silver Searcher with the raw speed of grep
# https://github.com/BurntSushi/ripgrep
# if type rg >/dev/null; then
export RIPGREP_CONFIG_PATH=$XDG_CONFIG_HOME/ripgrep/.ripgreprc
# fi
# }

# JQ {
# A lightweight and flexible command-line JSON processor
# https://stedolan.github.io/jq/manual/#Advancedfeatures
# if type jq >/dev/null; then
export JQ_COLORS='1;30:0;37:0;37:0;37:0;32:1;37:1;37'
# fi
# }

# WATCHMAN {
# Watches files and records, or triggers actions, when they change.
# https://facebook.github.io/watchman/
# if type watchman >/dev/null; then
export WATCHMAN_CONFIG_FILE=$XDG_CONFIG_HOME/watchman/config.json
# fi
# }

# CHEAT {
# Create and view interactive cheatsheets on the command-line
# https://github.com/cheat/cheat
# https://github.com/cheat/cheat#autocompletion
# if type cheat >/dev/null; then
export CHEAT_HOME=$XDG_CONFIG_HOME/cheat
export CHEAT_GISTS=$CHEAT_HOME/gists
export CHEAT_USE_FZF=true
# fi
# }

# BAT {
# A cat(1) clone with wings
# https://github.com/sharkdp/bat#configuration-file
# if type bat >/dev/null; then
export BAT_CONFIG_HOME=$XDG_CONFIG_HOME/bat
export BAT_CONFIG_PATH=$BAT_CONFIG_HOME/bat.conf
# fi
# }

# STARSHIP {
# The minimal, blazing-fast, and infinitely customizable prompt for any shell!
# https://starship.rs/config/#configuration
# if type starship >/dev/null; then
export STARSHIP_CONFIG_HOME=$XDG_CONFIG_HOME/starship
export STARSHIP_CONFIG=$STARSHIP_CONFIG_HOME/starship.toml
export STARSHIP_CACHE=$XDG_CACHE_HOME/starship
# fi
# }

# GOMPLATE {
# Go template configuration
# https://docs.gomplate.ca
# if type gomplate >/dev/null; then
export GOMPLATE_HOME=$XDG_CONFIG_HOME/gomplate
export GOMPLATE_TEMPLATES=$GOMPLATE_HOME/templates
# fi
# }

# TEALDEER {
# Very fast implementation of tldr in Rust
# https://github.com/dbrgn/tealdeer#configuration
export TEALDEER_CONFIG_DIR=$XDG_CONFIG_HOME/tealdeer
alias tl='tldr --list | fzf --exact --ansi | xargs tldr'
# }

# GITLINT {
# Path where gitlint looks for a config file
# https://jorisroovers.com/gitlint/user_defined_rules
export GITLINT_CONFIG=$XDG_CONFIG_HOME/gitlint/gitlint.cfg
# }

# LUA {
# luajit -e 'print(package.path)' luajit -e 'print(package.cpath)'
# https://nift.dev/docs/lua.html
export LUA_PATH="./?.lua;$HOMEBREW_SHARE/luajit-2.1/?.lua;/usr/local/share/lua/5.1/?.lua;/usr/local/share/lua/5.1/?/init.lua;$HOMEBREW_SHARE/lua/5.1/?.lua;/$HOMEBREW_SHARE/lua/5.1/?/init.lua"
export LUA_CPATH="./?.so;/usr/local/lib/lua/5.1/?.so;/opt/homebrew/lib/lua/5.1/?.so;/usr/local/lib/lua/5.1/loadall.so"
# }
