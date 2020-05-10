if exists("did_load_filetypes")
    finish
endif
augroup filetypedetect
    autocmd! BufRead,BufNewFile *.p8lua setfiletype pico8 | setlocal ts=2
augroup END


