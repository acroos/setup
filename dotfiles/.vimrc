" =============================================================================
" Plugin Manager: vim-plug (auto-installs itself on first run)
" Run :PlugInstall to install, :PlugUpdate to update
" =============================================================================

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin('~/.vim/plugged')

" Navigation
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Editing
Plug 'tpope/vim-surround'    " cs\"' to change surrounding quotes, ds\" to delete
Plug 'tpope/vim-commentary'  " gcc to toggle comment, gc in visual mode
Plug 'tpope/vim-repeat'      " makes . work with plugin commands

" UI
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'dracula/vim', { 'as': 'dracula' }

call plug#end()

" Auto-install missing plugins on launch
autocmd VimEnter *
  \ if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | source $MYVIMRC
  \| endif

" =============================================================================
" General
" =============================================================================

set nocompatible
syntax on
filetype plugin indent on

set encoding=utf-8
set fileencoding=utf-8

" Line numbers: absolute for current line, relative for all others
set number
set relativenumber

set cursorline          " highlight current line
set scrolloff=8         " keep 8 lines visible above/below cursor
set signcolumn=yes      " always show sign column (prevents layout shift)
set colorcolumn=120     " vertical ruler at 120 chars
set showmatch           " briefly jump to matching bracket

" Indentation (2 spaces)
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set smartindent

" Search
set incsearch           " search as you type
set hlsearch            " highlight all matches
set ignorecase          " case-insensitive search...
set smartcase           " ...unless query has uppercase

" Buffers & files
set hidden              " allow switching buffers without saving
set noswapfile
set nobackup
set updatetime=100      " faster gitgutter updates

" Persistent undo (survives closing vim)
if !isdirectory(expand('~/.vim/undodir'))
  call mkdir(expand('~/.vim/undodir'), 'p')
endif
set undodir=~/.vim/undodir
set undofile

" Better command-line completion
set wildmenu
set wildmode=list:longest

set backspace=indent,eol,start
set shortmess+=c        " suppress completion menu messages

" =============================================================================
" Color Scheme
" =============================================================================

set termguicolors
colorscheme dracula

" =============================================================================
" Key Mappings
" =============================================================================

let mapleader = " "

" --- Your mappings ---
" ;; exits insert mode
inoremap ;; <Esc>
" ;,w saves from insert mode
inoremap ;,w <Esc>:w<CR>
" ;,x saves and quits from insert mode
inoremap ;,x <Esc>:x<CR>

" --- Search ---
" Clear search highlight
nnoremap <leader>h :nohlsearch<CR>

" --- Navigation ---
" Keep cursor vertically centered when scrolling and searching
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap n nzzzv
nnoremap N Nzzzv

" Move between splits with Ctrl+hjkl
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Move lines up/down with Alt+j/k (normal, insert, visual)
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" --- fzf ---
nnoremap <leader>f :Files<CR>
nnoremap <leader>/ :Rg<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>l :BLines<CR>   " search lines in current buffer

" --- Git (Fugitive) ---
nnoremap <leader>gs :Git<CR>
nnoremap <leader>gc :Git commit<CR>
nnoremap <leader>gp :Git push<CR>
nnoremap <leader>gl :Git log --oneline<CR>
nnoremap <leader>gd :Gdiffsplit<CR>

" --- Splits ---
nnoremap <leader>v :vsplit<CR>
nnoremap <leader>s :split<CR>

" =============================================================================
" Plugin Config: vim-airline
" =============================================================================

let g:airline_powerline_fonts = 1          " requires a Nerd Font in iTerm2
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_theme = 'dracula'

" =============================================================================
" Plugin Config: vim-gitgutter
" =============================================================================

let g:gitgutter_sign_added    = '▎'
let g:gitgutter_sign_modified = '▎'
let g:gitgutter_sign_removed  = '▎'

" =============================================================================
" Plugin Config: fzf
" =============================================================================

" Use ripgrep for :Rg — respects .gitignore, fast
let g:fzf_layout = { 'down': '40%' }
