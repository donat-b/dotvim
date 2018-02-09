call plug#begin('~/.vim/bundle')

" helper function for on-demand loading
function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

"------------------
" Color schemes {{{
"
Plug 'morhetz/gruvbox'
Plug 'nanotech/jellybeans.vim'

" }}}

" ------------------------------
" Syntax/language/formatting {{{

" Syntastic syntax checking plugin
Plug 'scrooloose/syntastic', { 'on': 'SyntasticToggle' }

" Haskell
Plug 'neovimhaskell/haskell-vim', { 'for': ['haskell'] }
" Completion plugin for Haskell, using ghc-mod
Plug 'eagletmt/neco-ghc', { 'for': ['haskell'] }
Plug 'eagletmt/ghcmod-vim', { 'for': ['haskell'] }

" Ansible yaml syntax
Plug 'chase/vim-ansible-yaml'

" Nginx syntax
Plug 'chr4/nginx.vim', { 'for': ['nginx'] }

" jinja templates
Plug 'lepture/vim-jinja'

" Python
Plug 'heavenshell/vim-pydocstring', { 'for': ['python'] }

" Add end keywords in various languages
Plug 'tpope/vim-endwise'

" Text filtering and alignment
Plug 'godlygeek/tabular', { 'on': 'Tabularize' }

" Code formatting in Vim by integrating existing code formatters.
Plug 'Chiel92/vim-autoformat'

" Snippet engine
Plug 'SirVer/ultisnips', { 'on': [] }

" vim-snipmate default snippets
Plug 'honza/vim-snippets'

" pandoc markdown syntax
Plug 'vim-pandoc/vim-pandoc-syntax'

" emmet
Plug 'mattn/emmet-vim', { 'for': ['css', 'haml', 'html', 'xml', 'xsl'] }

" Wrap and unwrap function arguments, lists, and dictionaries
Plug 'FooSoft/vim-argwrap'

" Ledger filetype support
Plug 'ledger/vim-ledger', { 'for': ['ledger'] }

" JSON
Plug 'elzr/vim-json'

" Go
Plug 'fatih/vim-go', { 'for': ['go'] }

" }}}

" Documentation {{{

" Pandoc integration
Plug 'vim-pandoc/vim-pandoc'

" Flexible viewer for any documentation source
Plug 'powerman/vim-plugin-viewdoc'

" Querying of the RFC database and loading RFC/STD documents into a Vim buffer
Plug 'mhinz/vim-rfc'

" }}}

" UI {{{

" Run commands in tmux
Plug 'benmills/vimux', Cond(len($TMUX) > 0)

" Shell reverse search emulation
Plug 'goldfeld/ctrlr.vim'

Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'Shougo/unite.vim'
  " File explorer
  Plug 'Shougo/vimfiler.vim'
  " Sessions
  Plug 'Shougo/unite-session'
  " Task list source for Unite
  Plug 'junkblocker/unite-tasklist'

"Plug 'Lokaltog/vim-easymotion'

" Lean & mean status/tabline for vim that's light as air
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Adds filetype glyphs (icons) to other plugins
Plug 'ryanoasis/vim-devicons'

" dependency
Plug 'tpope/vim-dispatch'

" Auto save files
Plug '907th/vim-auto-save'

" }}}

" Search/replace {{{

" Perl ack frontend for vim
Plug 'mileszs/ack.vim'

" Global Replace
Plug 'vim-scripts/Greplace.vim'

" incremental search improved
Plug 'haya14busa/is.vim'
" }}}

" File-type-specific templates
Plug 'noahfrederick/vim-skeleton'

" Ultimate calendar application
" :help calendar
Plug 'itchyny/calendar.vim'

" Commenting operations and styles
Plug 'scrooloose/nerdcommenter'

" ASCII drawing
Plug 'vim-scripts/DrawIt'

" Personal wiki for vim
Plug 'vimwiki/vimwiki'

" Execute program with options.
Plug 'thinca/vim-quickrun'

" An Interface to WEB APIs
Plug 'mattn/webapi-vim'

" Creating gists on http://gist.github.com
Plug 'lambdalisue/vim-gista'

" A simple vim plugin for quickly create and insert templates
Plug 'kabbamine/vbox.vim'

" Git runtime files
Plug 'tpope/vim-git'

" Git wrapper
Plug 'tpope/vim-fugitive'

" Shows a git diff in the 'gutter'
Plug 'airblade/vim-gitgutter'

" Vim sugar for UNIX shell commands
Plug 'tpope/vim-eunuch'

" Highlight matches
Plug 'qstrahl/vim-matchmaker'

" Quoting/parenthesizing
Plug 'tpope/vim-surround'

" Undo history visualizer
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }

" Increment dates, times, and more
Plug 'tpope/vim-speeddating'

" Changes working directory to project root
Plug 'airblade/vim-rooter'

" Handling column separated data with Vim
Plug 'chrisbra/csv.vim'

" Interactive scratchpad
Plug 'metakirby5/codi.vim'

" Uncover usage problems in your writing
Plug 'reedes/vim-wordy'

" Multi-language DBGP debugger
Plug 'joonty/vdebug', { 'on': 'VdebugStart' }

" Googling Stack Overflow
Plug 'MilesCranmer/gso', { 'on': 'GSO' }

" Controls {{{

" Multiple Selection in vim
Plug 'terryma/vim-multiple-cursors'

" Dark powered asynchronous completion framework for neovim
Plug 'Shougo/deoplete.nvim', Cond(has('nvim'))

" A code-completion engine
Plug 'valloric/YouCompleteMe', {'do': '~/.vim/bundle/YouCompleteMe/install.py', 'on': 'YcmRestartServer'}

" enable repeating supported plugin maps with .
Plug 'tpope/vim-repeat'

" move between Vim panes and tmux splits seamlessly
Plug 'christoomey/vim-tmux-navigator'

" Mappings for simultaneously pressed keys
Plug 'kana/vim-arpeggio'

" }}}

augroup load_insertm
  autocmd!
  autocmd InsertEnter * call plug#load('ultisnips', 'YouCompleteMe')
                     \| autocmd! load_insertm
augroup END

call plug#end()

" ------------------
" Plugin options {{{

"
" vim-wiki
"
let g:vimwiki_use_calendar = 1
let g:vimwiki_list = [{}, {'path': '~/vimwiki-work/'}]

"
" Unite
"
let g:unite_source_history_yank_enable = 1

call unite#custom#source('file_rec/async', 'ignore_pattern',
  \ join([
  \ '_cache/',
  \ '\.git/',
  \ '\.jpg',
  \ '\.molecule',
  \ '\.png',
  \ '\.retry',
  \ '\.stack-work',
  \ '\.vagrant/',
  \ 'vault.yml',
  \ ], '\|'))

"
" Airline
"
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts=1
let g:airline_section_y = '%{substitute(getcwd(), "/home/".$USER, "~", "")}'
let g:airline_theme = 'onedark'

"
" Haskell
"
let g:haskell_enable_quantification = 1   " hl of `forall`
let g:haskell_enable_recursivedo = 1      " hl of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " hl of `proc`
let g:haskell_enable_pattern_synonyms = 1 " hl of `pattern`
let g:haskell_enable_typeroles = 1        " hl of type roles
let g:haskell_enable_static_pointers = 1  " hl of `static`
let g:haskell_backpack = 1                " hl of backpack keywords

"
" Python mode
"
let g:pymode_lint_on_write = 0
let g:pymode_options_max_line_length = 120
let g:pymode_lint_options_pep8 =
  \ {'max_line_length': g:pymode_options_max_line_length}

"
" VimFiler
"
if exists("*vimfiler")
  let g:vimfiler_as_default_explorer = 1
  let g:vimfiler_no_default_key_mappings = 0
  call vimfiler#custom#profile('default', 'context', {
        \ 'edit_action' : 'tabopen',
        \ 'safe' : 1,
        \ 'toggle' : 1,
        \ 'winwidth' : 45,
        \ })
  autocmd FileType vimfiler nmap <buffer> q <Plug>(vimfiler_hide)
  autocmd FileType vimfiler nmap <buffer> Q <Plug>(vimfiler_exit)
endif

"
" YouCompleteMe
"
"let g:ycm_filetype_blacklist = {
"      \ 'tagbar' : 1,
"      \ 'qf' : 1,
"      \ 'notes' : 1,
"      \ 'markdown' : 1,
"      \ 'unite' : 1,
"      \ 'text' : 1,
"      \ 'vimwiki' : 1,
"      \ 'pandoc' : 1,
"      \ 'infolog' : 1,
"      \ 'mail' : 1
"      \}
let g:ycm_semantic_triggers = {'haskell' : ['.']}
let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_filetype_specific_completion_to_disable = {
  \ 'gitcommit': 1
  \}

let g:UltiSnipsExpandTrigger       = ''
let g:UltiSnipsListSnippets        = ''
let g:UltiSnipsJumpForwardTrigger  = '<C-J>'
let g:UltiSnipsJumpBackwardTrigger = '<C-K>'

"
" Syntastic
"
if exists("*SyntasticStatuslineFlag")
  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*
endif

let g:syntastic_mode_map = {
    \ "mode": "active",
    \ "active_filetypes": [],
    \ "passive_filetypes": ['ansible', 'yaml', 'vim', 'bash'] }

let g:syntastic_ansible_ansible_lint_exec = '/usr/local/bin/ansible-lint'
let g:syntastic_ansible_checkers = ['ansible_lint']

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Neocomplete
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#enable_auto_select = 0
" Show detailed information (type) of symbols.
let g:necoghc_enable_detailed_browse = 1
let g:necoghc_use_stack = 1

" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

"
" Skeleton
"
let g:skeleton_template_dir = '~/dotfiles/vim/templates'

"
" Rooter
"
let g:rooter_patterns = ['Vagrantfile', '.git/']
let g:rooter_silent_chdir = 1

"
" auto-save
"
let g:auto_save = 1
let g:auto_save_events = ["InsertLeave", "TextChanged"]
let g:auto_save_presave_hook = 'call AbortAutoSave()'

"
" ledger
"
let g:ledger_bin = 'hledger'

"
" viewdoc
"
let g:viewdoc_open = 'belowright vnew'
let g:viewdoc_only = 0

" }}}
