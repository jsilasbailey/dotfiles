" Use ripgrep
if executable('rg')
  " Use Rg in fzf for listing files. Lightning fast and respects .gitignore
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden'
endif

" If fzf has already been installed via Homebrew, use the existing fzf
" Otherwise, install fzf. The `--all` flag makes fzf accessible outside of vim
if isdirectory("/opt/homebrew/opt/fzf")
  Plug '/opt/homebrew/opt/fzf'
else
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
endif

" FZF
Plug 'junegunn/fzf.vim'

" Empty value to disable preview window altogether
let g:fzf_preview_window = []

" Fzf hotkeys
nnoremap <Leader>w :Windows<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>c :BCommits<CR>
nnoremap <Leader>gl :Commits<CR>

" Map Ctrl + p to open fuzzy find (FZF)
nnoremap <c-p> :Files<cr>
