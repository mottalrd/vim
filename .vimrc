" vim-plug package manager configuration
call plug#begin('~/.vim/plugged')

" Download vim-plug if not present
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tomasr/molokai'
Plug 'janko-m/vim-test'

" Initialize plugin system
call plug#end()

" Recognize the type of the file and set the 'filetype' option. 
" Can be used to set the syntax highlighting, set options, etc.
filetype plugin indent on

" Enable syntaxt detection based on the file type
syntax on

set termguicolors
colorscheme molokai

" Tell vim how many columns a tab counts for
set tabstop=2   

" Indentation with 2 spaces when using << or >>
set shiftwidth=2
 
" Sets the number of columns for a TAB
set softtabstop=2

" Expand TABs to spaces
set expandtab

" Make backspace behave in a sane manner.
set backspace=indent,eol,start

" Faster pane jump https://robots.thoughtbot.com/vim-splits-move-faster-and-more-naturally
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Easier indentation http://vimcasts.org/episodes/indentation-commands/
" D stands for Command
nmap <D-[> <<
nmap <D-]> >>
vmap <D-[> <gv
vmap <D-]> >gv

" Open new split panes to right and bottom, which feels more natural than Vim’s default:
set splitbelow
set splitright

" Standard “free” key where you can place custom mappings under https://nvie.com/posts/how-i-boosted-my-vim/
let mapleader = ","

" Quickly open nerdtree https://stackoverflow.com/questions/6467634/create-a-command-shortcut-for-nerdtree-in-vim-editor
nmap <leader>ne :NERDTree<cr>

" vim-test mappings
" these "Ctrl mappings" work well when Caps Lock is mapped to Ctrl http://vim.wikia.com/wiki/Map_caps_lock_to_escape_in_macOS
nmap <silent> t<C-n> :TestNearest<CR> " t Ctrl+n
nmap <silent> t<C-f> :TestFile<CR>    " t Ctrl+f
nmap <silent> t<C-s> :TestSuite<CR>   " t Ctrl+s
nmap <silent> t<C-l> :TestLast<CR>    " t Ctrl+l
nmap <silent> t<C-g> :TestVisit<CR>   " t Ctrl+g

" vim-test uses Vim8 Terminal to run test commands with term_start() in a split window.
let test#strategy = "vimterminal"

" Avoid the escape key http://vim.wikia.com/wiki/Avoid_the_escape_key
" another alternative is
" :imap jj <Esc>
nnoremap <Tab> <Esc>
vnoremap <Tab> <Esc>gV
onoremap <Tab> <Esc>
cnoremap <Tab> <C-C><Esc>
inoremap <Tab> <Esc>`^
inoremap <Leader><Tab> <Tab>

