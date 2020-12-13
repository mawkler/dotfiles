" Select a directory using fzf and cd to it

function s:fzf_cd(dir) abort
  if empty(a:dir)
    let dir = getcwd()
  else
    if !isdirectory(expand(a:dir))
      call s:print_error('Invalid directory: ' . a:dir)
      return
    endif
    let dir = a:dir
  endif

  let dir = fnamemodify(dir, ':p:~:.')
  let ignores = '-path ' . s:expand_ignores(g:fzf_cd_ignore_dirs)
  let command = 'find ' . dir . ' -type d -not \( ' . ignores . ' \) 2>/dev/null'

  call fzf#run(fzf#wrap({
        \ 'source': command,
        \ 'sink': 'cd'
        \ }))
endf

function s:expand_ignores(dirs) abort
  return join(map(a:dirs, '"\"**" . v:val . "**\""'), " -or -path ")
endf

command! -nargs=* -complete=dir Cd call s:fzf_cd(<q-args>)
nnoremap <silent> <M-c> :Cd<CR>

