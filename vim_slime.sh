#!/bin/bash

# Clark Fitzgerald
# Set up regular development environment

# Pathogen, Vim package manager
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Install vim-slime
# https://github.com/jpalardy/vim-slime
cd ~/.vim/bundle
git clone git://github.com/jpalardy/vim-slime.git
