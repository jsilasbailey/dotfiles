" COC
Plug 'neoclide/coc.nvim', {'branch': 'release'}

let g:coc_global_extensions = [
      \ 'coc-tsserver',
      \ 'coc-rust-analyzer',
      \ 'coc-json',
      \ 'coc-solargraph'
      \ ]

if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']

  " Coc Prettier
  command! -nargs=0 Prettier :CocCommand prettier.formatFile
endif

if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

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
