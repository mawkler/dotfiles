set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

" -- NeoVim-specific mappings --
map <leader>v :source ~/AppData/Local/nvim/init.vim<CR>
map <leader><Tab>   :bnext<CR>
map <leader><S-Tab> :bprevious<CR>
