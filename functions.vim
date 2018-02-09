" Automatically create directories on save
function! s:MkNonExDir(file, buf)
  if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
    let dir=fnamemodify(a:file, ':h')
    if !isdirectory(dir)
      call mkdir(dir, 'p')
    endif
  endif
endfunction

augroup BWCCreateDir
  autocmd!
  autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

function! Min(number, ...)
  let result = a:number
  let index = a:0
  while index > 0
    let result = (a:{index} > result) ? result : a:{index}
    let index = index - 1
  endwhile
  return result
endf

" Sorts numbers in ascending order.
" Examples:
" [2, 3, 1, 11, 2] --> [1, 2, 2, 3, 11]
" ['2', '1', '10','-1'] --> [-1, 1, 2, 10]
function! Sorted(list)
  " Make sure the list consists of numbers (and not strings)
  " This also ensures that the original list is not modified
  let nrs = ToNrs(a:list)
  let sortedList = sort(nrs, "NaturalOrder")
  echo sortedList
  return sortedList
endfunction

" Comparator function for natural ordering of numbers
function! NaturalOrder(firstNr, secondNr)
  if a:firstNr < a:secondNr
    return -1
  elseif a:firstNr > a:secondNr
    return 1
  else
    return 0
  endif
endfunction

" Coerces every element of a list to a number. Returns a new list without
" modifying the original list.
function! ToNrs(list)
  let nrs = []
  for elem in a:list
    let nr = 0 + elem
    call add(nrs, nr)
  endfor
  return nrs
endfunction

function! WordFrequency() range
  " Words are separated by whitespace or punctuation characters
  let wordSeparators = '[[:blank:][:punct:]]\+'
  let allWords = split(join(getline(a:firstline, a:lastline)), wordSeparators)
  let wordToCount = {}
  for word in allWords
    let wordToCount[word] = get(wordToCount, word, 0) + 1
  endfor

  let countToWords = {}
  for [word,cnt] in items(wordToCount)
    let words = get(countToWords,cnt,"")
    " Append this word to the other words that occur as many times in the text
    let countToWords[cnt] = words . " " . word
  endfor

  " Create a new buffer to show the results in
  new
  setlocal buftype=nofile bufhidden=hide noswapfile tabstop=20

  " List of word counts in ascending order
  let sortedWordCounts = Sorted(keys(countToWords))

  call append("$", "count \t words")
  call append("$", "--------------------------")
  " Show the most frequent words first -> Descending order
  for cnt in reverse(sortedWordCounts)
    let words = countToWords[cnt]
    call append("$", cnt . "\t" . words)
  endfor
endfunction

function! SortWords()
    " Get the visual mark points
    let StartPosition = getpos("'<")
    let EndPosition = getpos("'>")

    if StartPosition[0] != EndPosition[0]
        echoerr "Range spans multiple buffers"
    elseif StartPosition[1] != EndPosition[1]
        " This is a multiple line range, probably easiest to work line wise

        " This could be made a lot more complicated and sort the whole
        " lot, but that would require thoughts on how many
        " words/characters on each line, so that can be an exercise for
        " the reader!
        for LineNum in range(StartPosition[1], EndPosition[1])
            call setline(LineNum, join(sort(split(getline('.'), ' ')), " "))
        endfor
    else
        " Single line range, sort words
        let CurrentLine = getline(StartPosition[1])

        " Split the line into the prefix, the selected bit and the suffix

        " The start bit
        if StartPosition[2] > 1
            let StartOfLine = CurrentLine[:StartPosition[2]-2]
        else
            let StartOfLine = ""
        endif
        " The end bit
        if EndPosition[2] < len(CurrentLine)
            let EndOfLine = CurrentLine[EndPosition[2]:]
        else
            let EndOfLine = ""
        endif
        " The middle bit
        let BitToSort = CurrentLine[StartPosition[2]-1:EndPosition[2]-1]

        " Move spaces at the start of the section to variable StartOfLine
        while BitToSort[0] == ' '
            let BitToSort = BitToSort[1:]
            let StartOfLine .= ' '
        endwhile
        " Move spaces at the end of the section to variable EndOfLine
        while BitToSort[len(BitToSort)-1] == ' '
            let BitToSort = BitToSort[:len(BitToSort)-2]
            let EndOfLine = ' ' . EndOfLine
        endwhile

        " Sort the middle bit
        let Sorted = join(sort(split(BitToSort, ' ')), ' ')
        " Reform the line
        let NewLine = StartOfLine . Sorted . EndOfLine
        " Write it out
        call setline(StartPosition[1], NewLine)
    endif
endfunction

" Add argument (can be negative, default 1) to global variable i.
" Return value of i before the change.
function! Inc(...)
  let result = g:i
  let g:i += a:0 > 0 ? a:1 : 1
  return result
endfunction

if !exists("*ReloadVimrc")
  function! ReloadVimrc()
    try
      if expand('%:t') == 'vimrc'
        update
      endif

      source ~/.vimrc
    catch /^Vim\%((\a\+)\)\=:E/	" catch all Vim errors
      redraw | echoerr v:exception
    endtry
  endfunction
endif

function! InsPackage()
  read !xclip -o
  silent s/\("\|'\|=\)//ge
  silent s/-[.0-9]\+\(-r[0-9]\+\)\?[^-]*//e
  silent s/^/- /
  execute 'normal! =='
endfunction

" ---------------
" Make a scratch buffer with all of the leader keybindings.
"
" Adapted from http://ctoomey.com/posts/an-incremental-approach-to-vim/
" https://github.com/gcallaghan/dot_vim/blob/master/functions.vim
" ---------------
function! ListLeaders()
  silent! redir @b
  silent! nmap <LEADER>
  silent! redir END
  silent! new
  silent! set buftype=nofile
  silent! set bufhidden=hide
  silent! setlocal noswapfile
  silent! put! b
  silent! g/^s*$/d
  silent! %s/^.*,//
  silent! normal ggVg
  silent! sort
  silent! let lines = getline(1,"$")
  silent! normal <esc>
endfunction

" ---------------------------
" plugin helper functions {{{

" UltiSnips - Unite integration
function! UltiSnipsCallUnite()
  Unite -start-insert -winheight=100 -immediately -no-empty ultisnips
  return ''
endfunction

" autosave excludes
function! AbortAutoSave()
  if &ft == 'gitcommit'
    let g:auto_save_abort = 1
  else
    let g:auto_save_abort = 0
  endif
endfunction

" }}}
