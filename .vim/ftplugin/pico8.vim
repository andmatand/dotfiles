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

ALEDisableBuffer

let b:sleuth_automatic = 0 " Disable vim-sleuth
setlocal nolist noexpandtab sw=2 ts=2 sts=2

let g:ctrlsf_default_root = 'cwd'
