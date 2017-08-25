#!/usr/bin/env sh
set -o errexit

bash-it disable alias all
bash-it disable plugin all
bash-it disable completion all

bash-it enable alias clipboard
bash-it enable plugin alias-completion autojump base dirs hg
bash-it enable completion awscli bash-it django system tmux

