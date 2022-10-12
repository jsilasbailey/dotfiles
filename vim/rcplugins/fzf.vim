if executable('rg')
  " Use Rg in fzf for listing files. Lightning fast and respects .gitignore
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden'
endif

" FZF
" If fzf has already been installed via Homebrew, use the existing fzf
" Otherwise, install fzf. The `--all` flag makes fzf accessible outside of vim
if isdirectory('/usr/local/opt/fzf')
  Plug '/usr/local/opt/fzf'
elseif isdirectory('/opt/homebrew/opt/fzf')
  Plug '/opt/homebrew/opt/fzf'
else
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
endif

" FZF.vim
Plug 'junegunn/fzf.vim'

" Empty value to disable preview window altogether
let g:fzf_preview_window = ['right,35%', 'ctrl-/']

" Map Leader ff to open fuzzy find (FZF)
nnoremap <Leader>ff :Files<cr>
" Fzf hotkeys
nnoremap <Leader>w :Windows<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>c :BCommits<CR>
nnoremap <Leader>gl :Commits<CR>
if executable('rg')
  nnoremap \ :Rg<SPACE>
  nnoremap <Leader>rg :Rg <C-r><C-w><cr>
endif
