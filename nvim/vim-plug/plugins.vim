"" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

    " Better Syntax Support
    Plug 'sheerun/vim-polyglot'
    " File Explorer
    Plug 'scrooloose/NERDTree'
    " Auto pairs for '(' '[' '{'
    Plug 'ryanoasis/vim-devicons'
    "Plug 'jiangmiao/auto-pairs'
    " Themes
    Plug 'joshdick/onedark.vim'
    Plug 'tomasiser/vim-code-dark'
    " Git
    Plug 'itchyny/vim-gitbranch'
    " Javascript highlighting
    Plug 'pangloss/vim-javascript'
    " Autocomplete
    Plug 'neoclide/coc.nvim', {'branch':'release'}

    Plug 'yggdroot/indentLine'
    "Plug 'lukas-reineke/indent-blankline.nvim'
    " Airline
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    "Auto Indenting
    "Plug 'prettier/vim-prettier', {
  "\ 'do': 'yarn install --frozen-lockfile --production',
  "\ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] }
    "Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }
    
    " A Vim Plugin for Lively Previewing LaTeX PDF Output
    Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
    " Latex filetype and syntax
    "Plug 'lervag/vimtex'
    " Snippets
    Plug 'honza/vim-snippets' | Plug 'SirVer/ultisnips'
    "Plug 'Valloric/YouCompleteMe'


call plug#end()
