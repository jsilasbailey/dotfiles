set encoding=utf-8

" Leader
let mapleader = " "

" Load plugins
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands
set modelines=0   " Disable modelines as a security precaution
set nomodeline

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

filetype plugin indent on

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json
  autocmd BufRead,BufNewFile */zsh/configs/* set filetype=sh
augroup END

" When the type of shell script is /bin/sh, assume a POSIX-compatible
" shell for syntax highlighting purposes.
let g:is_posix = 1

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Use one space, not two, after punctuation.
set nojoinspaces

" Use ripgrep
if executable('rg')
  " Use Rg over Grep
  set grepprg=rg
  nnoremap \ :Rg<SPACE>
  nnoremap K :Rg <C-r><C-w><cr>
endif

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1

" Numbers
set number
set numberwidth=5

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<Tab>"
    else
        return "\<C-p>"
    endif
endfunction
inoremap <Tab> <C-r>=InsertTabWrapper()<CR>
inoremap <S-Tab> <C-n>

" Switch between the last two files
nnoremap <Leader><Leader> <C-^>

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Run commands that require an interactive shell
nnoremap <Leader>r :RunInInteractiveShell<Space>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Set tags for vim-fugitive
set tags^=.git/tags

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Set spellfile to location that is guaranteed to exist, can be symlinked to
" Dropbox or kept in Git and managed outside of thoughtbot/dotfiles using rcm.
set spellfile=$HOME/.vim-spell-en.utf-8.add

" Autocomplete with dictionary words when spell check is on
set complete+=kspell

" Always use vertical diffs
set diffopt+=vertical

" TRUEEEEE COLORS!!!!
if (has("termguicolors"))
 set termguicolors
endif

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" options: "light", "dark"
let g:aquarium_style="dark"

" On = 1 (default) | Off = 0
let g:aqua_bold = 1

" On = 1 | Off = 0 (default)
let g:aqua_transparency = 0

colorscheme aquarium

" Syntax coloring lines that are too long just slows down the world
set synmaxcol=1200

set cursorline
set colorcolumn=80

" Disable colorcolumn in qickfix windows
autocmd Filetype qf set colorcolumn&

" Use mouse
set mouse=a
set scrolloff=4

" Improve scroll speed
if !has('nvim')
  set ttyfast
  set ttyscroll=3
  set lazyredraw
endif

" Searches are case insentisive...
set ignorecase
" ... unless they contain at least one capital letter
set smartcase

" Force short git commits
autocmd Filetype gitcommit setlocal spell textwidth=72

" Remove fugitive buffers when done
autocmd BufReadPost fugitive://* set bufhidden=delete

" Tag file held in git
:set tags^=./.git/tags;

" Netrw settings
let g:netrw_banner = 0

" Golden ratio settings
let g:golden_ratio_autocommand = 0
nnoremap <C-w><C-r> :GoldenRatioResize<CR>

" Get vim-ruby to play nice with standardrb
let g:ruby_indent_assignment_style = 'variable'

" Use H to show documentation in preview window.
nnoremap <silent> H :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

autocmd BufNewFile,BufRead Dockerfile* set syntax=dockerfile
autocmd BufNewFile,BufRead *.txt set filetype=markdown

" vim-markdown options
let g:vim_markdown_folding_disabled = 1

" No hanging args for splitjoin-ruby
let g:splitjoin_ruby_hanging_args = 0
let g:splitjoin_ruby_curly_braces = 0

" Focus mode
nnoremap <silent> <leader>z :Goyo<cr>

" WP for word processor
" Sets up an ideal word processing env in vim
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
