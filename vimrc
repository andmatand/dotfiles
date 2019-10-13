" Don't use autochdir (which breaks vim-fugitive), but use similar behavior
set noautochdir
let g:netrw_keepdir=0
autocmd BufEnter * silent! lcd %:p:h

" Set search options
set ignorecase smartcase gdefault hlsearch

" Set display options
set showcmd " Show selection length in ruler
set colorcolumn=80
set completeopt-=preview
set list

" Set default indenting options
set expandtab shiftwidth=4

" Set default formatoptions
set formatoptions=croqlj

" Disable annoying audio bell in favor of visual bell
set visualbell

" Set colorscheme
colorscheme gruvbox
set background=dark
"set termguicolors

" Set split options
set splitbelow splitright

" Save temp files in a global directory
set directory=~/.vim/tmp
set backupdir=~/.vim/tmp

" Keep undo history across sessions by storing it in a file
if has('persistent_undo')
    set undofile
    set undodir=$HOME/.vim/undo
endif

" Source .vimrc after saving it
if has('autocmd')
    autocmd! bufwritepost vimrc source $MYVIMRC
endif



" KEY MAPPINGS ===============================================================
" Use <Tab> (and alternately backslash) as leader
let mapleader = "\<Tab>"
nmap \ <Tab>

" Clear hlsearch with backspace
nnoremap <backspace> :noh<CR>:<backspace>

" Map <Space> to insert a space before the current character
nnoremap <Space> i <Esc>

" Refresh several things with F5
" (ctrp.vim, vim-gitgutter, syntax highlighting weirdness)
nnoremap <F5> :CtrlPClearCache<CR>:GitGutter<CR>:syntax sync fromstart<CR>
    \:<backspace>

" Pretty-print JSON with <leader>j. Works on a selection or a whole buffer.
nnoremap <leader>j :%!python -m json.tool<CR>:set ft=json<CR>
vnoremap <leader>j :!python -m json.tool<CR>

" Pretty-print XML with <leader>x. Works on a selection or a whole buffer.
nnoremap <leader>x :%!XMLLINT_INDENT="    " xmllint --format -<CR>:set ft=xml<CR>
vnoremap <leader>x :!XMLLINT_INDENT="    " xmllint --format -<CR>

" Insert current date with <leader>d
nnoremap <leader>d :put =strftime('%F')<CR>

" Use CtrlP to see recent files with <leader>f and buffers with <leader>b
nnoremap <leader>f :CtrlPMRUFiles<CR>
nnoremap <leader>b :CtrlPBuffer<CR>

" See Git status with <leader>g
nnoremap <leader>g :Gstatus<CR>

" FILETYPE-SPECIFIC STUFF ====================================================
" CSS: Make Ctrl + n/p autocomplete more useful
autocmd FileType css,scss setlocal iskeyword=@,48-57,_,-,?,!,192-255

" Markdown: use syntax highlighting in fenced code blocks
let g:markdown_fenced_languages = [
\    'bash=sh',
\    'html',
\    'javascript',
\    'js=javascript',
\    'json',
\    'sh',
\    'xml',
\]



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
let g:ctrlp_root_markers = ['node_modules', '.npmrc', '.nvmrc']

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
let g:ctrlsf_extra_root_markers = ['node_modules', '.npmrc', '.nvmrc']
let g:ctrlsf_winsize = '90%'
let g:ctrlsf_ignore_dir = ['build']

" ALE
let g:ale_open_list = 0
function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? '' : printf(
    \   '%dW %dE',
    \   all_non_errors,
    \   all_errors
    \)
endfunction
let g:ale_linters = {
\    'go': ['go vet', 'golint', 'go build', 'gosimple', 'staticcheck'],
\}
let g:ale_fixers = {
\   'javascript': ['prettier'],
\}
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1

" vim-go
set autowrite
let g:go_metalinter_autosave = 0
let g:go_fmt_fail_silently = 0
let g:go_highlight_types = 1
let g:go_def_mapping_enabled = 0
let g:go_def_reuse_buffer = 1
autocmd FileType go nmap <leader>b <Plug>(go-build)
autocmd FileType go nmap <leader>r <Plug>(go-run)
autocmd FileType go nmap gd <Plug>(go-def-split)
autocmd FileType go set nolist

" vim-gitgutter
set updatetime=250
autocmd BufWritePost,BufEnter * GitGutter

" vim-markdown-preview
let vim_markdown_preview_toggle = 2 " Generate markdown preview on buffer write
let vim_markdown_preview_github = 1
let vim_markdown_preview_hotkey='<leader>m'
"nnoremap <leader>m :call Vim_Markdown_Preview()<CR>



" STATUS LINE ================================================================
function! SelectionChars() abort
    let l:key = 'visual_chars'
    let l:wc = wordcount()
    if has_key(l:wc, l:key)
        let l:lines = abs(line('v') - line('.')) + 1
        let l:chars = l:wc[l:key]
        if l:chars > 1 && (mode() ==# 'V' || l:lines > 1)
            return printf('%d chars', l:chars)
        endif
    endif
    return ''
endfunction
function! DiffFlag()
    return &diff ? '[diff]' : ''
endfunction
set stl=%#WarningMsg#%(\ %{LinterStatus()}\ %)%* " ALE status
set stl+=%(\ %<➤%{fugitive#head()}\ %)    " git branch
set stl+=\ %f                             " filename
set stl+=%(\ %y%m%r%w%{DiffFlag()}%)      " flags: help, mod, RO, preview, etc.
set stl+=%=                               " begin right side
set stl+=%(\ %{SelectionChars()}\ %)      " Chararacter-count in selection
set stl+=\ %-9(%l\:%c%)\ %P\              " ruler

set titlestring=%F\ %{ObsessionStatus('[session]','')}

" VIMRC OVERRIDES ============================================================
" Load computer-specific overrides file if present
runtime vimrc.override
