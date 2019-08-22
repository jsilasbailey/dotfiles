call plug#begin()
" Theme
Plug 'joshdick/onedark.vim'
Plug 'rakr/vim-one'

" Tpope
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'

" Git
Plug 'airblade/vim-gitgutter'

" Motion
Plug 'justinmk/vim-sneak'

" Utils
Plug 'roman/golden-ratio'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-airline/vim-airline'

" Language support
Plug 'sheerun/vim-polyglot'

" JS
Plug 'pangloss/vim-javascript'
Plug 'isRuslan/vim-es6'

" HTML
Plug 'mattn/emmet-vim'

" Vue
Plug 'posva/vim-vue'

" Goyo distraction free
Plug 'junegunn/goyo.vim'
call plug#end()

syntax enable
colorscheme one
set background=light

" Autoread
set autoread

" Relative numbers
set number relativenumber
set nu rnu

set mouse=a

set tabstop=2 shiftwidth=2
set expandtab

" Splits
set splitright
set splitbelow

" Quick window nav
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" nvim terminal
tnoremap <Esc> <C-\><C-n>

" if hidden is not set, TextEdit might fail.
set hidden

" Vim sneak
let g:sneak#label = 1

" Vue disable preprocessors
" autocmd FileType vue syntax sync fromstart
let g:vue_disable_pre_processors=1

" Trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

"ctrlp filter
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

" Only required for mac users to preven the terminal flash issue
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" WP for word processor
func! WordProcessor()
  " movement changes
  map j gj
  map k gk

  " formatting text
  setlocal formatoptions=1
  setlocal noexpandtab
  setlocal wrap
  setlocal linebreak

  " spelling and thesaurus
  setlocal spell spelllang=en_us
  set thesaurus+=/Users/jbailey/.vim/thesaurus/mthesaur.txt

  " complete+=s makes autocompletion search the thesaurus
  " set complete+=s
  set complete+=kspell
endfu

com! WP call WordProcessor()
