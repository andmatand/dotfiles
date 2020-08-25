function! FoldNonLuaSections() abort
    setlocal foldmethod=manual
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

let b:sleuth_automatic = 0 " Disable vim-sleuth
setlocal nolist noexpandtab sw=2 ts=2 sts=2

if !exists("pico8_autocommands_loaded")
    let pico8_autocommands_loaded = 1
    autocmd BufNewFile,BufRead,BufEnter *.p8 setlocal nolist noet sw=2 ts=2
        \ sts=2
endif
