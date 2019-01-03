function! FoldNonLuaSections() abort
    setlocal foldmethod=manual
    setlocal ambiwidth=double
    normal zE
    call feedkeys("/__lua__$/\<CR>zfgg", 'x')
    if search('^__gfx__$') > 0
        call feedkeys("zfG", 'x')
    endif
    normal ggj
endfunction

" Use two-space tabs (override vim-pico8-syntax plugin)
setlocal ts=2 sw=2 sts=2

call FoldNonLuaSections()

" Disable ALE because I don't know how to make that ignore the non-lua sections
ALEDisableBuffer
