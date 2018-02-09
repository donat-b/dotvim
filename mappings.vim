" Load arpeggio
if exists("*arpeggio")
  call arpeggio#load()
endif

" Switching buffers
nnoremap <silent> <F12> :bnext<CR>
nnoremap <silent> <F11> :bprev<CR>
" Switching tabs
nnoremap <silent> ;tn :tabnext<CR>
nnoremap <silent> ;tp :tabprev<CR>
" Open new buffer
nnoremap <leader>T :enew<CR>
" Close the current buffer and move to the previous one
nmap <leader>bq :bp <BAR> bdelete! #<CR>

" Remove trailing whitespace
nnoremap <Leader>rtw :%s/\s\+$//e<CR>

" wordwise yank from line above
" sauce: http://vim.wikia.com/wiki/Wordwise_Ctrl-Y_in_insert_mode
inoremap <expr> <C-Y> matchstr(getline(line('.')-1), '\%' . virtcol('.') . 'v\%(\k\+\\|.\)')

" Execute current file
nnoremap <F10> :!%:p<CR>

nnoremap <leader>z :update<CR>

" fast escaping
imap ;; <ESC>

" Use Q for formatting
map Q gq

" insert/append a single character
nnoremap <C-i> i_<Esc>r
nnoremap <C-i><C-i> I_<Esc>r
nnoremap <C-i><C-k> A_<Esc>r

" Duplicate a line with increment
nnoremap yA yyp<C-a>

" copy/paste to/from x clipboard
vmap <leader>y :!xclip -f -sel clip<CR>
map <leader>p :r!xclip -o<CR>

" buffer
nmap <leader>s<left>  :leftabove  vnew<CR>
nmap <leader>s<right> :rightbelow vnew<CR>
nmap <leader>s<up>    :leftabove  new<CR>
nmap <leader>s<down>  :rightbelow new<CR>

" substitute with current word as a pattern
nnoremap <leader>su :%s/<C-r><C-w>//OD

" auto complete {} indent and position the cursor in the middle line
inoremap {<CR> {<CR>}<Esc>O
inoremap (<CR> (<CR>)<Esc>O
inoremap [<CR> [<CR>]<Esc>O
inoremap <<CR> <<CR>><Esc>O

" Git {{{
nnoremap <silent> <Leader>gA  :Git add .<BAR>GitGutter<CR>
nnoremap <silent> <Leader>ga  :Gwrite<BAR>sleep 50m<BAR>GitGutterAll<CR>
nnoremap <silent> <Leader>gb  :Gblame<CR>
nnoremap <silent> <Leader>gca :Gcommit --amend -v<CR>
nnoremap <silent> <Leader>gcc :Gcommit -v<CR>
nnoremap <silent> <Leader>gci :update <BAR> Gcommit --interactive --verbose<CR>
nnoremap <silent> <Leader>gcv :update <BAR> Gcommit -v %<CR>
nnoremap <silent> <Leader>gcV :update <BAR> Gcommit -v -m 'Update %:.' %<CR>
nnoremap <silent> <Leader>gd  :Gdiff<CR>
nnoremap <silent> <Leader>gdd :Gdiff HEAD<CR>
nnoremap <silent> <Leader>gf  :Gfetch<CR>
" update signs across all buffers
nnoremap <silent> <Leader>gg  :GitGutterAll<CR>
nnoremap <silent> <Leader>ggm :Git stash save <BAR> Git checkout master<CR>
nnoremap <silent> <Leader>ggp :Git diff --patch % > /tmp/%:t.diff<CR>
nnoremap <silent> <Leader>gll :Git log --graph --decorate --stat<CR>
nnoremap <silent> <Leader>glp :Git log --graph --decorate --stat --cc -p<CR>
" log for current buffer
nnoremap <silent> <Leader>glf :Git log --graph --decorate --stat --cc -p -- %<CR>
" list branches by recently commited
nnoremap <silent> <Leader>glr :Git recent<CR>
" git-pull
nnoremap <silent> <Leader>gpl :Gpull<CR>
" git-push
nnoremap <silent> <Leader>gps :Gpush<CR>
" unadd current file
nnoremap <silent> <Leader>grs :Git reset HEAD -- %<BAR>GitGutterAll<CR>
nnoremap <silent> <Leader>gs  :Gstatus<CR>

nnoremap <Leader>gm  :Gmerge<CR>
nnoremap <Leader>gr  :Git rebase<Space>
" TODO --their/ours checkout
" checkout --theirs --
" checkout --ours --
" }}}

" vimux
function! VimuxRevSearch()
  call VimuxSendKeys('')
  call _VimuxTmux("select-"._VimuxRunnerType()." -t ".g:VimuxRunnerIndex)
endfunction

nnoremap <Leader>vdr :call VimuxRunCommandInDir(getline('.'), expand('%:p'))<CR>
nnoremap <Leader>vi  :VimuxInspectRunner<CR>
nnoremap <Leader>vj  :call VimuxRunCommand('cd '.expand('%:p:h'))<CR>
nnoremap <Leader>v!  :call VimuxRunCommand('!!')<CR>
nnoremap <Leader>vl  :VimuxRunLastCommand<CR>
nnoremap <Leader>vlz :call VimuxRunLastCommand() <BAR>VimuxZoomRunner<CR>
nnoremap <Leader>vnr :call VimuxRunCommand(getline('.'), 0)<CR>
nnoremap <Leader>vp  :VimuxPromptCommand<CR>
nnoremap <Leader>vq  :VimuxCloseRunner<CR>
nnoremap <Leader>vr  :VimuxRunCommand getline('.')<CR>
nnoremap <Leader>vs  :call VimuxRevSearch()<CR>
nnoremap <Leader>vt  :VimuxTogglePane<CR>
nnoremap <Leader>vrz :call VimuxRunCommand(getline('.')) <BAR> VimuxZoomRunner<CR>
nnoremap <Leader>vv  :update<BAR>call VimuxRunCommand(
  \ 'sensible-browser '.expand('%:p'))<CR>
nnoremap <Leader>vx  :VimuxInterruptRunner<CR>
nnoremap <Leader>vz  :VimuxZoomRunner<CR>

" vim-wiki
nnoremap <Leader>wv <Plug>VimwikiVSplitLink

" Unite
nnoremap <Space>:   :Unite session<CR>
nnoremap <Space>;   :Unite file_rec/async<CR>
nnoremap <Space>a   :Unite file_rec/git<CR>
nnoremap <Space>b   :Unite buffer<CR>
nnoremap <Space>m   :Unite mapping<CR>
nnoremap <Space>r   :Unite register<CR>
nnoremap <Space>G   :Unite grep:.<CR>
nnoremap <Leader>bp :Unite -auto-preview buffer<CR>
nnoremap <Leader>ss :UniteSessionSave<CR>

" UltiSnips - Unite integration
inoremap <silent> <Space><Tab> <C-R>=(pumvisible()? "\<LT>C-E>":"")<CR><C-R>=UltiSnipsCallUnite()<CR>
nnoremap <silent> <Space><Tab> a<C-R>=(pumvisible()? "\<LT>C-E>":"")<CR><C-R>=UltiSnipsCallUnite()<CR>

" VimFiler
noremap <Leader>f  :VimFilerExplorer -winwidth=25 -split -toggle -no-quit<CR>
noremap <Leader>j  :VimFilerExplorer -find -winwidth=25 -split -toggle -no-quit<CR>

" Tabular
nnoremap <Leader>= :Tabularize<CR>

" Reload configuration
nnoremap <Leader><Delete>   :call ReloadVimrc()<CR>

""""""""""
" Toggles {{{

nnoremap <leader>tlc :set invlist<CR>
nnoremap <leader>tn  :set invnumber<CR>
nnoremap <leader>tp  :set invpaste paste?<CR>
nnoremap <leader>trn :set invrelativenumber<CR>
nnoremap <leader>tsl :setlocal spell! spelllang=en_us <BAR> set complete+=kspell<CR>
nnoremap <leader>tut :UndotreeToggle<CR>

" }}}

" Neocomplete
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Tmux
nnoremap <silent> <C-Left>  :TmuxNavigateLeft<CR>
nnoremap <silent> <C-Down>  :TmuxNavigateDown<CR>
nnoremap <silent> <C-Up>    :TmuxNavigateUp<CR>
nnoremap <silent> <C-Right> :TmuxNavigateRight<CR>
nnoremap <silent> <C-/>     :TmuxNavigatePrevious<CR>

" Insert current date/time
"Arpeggioinoremap <C-b>t <C-R>=strftime("%T")<CR>
"Arpeggioinoremap <C-b>s <C-R>=strftime('%FT%T')<CR>
