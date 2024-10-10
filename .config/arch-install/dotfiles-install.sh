#!/bin/bash
set -e

git clone --bare https://github.com/johnybx/dotfiles "$HOME"/.dotfiles
git --git-dir="$HOME"/.dotfiles --work-tree="$HOME" reset --hard
git --git-dir="$HOME"/.dotfiles --work-tree="$HOME" checkout
