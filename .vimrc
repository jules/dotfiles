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

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
let g:make = 'gmake'
if exists('make')
    let g:make = 'make'
endif

Plug 'itchyny/lightline.vim'

"****************************************************
" Development Bundle
"****************************************************
Plug 'fatih/vim-go', {'do': ':GoInstallBinaries'}			"golang support
Plug 'rust-lang/rust.vim'                                   "rust support
Plug 'neoclide/coc.nvim', {'branch': 'release'}             "language server
Plug 'wakatime/vim-wakatime'                                "time tracker

call plug#end()

"**********************************************
" General stuff
"**********************************************

inoremap jk <esc>

let mapleader="\<Space>"
nnoremap <leader>w :w<CR>

" Insert mode cursor should be a block
set guicursor=i:block

" Colorscheme (because i cant do 16 bit coloring in neovim lol)
colorscheme iceberg

" Easy window switch
nnoremap <C-j> <C-w>j
nnoremap <C-h> <C-w>h
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Set tabs four spaces
set softtabstop=4
set shiftwidth=4
set tabstop=4
set expandtab

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

" CoC stuff
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" highlight Pmenu ctermfg=15 guibg=Grey ctermbg=7 
