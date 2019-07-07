function! FoldNonLuaSections() abort
    setlocal foldmethod=manual
    setlocal ambiwidth=double
    normal zE
    call feedkeys("/__lua__$/\<CR>zfgg", 'x')

    for sect in ['gfx', 'label', 'map', 'sfx', 'music']
        if search('^__' . sect . '__$') > 0
            " Fold from here to the bottom
            call feedkeys("zfG", 'x')
            break
        endif
    endfor

    normal ggj
endfunction

if search('^__lua__$') > 0
    call FoldNonLuaSections()
endif

" Disable ALE because I don't know how to make that ignore the non-lua sections
ALEDisableBuffer
