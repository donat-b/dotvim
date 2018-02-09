""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
set noshowmode
" don't give the "ATTENTION" message when an existing swap file is found
set shortmess+=A

" Encoding {{{
scriptencoding 'utf-8'
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set fileformats=unix,dos,mac
" }}}

" screen lines to use for the command-line
set cmdheight=4

" Indentation {{{
set autoindent
set expandtab
set shiftround
set shiftwidth=2
set softtabstop=2
set tabstop=2
" }}}

" don't break lines
set textwidth=0
set nofoldenable

" sensible search
set incsearch
set nohls

set iskeyword+=_,$,@,%,#

" Whitespace characters
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣

" Show line numbers
set number

" History
set history=5000

" Persistent undo
set undofile
set undolevels=1000
set undoreload=10000

" Automatically re-read files
set autoread

" Default window position when splitting
set splitbelow
set splitright

" time in milliseconds that is waited for a sequence to complete
set timeoutlen=600
autocmd InsertEnter * set timeoutlen=350
autocmd InsertLeave * set timeoutlen=600

" alias unnamed register to the + register
"set clipboard=unnamedplus

set viminfo='100,<50,s10,h,%

" Unclutter current working directory
" // means that file names will be built from the complete path to
" the file with all path separators substituted to percent signs.
set backupdir=~/.vim/.backup//,/tmp//
set directory=~/.vim/.swp//,/tmp//
set undodir=~/.vim/undo//,/tmp//

set verbosefile=~/.vim/verbose.log

" Plugins
" :help local-additions
source ~/dotfiles/vim/plugins.vim

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Misc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set color scheme
set background=dark
colorscheme gruvbox

""""""""""""
" FileType
""""""""""""

" unclutter netrw buffers
autocmd FileType netrw setl bufhidden=wipe
autocmd Filetype gitcommit setlocal spell textwidth=72

" unite doesn't work in paste mode
autocmd Filetype unite set nopaste

""""""""""""

" Add/change file extension in current buffer
" http://vim.wikia.com/wiki/Add/change_file_extension_in_current_buffer
command! -nargs=1 AddExt execute "saveas ".expand("%:p").<q-args>
command! -nargs=1 ChgExt execute "saveas ".expand("%:p:r").<q-args>

" Count word frequency
command! -range=% WordFrequency <line1>,<line2>call WordFrequency()
" Sort words
command! -nargs=0 -range SortWords call SortWords()

" Format JSON with python
command! FormatJSON %!python -m json.tool

source ~/dotfiles/vim/mappings.vim
source ~/dotfiles/vim/functions.vim
