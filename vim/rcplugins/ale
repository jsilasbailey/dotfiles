let g:has_async = v:version >= 800 || has('nvim')

if g:has_async
  Plug 'dense-analysis/ale'
endif

" ALE
let g:ale_linters = {
      \   'ruby': ['rails_best_practices', 'reek', 'solargraph', 'standardrb'],
      \ }
let g:ale_fixers = {'ruby': ['standardrb']}
let g:ale_fix_on_save = 1

" ALE linting events
augroup ale
  autocmd!

  if g:has_async
    autocmd VimEnter *
      \ set updatetime=1000 |
      \ let g:ale_lint_on_text_changed = 0
    autocmd CursorHold * call ale#Queue(0)
    autocmd CursorHoldI * call ale#Queue(0)
    autocmd InsertEnter * call ale#Queue(0)
    autocmd InsertLeave * call ale#Queue(0)
  else
    echoerr "The thoughtbot dotfiles require NeoVim or Vim 8"
  endif
augroup END

" Move between linting errors
nnoremap ]r :ALENextWrap<CR>
nnoremap [r :ALEPreviousWrap<CR>
