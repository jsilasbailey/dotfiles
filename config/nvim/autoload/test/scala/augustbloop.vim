" vim-test runner: august-backend (loquat) — route Scala tests through the warm
" Bloop server instead of sbt.
"
"   Unit specs        -> bloop test root-test -o "*<Spec>" [-- -z "<nearest>"]
"   Integration specs -> bloop test IntegrationTest-test -o com.august.AppSpec
"                          -- -J-Dtest.name.contains="<Spec>"
"                             [-J-Dtest.filter.pattern="<nearest>"]
"
" Integration tests do NOT use ordinary ScalaTest suite selection: every run goes
" through the com.august.AppSpec aggregator, which selects specs/tests via JVM
" system properties (the project's `it-only` mechanism). See
" loquat/.claude/skills/bloop-build-and-test/SKILL.md.

if !exists('g:test#scala#augustbloop#file_pattern')
  let g:test#scala#augustbloop#file_pattern = '\v^(.*spec.*|.*test.*|.*suite.*)\c\.scala$'
endif

" Bloop project (test) targets — overridable in case names change.
if !exists('g:test#scala#augustbloop#unit_project')
  let g:test#scala#augustbloop#unit_project = 'root-test'
endif
if !exists('g:test#scala#augustbloop#it_project')
  let g:test#scala#augustbloop#it_project = 'IntegrationTest-test'
endif

function! test#scala#augustbloop#executable() abort
  return 'bloop'
endfunction

function! test#scala#augustbloop#build_args(args) abort
  return a:args
endfunction

" Match Scala spec/test/suite files by filename. Custom runners are merged ahead
" of the built-ins, so matching here makes augustbloop win over sbttest/blooptest.
function! test#scala#augustbloop#test_file(file) abort
  return fnamemodify(a:file, ':t') =~? g:test#scala#augustbloop#file_pattern
endfunction

" Integration specs live under .../integration/src/test/scala/...
" Normalize to an absolute path first: vim-test passes expand('%'), which is
" often RELATIVE (e.g. integration/src/test/...), so matching a leading-slash
" pattern against the raw value would miss and fall through to the unit path.
function! s:is_integration(file) abort
  return fnamemodify(a:file, ':p') =~# '/integration/src/test/'
endfunction

" Leaf test name from the nearest `"..." in {` / `test("...")` above the cursor.
function! s:nearest_test(position) abort
  let l:name = test#base#nearest_test(a:position, g:test#scala#patterns)
  return substitute(join(l:name['test'], ''), '"', '', 'g')
endfunction

function! test#scala#augustbloop#build_position(type, position) abort
  let l:spec = fnamemodify(a:position['file'], ':t:r')

  if s:is_integration(a:position['file'])
    let l:project = g:test#scala#augustbloop#it_project
    " 'suite' (and anything not nearest/file): run ALL integration tests through
    " AppSpec, no name filter.
    if a:type !=# 'nearest' && a:type !=# 'file'
      return ['test ' . l:project . ' -o com.august.AppSpec']
    endif
    " nearest/file: scope to this spec via test.name.contains.
    let l:cmd = 'test ' . l:project . ' -o com.august.AppSpec'
          \ . ' -- -J-Dtest.name.contains=' . shellescape(l:spec)
    if a:type ==# 'nearest'
      let l:name = s:nearest_test(a:position)
      if !empty(l:name)
        let l:cmd .= ' -J-Dtest.filter.pattern=' . shellescape(l:name)
      endif
    endif
    return [l:cmd]
  endif

  " Unit specs: ordinary Bloop suite selection against root-test.
  let l:project = g:test#scala#augustbloop#unit_project
  if a:type ==# 'nearest'
    let l:name = s:nearest_test(a:position)
    if !empty(l:name)
      return ['test ' . l:project . ' -o ' . shellescape('*' . l:spec) . ' -- -z ' . shellescape(l:name)]
    endif
    return ['test ' . l:project . ' -o ' . shellescape('*' . l:spec)]
  elseif a:type ==# 'file'
    return ['test ' . l:project . ' -o ' . shellescape('*' . l:spec)]
  endif
  return ['test ' . l:project]
endfunction
