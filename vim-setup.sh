#!/bin/bash

# Install required packages
echo 'Installing required apt packages...'
sudo apt install -y curl git wget vim npm

# Switch to home dir and copy .vimrc
echo 'Downloading vimrc...'
cd $HOME
wget https://gist.githubusercontent.com/aqual3o/b6c2478c38d1e08f76697b224efb9490/raw/91b65db021abaf2fbd4989a33352d55b32b9af19/.vimrc

# Switch to home dir and copy .eslintrc.json
echo 'Downloading eslintrc...'
cd $HOME
wget https://gist.githubusercontent.com/aqual3o/b44d5a3bd66294cd2047ec617bc00922/raw/cf6766b5d2275182fd3add47d6422787315d5477/.eslintrc.json

# Install vundle
echo 'Setting up vundle...'
cd $HOME
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Install vundle plugins from vimrc
echo 'Installing vim plugins...'
cd $HOME
vim +PluginInstall +qall

# Install colorschemes (base-16)
echo 'Installing vim colorschemes...'
cd $HOME
git clone https://github.com/chriskempson/base16-vim.git
mkdir -p $HOME/.vim/colors
mv $HOME/base16-vim/colors/* $HOME/.vim/colors/
rm -rf $HOME/base16-vim

# Install linting modules
echo 'Installing linting helper packages...'
cd $HOME
npm install -g eslint_d eslint babel-eslint eslint-plugin-react

# Add C++ and JavaScript plugin support
echo 'Updating vimrc with C++ and JS plugin support...'
cat <<EOL >> $HOME/.vimrc

" C++ Plugins
Plugin 'vim-syntastic/syntastic'
Plugin 'octol/vim-cpp-enhanced-highlight'

" JavaScript Plugins
Plugin 'dense-analysis/ale'
Plugin 'pangloss/vim-javascript'
Plugin 'maxmellon/vim-jsx-pretty'
Plugin 'prettier/vim-prettier'

" Syntastic C++ settings
let g:syntastic_cpp_compiler = 'g++'
let g:syntastic_cpp_checkers = ['gcc', 'clang']

" ESLint and Prettier settings
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'typescript': ['eslint'],
\}
let g:ale_fixers = {
\   'javascript': ['eslint', 'prettier'],
\   'typescript': ['eslint', 'prettier'],
\}
let g:ale_fix_on_save = 1
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0
EOL

# Re-install vim plugins with the new ones
echo 'Installing new vim plugins...'
vim +PluginInstall +qall

