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
Plug 'vim-ruby/vim-ruby'

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

" Enable mouse support
set mouse=a

" Enable clipboard on macosx 
" http://www.markcampbell.me/2016/04/12/setting-up-yank-to-clipboard-on-a-mac-with-vim.html
set clipboard=unnamed

" Open new split panes to right and bottom, which feels more natural than Vim’s default:
set splitbelow
set splitright

" Standard “free” key where you can place custom mappings under https://nvie.com/posts/how-i-boosted-my-vim/
let mapleader = ","

" Avoid the escape key http://vim.wikia.com/wiki/Avoid_the_escape_key
:imap jj <Esc>

" Copy to system clipboard
" When mouse enabled (set mouse=a) hold the Alt key while
" highlighting the text https://stackoverflow.com/a/4608387
vmap <D-c> "+yi
vmap <D-x> "+c
vmap <D-v> c<ESC>"+p
imap <D-v> <ESC>"+pa

" Faster pane jump https://robots.thoughtbot.com/vim-splits-move-faster-and-more-naturally
" But more importantly remember <C-W> W goes to the opposite window
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Quit buffer with
nnoremap <leader>q :bd<CR>

" Go back to terminal with leader space instead of Ctrl-Z
nnoremap <leader><Space> <C-Z>

" Shifting blocks visually http://vim.wikia.com/wiki/Shifting_blocks_visually
nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
inoremap <S-Tab> <C-D>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Quickly open nerdtree https://stackoverflow.com/questions/6467634/create-a-command-shortcut-for-nerdtree-in-vim-editor
nmap <leader>ne :NERDTree<cr>
" Show hidden files
let NERDTreeShowHidden=1

" vim-test mappings
" these "Ctrl mappings" work well when Caps Lock is mapped to Ctrl http://vim.wikia.com/wiki/Map_caps_lock_to_escape_in_macOS
nmap <leader>tn :TestNearest<CR> 
nmap <leader>tf :TestFile<CR>    
nmap <leader>ts :TestSuite<CR>   
nmap <leader>tl :TestLast<CR>    
nmap <leader>tv :TestVisit<CR>   

" vim-test uses Vim8 Terminal to run test commands with term_start() in a split window.
let test#strategy = "vimterminal"

" Use ag over grep
set grepprg=ag\ --nogroup\ --nocolor

" Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

" ag is fast enough that CtrlP doesn't need to cache
let g:ctrlp_use_caching = 0

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" bind \ (backward slash) to grep shortcut
command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>

" Better % to jump between keywords https://thoughtbot.com/upcase/videos/navigating-within-ruby-files
runtime macros/matchit.vim

" Spaces also in normal mode
nnoremap <space> i<space><esc>

" Hotkey to reformat code
nmap <leader>ff =i{
nmap <leader>fa gg=G

" Highlight word when double clicked
" Use :noh to then remove the highlight
nnoremap <silent> <2-LeftMouse> :let @/='\V\<'.escape(expand('<cword>'), '\').'\>'<cr>:set hls<cr>

" TODO: ctags
" https://chodounsky.net/2016/12/09/using-tags-to-browse-ruby-and-gem-source-with-vim/

" TODO: fold / unfold code

" TODO: try sessions https://github.com/xolox/vim-session

" TODO: Ag to open in a vertical panel

" TODO: git plugin for blame / history

" TODO: autosave https://github.com/vim-scripts/vim-auto-save

" TODO: Ag do not close if you can't find anything

" TODO: Surround item with stuff plugin (example surround word with '')

" TODO: Autocomplete words
