import neovim
import os
import sys

nvim = neovim.attach('socket', path=os.environ['NVIM_LISTEN_ADDRESS'])
nvim.command(r':e +{1} "{0}"'.format(sys.argv[1], sys.argv[2]))

# 1. Add the following to SumatraPDF's inverse search command setting: pythonw C:\Users\Melker\.vim\connect-to-nvim.py "%f" %l
# 2. Set system variable NVIM_LISTEN_ADDRESS to something like: \\.\pipe\nvim-1234
