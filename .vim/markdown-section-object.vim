" -- Custom markdown text objects --

" All text inside two `---`
" Note: does not handle sections with just one empty line between both `---`'s
" because I'm lazy
function! s:inSection()
  call search('^---*$\n$', 'bceW')
  normal! 2j
  normal! 0v
  if search('$\n^---*$', 'ceW') != 0
    normal! 2kg_
  else
    " If we are in the last section of the buffer
    normal! Gg_
  endif
endfunction

" All text inside two `---`, including the trailing `---`
function! s:aroundSection()
  call search('^---.*$', 'bcW')
  normal! j
  normal! V
  if search('^---.*$', 'eW') == 0
    " If we are in the last section of the buffer
    echo 'foo'
    normal! Gg_ok
    call search('^[^$]', 'bW')
    normal! j
  endif
  normal! v
endfunction

autocmd Filetype markdown xnoremap <silent> iP :<c-u>call <SID>inSection()<CR>
autocmd Filetype markdown onoremap <silent> iP :<c-u>call <SID>inSection()<CR>
autocmd Filetype markdown xnoremap <silent> aP :<c-u>call <SID>aroundSection()<CR>
autocmd Filetype markdown onoremap <silent> aP :<c-u>call <SID>aroundSection()<CR>
