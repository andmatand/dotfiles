if exists("did_load_filetypes")
    finish
endif
augroup filetypedetect
    autocmd! BufRead,BufNewFile *.gd    setfiletype gdscript
    autocmd! BufRead,BufNewFile *.p8    setfiletype pico8
    autocmd! BufRead,BufNewFile *.p8lua setfiletype pico8
augroup END
