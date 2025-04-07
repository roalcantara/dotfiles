# BUN {
  # generate completions for bun
  # https://github.com/oven-sh/bun/issues/1272
  if (( $+commands[bun] )); then
    [ -s $HOMEBREW_PREFIX/share/zsh/site-functions/_bun ] || bun completions
  fi
# }
