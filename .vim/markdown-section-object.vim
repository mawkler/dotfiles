" -- Custom markdown text objects --

" All text inside two `---`
" Note: does not handle sections with just one empty line between both `---`'s
" because I'm lazy
function! s:inSection()
  call search('^---*$\n$', 'bceW')
  normal! 2j
  normal! 0v
  call search('$\n^---*$', 'ceW')
  normal! 2kg_
endfunction

" All text inside two `---`, including the trailing `---`
function! s:aroundSection()
  call search('^---.*$', 'bcW')
  normal! j
  normal! v$
  call search('^---.*$', 'eW')
endfunction

autocmd Filetype markdown xnoremap <silent> iP :<c-u>call <SID>inSection()<CR>
autocmd Filetype markdown onoremap <silent> iP :<c-u>call <SID>inSection()<CR>
autocmd Filetype markdown xnoremap <silent> aP :<c-u>call <SID>aroundSection()<CR>
autocmd Filetype markdown onoremap <silent> aP :<c-u>call <SID>aroundSection()<CR>
