set guioptions-=T " Disable the toolbar
set guioptions-=r " Disable right scrollbar
set guioptions+=k " Prevent auto-resizing of window
set columns=84 lines=40

if has('macunix')
    set guifont=DejaVu\ Sans\ Mono:h14
elseif has('win32')
    set guifont=dejavu_sans_mono:h10.5:w6
else " Linux
    set guifont=DejaVu\ Sans\ Mono\ 14px
endif
set linespace=5

" GVIMRC OVERRIDES ===========================================================
" Load computer-specific overrides file if present
runtime gvimrc.override
