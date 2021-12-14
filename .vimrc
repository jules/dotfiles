set nocompatible
syntax enable

"**************************************
"" Vim-Plug core
"**************************************
let vimplug_exists=expand('~/.vim/autoload/plug.vim')

let g:vim_bootstrap_langs = "go"
let g:vim_bootstrap_editor = "vim"

if !filereadable(vimplug_exists)
    if !executable("curl")
	echoerr "you have to install curl first or install vim-plug yourself"
	execute "q!"
    endif
    echo "Installing Vim-Plug"
    echo ""
    silent exec "!\curl -fLo " . vimplug_exists . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
    let g:not_finish_vimplug = "yes"

    autocmd VimEnter * PlugInstall
endif

" Required:
call plug#begin(expand('~/.vim/plugged'))

Plug 'scrooloose/nerdtree'

if isdirectory('/usr/local/opt/fzf')
    Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
else
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
    Plug 'junegunn/fzf.vim'
endif
let g:make = 'gmake'
if exists('make')
    let g:make = 'make'
endif

Plug 'itchyny/lightline.vim'

"****************************************************
"" Development Bundle
"****************************************************
Plug 'fatih/vim-go', {'do': ':GoInstallBinaries'}			"golang support
Plug 'rust-lang/rust.vim'

call plug#end()

"**********************************************
" General stuff
"**********************************************

inoremap jk <esc>

let mapleader="\<Space>"
nnoremap <leader>w :w<CR>

" Easy window switch
nnoremap <C-j> <C-w>j
nnoremap <C-h> <C-w>h
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Set tabs two spaces
set softtabstop=4
set shiftwidth=4
set tabstop=4

" Searching "{{{
set hlsearch
set incsearch
set ignorecase
set smartcase
" }}}

" remember my undo history
set undodir=~/.vimdid
set undofile

" I use git, no need for backups.
set nobackup
set nowritebackup
set noswapfile
set encoding=utf-8

" Rid of annoyances "{{{
set noerrorbells
set novisualbell
set t_vb=
"}}}

set ruler

" Hybrid line number "{{{
set number relativenumber

augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup end
"}}}

" style
let g:go_list_type = "quickfix"
let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 1

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_structs = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_space_tab_error = 0
let g:go_highlight_array_whitespace_error = 0
let g:go_highlight_trailing_whitespace_error = 0
let g:go_highlight_extra_types = 1

let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['vet']
"}}}

" Ctrl-p like functionalities but with fzf
nnoremap <leader>f :FZF<CR>
" Searching for content within the file
nnoremap <C-g> :Rg<CR>

let g:rustfmt_autosave = 1
"let g:rustfmt_options = '--edition 2018'
