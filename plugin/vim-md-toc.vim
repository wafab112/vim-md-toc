" MdToc

command! MdToc call s:toc()

function! s:rightPad(str, count)
    return a:str . repeat(' ', a:count - len(a:str))
endfunction

function! s:removeFileName()
    silent %s/^[^|]*|/
endfunction

function! s:removeColumn()
    silent %s/\s[c][^|]*|\s/
endfunction

function! s:alignHeadings()
    silent %s/^\(\d\+\)/\=s:rightPad(submatch(1), 6)
endfunction

function! s:build(pre, hashes)
    let l:preSpaces = repeat(' ', len(a:hashes) * 2 - 2)
    let l:postSpaces = repeat(' ', 12 - len(a:hashes) * 2)
    return a:pre . l:preSpaces . 'h' . len(a:hashes) . '>' . l:postSpaces
endfunction

function! s:toc()
    let l:md_fts = ['markdown']
    let l:index = index(l:md_fts, &filetype)

    if l:index == -1
        cclose
        echo "Error: File is not markdown"
        return
    endif

    vimgrep /^#/ %

    if line('$') == 1 && getline(1) == ''
        echo "Warning: File has no headings"
    endif

    copen

    set modifiable
        call s:removeFileName()
        call s:removeColumn()
        call s:alignHeadings()
        silent %s/^\(\d*\s*\)\(#*\)/\=s:build(submatch(1), submatch(2))
    set nomodifiable
    set nomodified
endfunction

