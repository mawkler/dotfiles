call NERDTreeAddKeyMap({
      \ 'key': '½',
      \ 'callback': 'NERDTreeCloseHandler',
      \ 'quickhelpText': 'Close NERDTree'
      \ })

call NERDTreeAddKeyMap({
      \ 'key': '<Esc>',
      \ 'callback': 'NERDTreeCloseHandler',
      \ 'quickhelpText': 'Close NERDTree'
      \ })

function! NERDTreeCloseHandler()
  NERDTreeClose
endfunction

call NERDTreeAddKeyMap({
      \ 'key': '<CR>',
      \ 'callback': 'NERDTreeSwitchWindow',
      \ 'quickhelpText': 'Switch to previous window'
      \ })

function! NERDTreeSwitchWindow()
  wincmd p
endfunction

