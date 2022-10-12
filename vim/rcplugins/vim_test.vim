" Run tests from vim
Plug 'https://github.com/vim-test/vim-test'

" vim-test mappings
nnoremap <silent> <Leader>tf :TestFile<CR>
nnoremap <silent> <Leader>tn :TestNearest<CR>
nnoremap <silent> <Leader>tl :TestLast<CR>
nnoremap <silent> <Leader>ta :TestSuite<CR>
nnoremap <silent> <Leader>gt :TestVisit<CR>

let test#strategy = "dispatch"

