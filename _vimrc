" vim plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin()
Plug 'junegunn/seoul256.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'
call plug#end()

" Unified color scheme (default: dark)
let g:seoul256_background = 235
colo seoul256

" Goyo
function! s:goyo_enter()
  let b:quitting = 0
  let b:quitting_bang = 0
  autocmd QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
  set scrolloff=999
  Limelight0.2
endfunction

function! s:goyo_leave()
  set scrolloff=5
  Limelight!
  " Quit Vim if this is the only remaining buffer
  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    if b:quitting_bang
      qa!
    else
      qa
    endif
  endif
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

syntax on
filetype plugin indent on

set ls=2
set ignorecase
set number
set scrolloff=5
set hlsearch
set incsearch
set expandtab
set tabstop=2
set shiftwidth=2
set autoindent
set ruler
set smartcase
set cursorline
set hidden
set backspace=2
set diffopt+=iwhite

nnoremap ; :
imap jj <Esc>

autocmd VimEnter * Goyo
