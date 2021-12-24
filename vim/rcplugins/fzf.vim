" If fzf has already been installed via Homebrew, use the existing fzf
" Otherwise, install fzf. The `--all` flag makes fzf accessible outside of vim
if isdirectory("/usr/local/opt/fzf")
  Plug '/usr/local/opt/fzf'
else
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
endif

" FZF
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'

" Fzf hotkeys
nnoremap <Leader>w :Windows<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>fl :BCommits<CR>
nnoremap <Leader>gl :Commits<CR>

" Map Ctrl + p to open fuzzy find (FZF)
nnoremap <c-p> :Files<cr>

" Use ripgrep
if executable('rg')
  " Use Rg in fzf for listing files. Lightning fast and respects .gitignore
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden'
endif
