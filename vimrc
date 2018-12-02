" vim-plug package manager configuration
call plug#begin('~/.vim/plugged')

" Download vim-plug if not present
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" To navigate files
Plug 'scrooloose/nerdtree'
" To quickly open a file
Plug 'ctrlpvim/ctrlp.vim'
" Editor theme
Plug 'tomasr/molokai'
" Run tests using hotkeys
Plug 'janko-m/vim-test'
" Better ruby awareness
Plug 'vim-ruby/vim-ruby'
" Better way to open the files from a quickfix window
Plug 'yssl/QFEnter'
" Buffer explorer
Plug 'jlanzarotta/bufexplorer'
" Close buffer without losing the split
Plug 'moll/vim-bbye'
" Surround a piece of text 
Plug 'tpope/vim-surround'
" Autosave plugin
Plug 'vim-scripts/vim-auto-save'
" Git plugin to issue vim commands
Plug 'tpope/vim-fugitive'
" Goes with vim fugitive to open commits on github
Plug 'tpope/vim-rhubarb'
" Git plugin to show git changes
Plug 'airblade/vim-gitgutter'
" Save the vim session
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
" Ruby specific support plugins
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rbenv'
Plug 'tpope/vim-bundler'
" Use ctrlp to jump between tags
Plug 'ivalkeen/vim-ctrlp-tjump'
" Use ctrlp to jump between functions
Plug 'tacahiroy/ctrlp-funky'
" Use ctrlp with Ag to search
Plug 'lokikl/vim-ctrlp-ag'
" Open directory in nerd-tree using ctrlp
Plug 'voronkovich/ctrlp-nerdtree.vim'
" Navigate jumps with ctrlp
Plug 'DeaR/ctrlp-jumps'
" Use registers in ctrl-p
Plug 'mattn/ctrlp-register'
" Easily select parts of a line
" https://stackoverflow.com/questions/20165596/select-entire-line-in-vim-without-the-new-line-character
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'
" Easily create scratch windows
Plug 'mtth/scratch.vim'

" Initialize plugin system
call plug#end()

" Call on custom plugin options from an external file
if filereadable(expand("~/.vim/vimrc.functions"))
  source ~/.vim/vimrc.functions
endif

" Recognize the type of the file and set the 'filetype' option.
" Can be used to set the syntax highlighting, set options, etc.
filetype plugin indent on

" Enable syntaxt detection based on the file type
syntax on

" Line numbers enabled
set number

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

" Folds always open by default
" http://vim.wikia.com/wiki/All_folds_open_when_opening_a_file
set foldmethod=indent
set foldlevel=20

" Make backspace behave in a sane manner.
set backspace=indent,eol,start

" Enable mouse support
set mouse=a

" Autocompletion sources
" https://robots.thoughtbot.com/vim-you-complete-me
set complete=.,b,u,]

" Save automatically when text is changed with vim-auto-save
let g:auto_save = 1
let g:auto_save_in_insert_mode = 0

" vim-session configuration
let g:session_autosave = 'yes'
let g:session_autoload = 'yes'
let g:session_directory = ".vim-session" 

" https://stackoverflow.com/questions/307148/vim-scrolling-slowly
" https://eduncan911.com/software/fix-slow-scrolling-in-vim-and-neovim.html
set lazyredraw

" Enable clipboard on macosx
" http://www.markcampbell.me/2016/04/12/setting-up-yank-to-clipboard-on-a-mac-with-vim.html
set clipboard=unnamed

" Open new split panes to right and bottom, which feels more natural than Vim’s default:
set splitbelow
set splitright

" Standard “free” key where you can place custom mappings under https://nvie.com/posts/how-i-boosted-my-vim/
let mapleader = ","

" Avoid the escape key http://vim.wikia.com/wiki/Avoid_the_escape_key
" Does not seem to work in nvim
if !has('nvim')
  :imap jj <Esc>
endif

" Copy to system clipboard
" When mouse enabled (set mouse=a) hold the Alt key while
" highlighting the text https://stackoverflow.com/a/4608387
if !has('nvim')
  vmap <D-c> "+yi
  vmap <D-x> "+c
  vmap <D-v> c<ESC>"+p
  imap <D-v> <ESC>"+pa
endif

" https://github.com/neovim/neovim/issues/2127
" Reload buffer when changed on disk
if has('nvim')
  autocmd BufEnter,FocusGained * checktime
endif

" Close quickfix
nnoremap <leader>qn :ccl<CR>

" Close buffer without losing the split from vim-bbye plugin
nnoremap <Leader>qb :Bdelete<CR>

" Go back to terminal with leader space instead of Ctrl-Z
nnoremap <leader><Space> <C-Z>

" Delete current file https://stackoverflow.com/questions/4465095/vim-delete-buffer-without-losing-the-split-window
" Go to the previous buffer, then remove it from the disk (# is a
" reference to the buffer we just left), and then from the buffers list
nnoremap <leader>df :bp \| :call delete(expand('#')) \| :bd!#<CR>

" Remove highlight
nnoremap <leader>h :nohl<CR>

" Easier folding
nnoremap <leader>af zM
nnoremap <leader>ad zR
nnoremap <leader>aa za

" Quick git commands
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gr :GitGutterUndoHunk<CR>
nnoremap <leader>gh :GitGutterPreviewHunk<CR>

" Add a binding.pry
nnoremap <leader>s <S-O>binding.pry<Esc>

" Shifting blocks visually http://vim.wikia.com/wiki/Shifting_blocks_visually
" In normal mode can't happen because it conflicts with Ctrl-i
" nnoremap <Tab> >>_
" nnoremap <S-Tab> <<_
inoremap <S-Tab> <C-D>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Provides suggestions for next word
imap <C-Space> <C-P>

" Quickly open nerdtree https://stackoverflow.com/questions/6467634/create-a-command-shortcut-for-nerdtree-in-vim-editor
" Also with ctrlp-nerdtree plugin for search
nnoremap <leader>ne :NERDTree<cr>
nnoremap <leader>nf :CtrlPNerdTree<cr>
" Show hidden files
let NERDTreeShowHidden=1
let g:ctrlp_nerdtree_show_hidden = 1

" bufexplorer plugin <leader>be to choose a buffer to edit
let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1

" vim-test mappings
" these "Ctrl mappings" work well when Caps Lock is mapped to Ctrl http://vim.wikia.com/wiki/Map_caps_lock_to_escape_in_macOS
nmap <leader>tn :TestNearest<CR>
nmap <leader>tf :TestFile<CR>
nmap <leader>ts :TestSuite<CR>
nmap <leader>tl :TestLast<CR>
nmap <leader>tv :TestVisit<CR>
" With binstubs there is a change that you might endup using Spring.
let test#ruby#use_binstubs = 0
" vim-test uses Vim8 Terminal to run test commands with term_start() in a split window.
if has('nvim')
  let test#strategy = "neovim"
else
  let test#strategy = "vimterminal"
endif

" vim-ctrlp-ag configuration already does the following
" Use ag over grep
" set grepprg=ag\ --nogroup\ --nocolor\ --hidden
" Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
" let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
nnoremap <c-f> :CtrlPag<cr>
vnoremap <c-f> :CtrlPagVisual<cr>
nnoremap <leader>ca :CtrlPagLocate
nnoremap <leader>cp :CtrlPagPrevious<cr>
let g:ctrlp_ag_ignores = '--ignore .git
    \ --ignore "deps/*"
    \ --ignore "_build/*"
    \ --ignore "node_modules/*"
    \ --ignore "tags"'

" ag is fast enough that CtrlP doesn't need to cache
let g:ctrlp_use_caching = 0

" Search for tags using ctrlp (:help ctrlp-extensions)
" let g:ctrlp_extensions = ['tag']

" bind K to grep word under cursor
nnoremap K :silent! grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" bind \ (backward slash) to grep shortcut
" https://robots.thoughtbot.com/faster-grepping-in-vim
" https://vi.stackexchange.com/questions/14923/my-ag-shortcut-chokes-on-spaces
" https://vi.stackexchange.com/questions/17206/how-to-keep-ag-the-silver-searcher-open-when-no-matches-are-found
function! Ag(args) abort
  execute "silent! grep!" shellescape(a:args)
  copen
  redraw!
endfunction
command! -nargs=+ -complete=file Ag call Ag(<q-args>)
nnoremap \ :Ag<SPACE>

" Better % to jump between keywords https://thoughtbot.com/upcase/videos/navigating-within-ruby-files
runtime macros/matchit.vim

" Spaces also in normal mode
nnoremap <space> i<space><esc>

" Hotkey to reformat code
" https://stackoverflow.com/questions/24671367/vim-keybinding-to-jump-back-to-initial-position-after-indenting-the-whole-file
nnoremap <leader>fa gg=G

" Highlight word when double clicked
" Use :noh to then remove the highlight
nnoremap <silent> <2-LeftMouse> :let @/='\V\<'.escape(expand('<cword>'), '\').'\>'<cr>:set hls<cr>

" QFEnter plugin for better open a quickfix window
" Userful in conjuction with CtrlP such that it behaves in the same way
let g:qfenter_keymap = {}
let g:qfenter_keymap.vopen = ['<C-v>']
let g:qfenter_keymap.hopen = ['<C-CR>', '<C-s>', '<C-x>']
let g:qfenter_keymap.topen = ['<C-t>']

" Store temporary files in a central spot
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" Go to a previous location
nnoremap <leader>j :CtrlPJump<cr>
" Search withing the registers
nnoremap <leader>r :CtrlPRegister<cr>

" Specify tags file for VIM
set tags+=.tags

" Create ctags using Exuberant Ctags
" https://chodounsky.net/2016/12/09/using-tags-to-browse-ruby-and-gem-source-with-vim/
" https://github.com/universal-ctags/ctags/issues/446 as an alternative
" ctags -R --languages=ruby --exclude=.git --exclude=log -f .tags<cr>

" Ctags using the ruby-specific https://github.com/tmm1/ripper-tags
nnoremap <leader>ct :silent ! ripper-tags -R --exclude=vendor --exclude=log<cr>

" vim-ruby configuration
let ruby_fold = 1
let ruby_foldable_groups = 'def do'
let ruby_spellcheck_strings = 1

" vim-rails hotkey to jump from file to its test
nnoremap <leader>tj :AV<CR>

" Cool ctags navigation with vim-ctrlp-tjump
nnoremap <c-]> :CtrlPtjump<cr>
vnoremap <c-]> :CtrlPtjumpVisual<cr>
let g:ctrlp_tjump_only_silent = 1

" Jump between functions using ctrlp
nnoremap <Leader>fu :CtrlPFunky<Cr>

" Set a nicer foldtext function
set foldtext=MyFoldText()
highlight Folded guibg=black guifg=yellow

" Set prettier as a formatter for Javascript
" https://hackernoon.com/5-vim-plugins-i-cant-live-without-for-javascript-development-f7e98f98e8d5
autocmd FileType javascript set formatprg=prettier\ --stdin

" Please, no Spring in Rails. 
" Ideally that would be loaded from the bash, but for some reason it does not.
" https://vi.stackexchange.com/questions/16019/neovim-terminal-not-reading-bash-profile
let $DISABLE_SPRING=1

" TODO: Try to add syntaxt checking https://vimawesome.com/plugin/syntastic
" TODO: Autocomplete for end keyword https://github.com/tpope/vim-endwise
" TODO: Auto-add closing quotes/parenthesis/etc https://github.com/Raimondi/delimitMate
" TODO: Do I need gem-ctags and rbenv-ctags?
" https://chodounsky.net/2016/12/09/using-tags-to-browse-ruby-and-gem-source-with-vim/
" https://github.com/tpope/rbenv-ctags
" https://github.com/tpope/gem-ctags
" TODO: Try yank ring to remember old yanks
" https://github.com/vim-scripts/YankRing.vim
" TODO: Show indentation levels
" https://github.com/nathanaelkane/vim-indent-guides
" TODO: Working with HAML using vim-haml Tim Pope
" https://stackoverflow.com/questions/1639606/how-do-i-install-a-plugin-for-vim
