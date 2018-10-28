set nocompatible
filetype off

" -- General --
syntax on
set vb t_vb= " Disable error bells
set ttyfast  " Spped up drawing
set swapfile
set backupdir=~/.vim/backup//
set directory=~/.vim/swp//
set undodir=~/.vim/undo//
set shortmess+=A " Ignores swapfiles when opening file
set autoread     " Automatically read in the file when changed externally
set hidden
set lazyredraw

" -- Autocompletion --
set completeopt=longest,preview " menuone seems to be causing bug error with multiple-cursors
set wildmenu                    " List and cycle through autocomplete suggestions on Tab
set wildcharm=<Tab> " Allows remapping of <Down> in wildmenu

" -- Searching --
set ignorecase " Case insensitive searching
set smartcase  " Except for when searching in CAPS
set incsearch  " Search while typing
set nohlsearch " Don't highligt search results

" -- Key mappings --
let mapleader = "\<Space>"

map      <C-Tab>          :bnext<CR>
map      <C-S-Tab>        :bprevious<CR>
nmap     <C-CR>           <leader>c<space>
vmap     <C-CR>           <leader>c<space>
imap     <C-k>            <c-o>O
nnoremap Y                y$
map      <leader>y        "+y
map      <leader>Y        "+Y
map      <leader>d        "+d
map      <leader>D        "+D
map      <leader>p        "+p
map      <leader>P        "+P
map!     <M-v>            <C-r>+
map      <C-q>            :qa<CR>
nnoremap <S-Tab>          <<
vnoremap <S-Tab>          <gv
inoremap <S-Tab>          <C-o><<
autocmd  BufEnter,BufRead *      nnoremap <Tab> ==
autocmd  BufEnter,BufRead *      vnoremap <Tab> =gv
autocmd  BufEnter,BufRead *.py   nmap <Tab> >>
autocmd  BufEnter,BufRead *.py   vmap <Tab> >gv
nnoremap <M-o>            <C-i>
map      <S-CR>           <C-w>W
map      -                3<C-W><
map      +                3<C-W>>
nmap     <M-+>            <C-W>+
nmap     <M-->            <C-W>-
nmap     <C-j>            o<Esc>
nmap     <C-k>            O<Esc>
nmap     <C-s>            :w<CR>
" The `:set buftype=` fixes a bug with tcp
imap     <C-s>            <C-o>:w<CR>
vmap     <C-s>            <Esc>:w<CR>gv
nmap     d_               d^
nmap     <BS>             X
nmap     <S-BS>           x
nmap     <A-BS>           db
map!     <A-BS>           <C-w>
nmap     <A-S-BS>         dw
imap     <A-S-BS>         <C-o>dw
map      <M-d>            dw
imap     <C-j>            <CR>
map      <M-a>            v<C-a>
map      <M-x>            v<C-x>
" Cursor movement in cmd and insert mode--------
map!     <C-f>            <Right>
map!     <M-f>            <C-Right>
map!     <C-b>            <Left>
map!     <M-b>            <C-Left>
map!     <M-h>            <Left>
map!     <M-j>            <Down>
map!     <M-k>            <Up>
map!     <M-l>            <Right>
map!     <M-w>            <C-Right>
cmap     <C-a>            <Home>
cmap     <C-p>            <Up>
cmap     <C-n>            <Down>
imap     <M-o>            <C-o>o
imap     <M-O>            <C-o>O
"----------------------------------------------
map      <M-j>            }
map      <M-k>            {
map      <C-Space>        zt
nmap     ö                ciw
nmap     Ö                ciW
nmap     ä                viw
nmap     Ä                viW
nmap     å                ci(
nmap     Å                ci"
nmap     <C-c>            <Nop>
" vim-surround----------------------------------
vmap     s                <Plug>VSurround
vmap     S                <Plug>VgSurround
nmap     s                ys
nmap     S                ys$
" ----------------------------------------------
vmap     <                <gv
vmap     >                >gv
map      <Leader>;        m0A;<Esc>`0
map      <Leader>,        m0A,<Esc>`0
map      <Leader>.        m0A.<Esc>`0
map      <Leader>v        :source ~/.vimrc<CR>
map      <Leader>V        :edit ~/.vimrc<CR>
map      <Leader>N        :edit ~/.config/nvim/init.vim<CR>
map      <Leader>Z        :edit ~/.zshrc<CR>
map      <leader>U        :cd ~/Dropbox/Uppsala/<CR>
nmap     gF               :e <C-r>+<CR>
nmap     <leader>F        :let @+ = expand("%")<CR>:echo "Yanked file path: <C-r>+"<CR>
vnoremap .                :normal .<CR>
vnoremap //               y?<C-R>"<CR>
map      <leader>/        :execute '/\V' . escape(input('/'), '\\/')<CR><C-r>+<CR>
map      g/               /\<\><Left><Left>
map      <leader>S        :setlocal spell!<CR>:echo "Toggled spell checking"<CR>
nmap     <leader>r       :%substitute/<C-R><C-W>//gci<Left><Left><Left><Left>
nmap     <leader>R       :%substitute/<C-R><C-W>//I<Left><Left>
vmap     <leader>r       y:<C-U>%substitute/<C-R>0//gci<Left><Left><Left><Left>
vmap     <leader>R       y:<C-U>%substitute/<C-R>0//I<Left><Left>
map      <leader>gd      <C-w>v<C-w>lgdzt<C-w><C-p>
map      <leader>T       :set tabstop=4 shiftwidth=4 noexpandtab<CR>:retab!<CR>m0gg=G`0m
map      <leader>t       :set tabstop=2 shiftwidth=2 expandtab<CR>:retab!<CR>m0gg=G`0m
map      Q               @@
map      <S-space>       qq
nnoremap §               <C-^>

if has('nvim')
  map <leader><Tab>   :bnext<CR>
  map <leader><S-Tab> :bprevious<CR>
endif

" -- Lines and cursor --
set number
set relativenumber
hi  CursorLineNr term=bold ctermfg=Yellow gui=bold guifg=Yellow
set cursorline                   " Cursor highlighting
set scrolloff=8                  " Cursor margin
set textwidth=0                  " Disable auto line breaking
set nrformats+=hex,bin,alpha     " Allow Ctrl-A/X for hex, binary and letters
set guicursor=n:blinkwait0       " Disables cursor blinking in normal mode
set guicursor=i:ver25-blinkwait0 " And in insert mode

" -- Themes --
set encoding=utf8

" -- Airline --
set laststatus=2 " Always display status line
" set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 13

" Disable toolbar, scrollbar and menubar
set guioptions-=T
set guioptions-=r
set guioptions-=m
set guioptions-=L

" Start in maximized window
if has("gui_running")
  set lines=999 columns=999
endif

" -- Tab characters --
filetype plugin indent on                                   " show existing tab with 4 spaces width
set list lcs=tab:\|\                                        " Show line for each tab indentation
set shiftwidth=2
" autocmd BufEnter * set sw=2                               " Use indent of 2 spaces
autocmd BufEnter,BufRead *.js,*.css,*py  setlocal sw=4 ts=4 " But 4 spaces in certain files
set tabstop=4                                               " An indentation every fourth column
set autoindent                                              " Follow previous line's indenting
set expandtab                                               " Tabs are spaces
set backspace=indent,eol,start                              " Better backspace
set cinkeys-=0#                                             " Indent lines starting with `#`

" -- For editing multiple files with `*` --
com! -complete=file -nargs=* Edit silent! exec "!vim --servername " . v:servername . " --remote-silent <args>"
