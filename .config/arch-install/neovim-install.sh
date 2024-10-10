#!/bin/bash
set -e

yay -S neovim-git tree-sitter-git tree-sitter-cli-git pyright-git bash-language-server lua-language-server shellcheck lua lua51 luarocks ruff-lsp yaml-language-server ccls dockerfile-language-server nodejs-intelephense marksman stylua prettierd emmet-language-server ripgrep vim-language-server

(
mkdir -p ~/.local/share
cd ~/.local/share
python -m venv env
source env/bin/activate

echo "black
debugpy
httpie
isort
pynvim
requests
ruff
ruff-lsp
pre-commit
" > requirements.txt
pip install -r requirements
)

sudo mkdir -p /etc/pacman.d/hooks/
echo "[Trigger]
Operation = Upgrade
Type = Package
Target = neovim*

[Action]
Description = Update neovim python 3 client virtual env
When = PostTransaction
Exec = /usr/bin/bash -c \"/usr/bin/sudo -u jan /home/jan/.local/share/env/bin/pip install --upgrade pip -r /home/jan/.local/share/env/requirements.txt\"
" | sudo tee /etc/pacman.d/hooks/neovim.hook
