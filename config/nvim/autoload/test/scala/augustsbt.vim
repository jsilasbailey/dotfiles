" vim-test runner: august-backend (loquat) — route Scala tests through the sbt
" thin client `sbtn`, which attaches to the running sbt server (the one Metals
" uses as its build server) instead of booting a new sbt.
"
"   Unit specs        -> sbtn 'testOnly *<Spec> [-- -z "<nearest>"]'
"   Unit suite        -> sbtn 'test'
"   Integration specs -> sbtn 'it-only <Spec> [-- -z "<nearest>"]'
"   Integration suite -> sbtn 'IntegrationTest/testOnly com.august.AppSpec'
"
" Integration tests go through the repo's `it-only` command, which selects the
" spec/test via the com.august.AppSpec aggregator (see loquat/CLAUDE.md).
" sbtn takes the whole sbt command line as ONE shell argument, so every command
" here is a single shellescape()d string.

if !exists('g:test#scala#augustsbt#file_pattern')
  let g:test#scala#augustsbt#file_pattern = '\v^(.*spec.*|.*test.*|.*suite.*)\c\.scala$'
endif

function! test#scala#augustsbt#executable() abort
  return 'sbtn'
endfunction

function! test#scala#augustsbt#build_args(args) abort
  return a:args
endfunction

" Match Scala spec/test/suite files by filename. Custom runners are merged ahead
" of the built-ins, so matching here makes augustsbt win over sbttest/blooptest.
function! test#scala#augustsbt#test_file(file) abort
  return fnamemodify(a:file, ':t') =~? g:test#scala#augustsbt#file_pattern
endfunction

" Integration specs live under .../integration/src/test/scala/...
" vim-test passes expand('%'), which is often relative, so normalize first.
function! s:is_integration(file) abort
  return fnamemodify(a:file, ':p') =~# '/integration/src/test/'
endfunction

" Leaf test name from the nearest `"..." in {` / `test("...")` above the cursor.
function! s:nearest_test(position) abort
  let l:name = test#base#nearest_test(a:position, g:test#scala#patterns)
  return substitute(join(l:name['test'], ''), '"', '', 'g')
endfunction

" sbt splits its own command line on spaces while honouring double quotes, so
" the ScalaTest name filter is wrapped in double quotes inside the single
" argument handed to sbtn.
function! s:with_filter(cmd, name) abort
  return empty(a:name) ? a:cmd : a:cmd . ' -- -z "' . a:name . '"'
endfunction

function! test#scala#augustsbt#build_position(type, position) abort
  let l:spec = fnamemodify(a:position['file'], ':t:r')

  if s:is_integration(a:position['file'])
    if a:type !=# 'nearest' && a:type !=# 'file'
      return [shellescape('IntegrationTest/testOnly com.august.AppSpec')]
    endif
    let l:cmd = 'it-only ' . l:spec
    if a:type ==# 'nearest'
      let l:cmd = s:with_filter(l:cmd, s:nearest_test(a:position))
    endif
    return [shellescape(l:cmd)]
  endif

  if a:type ==# 'nearest'
    return [shellescape(s:with_filter('testOnly *' . l:spec, s:nearest_test(a:position)))]
  elseif a:type ==# 'file'
    return [shellescape('testOnly *' . l:spec)]
  endif
  return [shellescape('test')]
endfunction
