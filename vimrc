" MacVim configuration
"
"
" ---  GUI and term from shell
"
"     alias vi="/Applications/MacVim.app/Contents/bin/mvim -v"
"     alias mvim="/Applications/MacVim.app/Contents/bin/mvim --servername VIM --remote $1"
"
" ---- Default keybindings:
"     <leader>,w	Easy motion
"     <C-o>		Jump forward
"     <C-i>		Jump backward
"     <C-l>		Clear highlighting
"     <C-n>		Multiple-cursors. `I` for inserting
"
" ---- Remote files
"     scp://user@server//absolute/path/to/file
"
" ---- Fugitive
"     -                 Add file
"     C                 Commit add file/files
"     :Gcommit %        Commit current file
"
" ---- Macros
"     qa                Starting recording macro in `a`
"     q                 Stop recording
"     @a                Execute macro stored in `a`
"
" ---- Generic configuration

packadd! onedark.vim
packadd! auto-pairs
packadd! seoul256.vim
packadd! twilight256.vim
packadd! materialbox
packadd! vim-solarized8
packadd! vimoutliner
packadd! dracula-theme

set encoding=utf-8

set nu

let mapleader = ','

filetype on
filetype plugin on
syntax on

set colorcolumn=80
set noswapfile

tnoremap <Esc> <C-\><C-n>
set termguicolors

set splitbelow
set splitright

set cursorline

set hlsearch

" Use <C-l> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

" Highlighting extra whitespaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red

" Color schemes
set bg=dark
colorscheme onedark
"colorscheme materialbox
""colorscheme dracula

" Find merge conflict markers
map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR><Paste>

" Open a new tab
ca tn tabnew

" Emacs keybiding for insert mode
imap <C-e> <esc>$a
imap <C-a> <esc>0i
imap <C-f> <esc>lli
imap <C-b> <esc>i
imap <C-k> <esc>d$i

" Emacs keys for command line
cnoremap <C-A>	<Home>
cnoremap <C-B>	<Left>
cnoremap <C-D>	<Del>
cnoremap <C-E>	<End>
cnoremap <C-F>	<Right>

" search for visually hightlighted text
" %s//<your-replacement-string>
vnoremap <c-f> y<ESC>/<c-r>"<CR>

" Explorer
let g:netrw_winsize = 15
let g:netrw_browse_split = 2
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:NetrwIsOpen=0

function! ToggleNetrw()
    if g:NetrwIsOpen
        let i = bufnr("$")
        while (i >= 1)
            if (getbufvar(i, "&filetype") == "netrw")
                silent exe "bwipeout " . i
            endif
            let i-=1
        endwhile
        let g:NetrwIsOpen=0
    else
        let g:NetrwIsOpen=1
        silent Lexplore
    endif
endfunction
map <silent> <C-E> :call ToggleNetrw()<CR>

" Go files
autocmd BufNewFile,BufRead *.go setlocal tabstop=2 shiftwidth=2

" Jenkinsfile
autocmd BufNewFile,BufRead Jenkinsfile set ft=groovy

" Bash
" show existing tab with 2 spaces width:       set tabstop=2
" when indenting with '>', use 2 spaces width: set shiftwidth=2
" On pressing tab, insert 2 spaces:            set expandtab
autocmd BufNewFile,BufRead *.sh set tabstop=2 shiftwidth=2 expandtab

" Python
au BufNewFile,BufRead *.py set tabstop=4 softtabstop=4 shiftwidth=4 expandtab autoindent

" JS
au BufNewFile,BufRead *.js set tabstop=2 softtabstop=2 shiftwidth=2 expandtab autoindent

" Markdown
au BufRead,BufNewFile *.md setlocal textwidth=80

" Dockerfile
autocmd BufNewFile,BufRead *Dockerfile* set tabstop=4 shiftwidth=4 expandtab ft=Dockerfile

" Move current line up
nmap <C-S-Up> ddkP

" Move current line down
nmap <C-S-Down> ddp

" Format document
nmap <leader>f gg=G

" Remove trailing whitespaces with F5
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
nnoremap <silent> <F5> :call <SID>StripTrailingWhitespaces()<CR>

" Change local working dir upon tab creation
autocmd BufEnter * silent! lcd %:p:h
function! OnTabEnter(path)
  if isdirectory(a:path)
    let dirname = a:path
  else
    let dirname = fnamemodify(a:path, ":h")
  endif
  execute "tcd ". dirname
endfunction()

" Changing buffers without saving changes
set hidden

" Ignoring case when searching
set ignorecase

" Copying to clipboard using `y`:
set clipboard=unnamed

let macvim_hig_shift_movement = 1

" Enable folding
set foldmethod=indent
set foldlevel=99
nnoremap <space> za

" Customizing vertical split separator
hi VertSplit	guibg=#c2bfa5 guifg=grey50 gui=none

" ---- Plugins configuration
"
" airline
let g:airline_theme='light'
let g:airline_powerline_fonts = 1

" ale
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'

" nerdcommenter
map <C-\> <plug>NERDCommenterToggle
"
" Fugitive
nmap <leader>gs :Gstatus<cr>

" fzf
" enter:    current window
" ctrl-t:   new tab
" ctrl-x:   horizontal split
" ctrl-v:   vertical split
map <C-p> :FZF<CR>
map <leader>p :Buffers<CR>
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1
