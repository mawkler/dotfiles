set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

" -- NeoVim-specific mappings --
map <leader>v :source ~/.config/nvim/init.vim<CR>
map <leader><Tab>   :BufferNext<CR>
map <leader><S-Tab> :BufferPrevious<CR>
