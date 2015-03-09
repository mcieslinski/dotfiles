""""""""
" SETS "
""""""""
set smarttab
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smartindent
set cinoptions+=g0,:0
set incsearch
syntax on
"filetype indent on
"set laststatus=2

""""""""""""""""""
" KEY REMAPS LOL "
""""""""""""""""""
let mapleader = "-"
" Vim management remaps
" Tab-left
nnoremap                <F7>        <esc>:tabp<cr>
inoremap                <F7>        <esc>:tabp<cr>
" Tab-right
nnoremap                <F8>        <esc>:tabn<cr>
inoremap                <F8>        <esc>:tabn<cr>
" Split-left
nnoremap                <F9>        <c-w>h
inoremap                <F9>        <esc><c-w>h
" Split-right
nnoremap                <F10>       <c-w>l
inoremap                <F10>       <esc><c-w>l
" Resize current window horizontal++
nnoremap    <silent>    <c-F10>     <c-w>>
" Resize current window horizontal--
nnoremap    <silent>    <c-F9>      <c-w><
" Resize current window to be half the size of the total window
nnoremap    <silent>    <c-F11>     <c-w>=
" Edit .vimrc
nnoremap    <silent>    <leader>ev  :vsplit $MYVIMRC<cr>
" Source .vimrc
nnoremap    <silent>    <leader>sv  :so $MYVIMRC<cr>

" Editing remaps
" Uppercase current word
inoremap    <silent>    <c-u>       <esc>viwUi
" Surround selected section in quotes
vnoremap    <silent>    <leader>"   <esc>`>a"<esc>`<i"<esc>`>ll
" Header guard-ify selection
vnoremap    <silent>    <leader>h   U<esc>`<i<esc>f.r_`<i#ifndef <esc>yyp:.s/ifndef/define<cr>

"""""""""""""""""
" ABBREVIATIONS "
"""""""""""""""""
" VICTORY signature
iabbrev     vsig    /*!<cr> *  \file <c-r>%<cr>*  \author Michael R. Cieslinski, Jr. <mcieslinski@dcscorp.com><cr>*  \date  <c-r>=strftime("%b %d %Y")<cr><cr>*  \brief <cr>*<cr>*/ 

""""""""""""""""
" AUTOCOMMANDS "
""""""""""""""""
augroup my_autocommands
    autocmd     BufNewFile,BufRead      *.xml,*.wsdl,*.xsd      setlocal nowrap
augroup END

"""""""""""
"FUNCTIONS"
"""""""""""
function! Ecpp(fname)
    if filereadable(a:fname)
        echo a:fname . " exists."
    else
        echo a:fname . " does not exist."
    endif
endfunction
