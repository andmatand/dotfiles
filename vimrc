" Always set the working directory to the current file's directory
autocmd BufEnter * silent! lcd %:p:h
let g:netrw_keepdir=0

" Set search options
set ignorecase
set smartcase
set gdefault
set incsearch
set hlsearch

" Set display options
syntax on
set showcmd " Show selection length in ruler
set colorcolumn=80
set completeopt-=preview

" Enable matchit
filetype plugin on
runtime macros/matchit.vim

" Enable wildmenu
if has("wildmenu")
    set wildmenu
endif

" Set indenting options
filetype plugin indent on
set autoindent
set expandtab shiftwidth=4 tabstop=4

" Set default formatoptions
set formatoptions=tcroqlj

" Diable annoying audio bell
set visualbell

" Make backspace work as expected
set backspace=indent,eol,start

" Set colorscheme
colorscheme gruvbox
set background=dark
"set termguicolors

" Set GVim options
if has("gui_running")
    set guioptions-=T " Disable the toolbar
    set columns=120 lines=40

    if has("macunix")
        set guifont=DejaVu\ Sans\ Mono:h14
    elseif has("win32")
        set guifont=dejavu_sans_mono:h10.5:w6
    else " Linux
        set guifont=DejaVu\ Sans\ Mono\ 14px
    endif
    set linespace=5
end

" Set split options
set splitbelow
set splitright

" Save temp files in a global directory
set directory=~/.vim/tmp
set backupdir=~/.vim/tmp

" Keep undo history across sessions by storing it in a file
if has('persistent_undo')
    set undofile
    set undodir=$HOME/.vim/undo
endif

" Source .vimrc after saving it
if has("autocmd")
    autocmd! bufwritepost vimrc source $MYVIMRC
endif



" KEY MAPPINGS ===============================================================
" Clear hlsearch with backspace
nnoremap <backspace> :noh<CR>:<backspace>

" Map <Enter> to insert a line-break before the current character
nnoremap <CR> i<CR><Esc>
" But in the quickfix list, let Enter still behave normally
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>

" Map <Space> to insert a space before the current character
nnoremap <Space> i <Esc>

" Refresh several things with F5
" (ctrp.vim, vim-gitgutter, syntax highlighting weirdness)
nnoremap <F5> :CtrlPClearCache<CR>:GitGutter<CR>:syntax sync fromstart<CR>
    \:<backspace>

" Pretty-print JSON with \j. Works on a selection or a whole buffer.
nnoremap <leader>j :%!python -m json.tool<CR>:set ft=json<CR>
vnoremap <leader>j :!python -m json.tool<CR>

" Pretty-print XML with \x. Works on a selection or a whole buffer.
nnoremap <leader>x :%!XMLLINT_INDENT="    " xmllint --format -<CR>:set ft=xml<CR>
vnoremap <leader>x :!XMLLINT_INDENT="    " xmllint --format -<CR>

" Insert current date with \d
nnoremap <leader>d :put =strftime('%F')<CR>

" FILETYPE-SPECIFIC STUFF ====================================================
" PICO-8: Use lua syntax highlighting, use 2-space tabs, fold non-lua sections
au BufRead,BufNewFile *.p8 call InitPico8()
function! InitPico8()
    setlocal ft=lua ts=2 sw=2 sts=2
    setlocal foldmethod=manual
    setlocal ambiwidth=double
    normal zE
    call feedkeys("/__lua__$/\<CR>zfgg", 'x')
    call feedkeys("/__gfx__$/\<CR>zfG", 'x')
    normal gg
    ALEDisableBuffer
endfunction

" CSS: Make Ctrl + n/p autocomplete more useful
autocmd FileType css,scss setlocal iskeyword=@,48-57,_,-,?,!,192-255

" Markdown: use syntax highlighting in fenced code blocks? (doesn't work)
let g:vim_markdown_fenced_languages = ['bash=sh', 'js', 'json']



" PLUGIN CONFIGURATION =======================================================
" vim-asterisk
map *  <Plug>(asterisk-z*)
map #  <Plug>(asterisk-z#)
map g* <Plug>(asterisk-gz*)
map g# <Plug>(asterisk-gz#)
let g:asterisk#keeppos = 1

" ctrlp.vim
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_max_files = 0
let g:ctrlp_max_depth = 40
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore =
    \ '\v[\/](node_modules|target|dist)|(\.(swp|ico|git|svn))$'
" Ignore files in .gitignore
let g:ctrlp_user_command = ['.git',
    \ 'cd %s && git ls-files -co --exclude-standard']

" ctrlsf.vim
" Open CtrlSFPrompt with Ctrl + S
nmap <C-S> <Plug>CtrlSFPrompt
vmap <C-S> <Plug>CtrlSFVwordPath
let g:ctrlsf_default_root = 'project'
let g:ctrlsf_winsize = '90%'
let g:ctrlsf_ignore_dir = ["build"]

" ALE
let g:ale_open_list = 0
function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? '' : printf(
    \   '%dW %dE ',
    \   all_non_errors,
    \   all_errors
    \)
endfunction
let g:ale_linters = {
\    'go': [ 'go vet', 'golint', 'gometalinter', 'go build', 'gosimple', 'staticcheck'],
\}
let g:ale_fixers = {
\   'javascript': ['prettier'],
\}
let g:ale_fix_on_save = 1

" vim-go
let g:go_metalinter_autosave = 0
let g:go_fmt_fail_silently = 0

" vim-gitgutter
set updatetime=250

" vim-markdown-preview
let vim_markdown_preview_toggle = 2 " Generate markdown preview on buffer write
let vim_markdown_preview_github = 1
let vim_markdown_preview_hotkey='<leader>m'
"nnoremap <leader>m :call Vim_Markdown_Preview()<CR>



" STATUS LINE ==================================================
set laststatus=2
set statusline=%#WarningMsg#%{LinterStatus()}\%* " ALE status
set statusline+=\ %{FugitiveStatusline()}        " git branch
set statusline+=\ %f                             " filename
set statusline+=\ %h%m%r                         " flags: help, modified, RO
set statusline+=%=                               " begin right side
set statusline+=%-9(%l\:%c%)                     " ruler
