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
" Copy file path
Plug 'mottalrd/copypath.vim'
" Add comments
Plug 'tpope/vim-commentary'
" Visualise undo tree
Plug 'mbbill/undotree'
" Minimalist autocomplete (alternative to YouCompleteMe, coc.nvim)
Plug 'lifepillar/vim-mucomplete'

" Copy RTF for presentation
" Plug 'zerowidth/vim-copy-as-rtf'
" Didn't work but can use the following
" :TOhtml command and then
" textutil -convert rtf -stdout <html_file> | pbcopy

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

" Enable bottom right numbers
set ruler

" Folds always open by default
" http://vim.wikia.com/wiki/All_folds_open_when_opening_a_file
" In YAML files I need to set this explicitly
set foldmethod=indent
set foldlevel=20

" Make backspace behave in a sane manner.
set backspace=indent,eol,start

" Enable mouse support
set mouse=a

" Standard “free” key where you can place custom mappings under https://nvie.com/posts/how-i-boosted-my-vim/
let mapleader = ","

" Autocompletion sources
" https://robots.thoughtbot.com/vim-you-complete-me
set complete=.,b,u,]

" More intuitive movement on softwrap
" http://vimcasts.org/episodes/soft-wrapping-text/
vmap <C-j> gj
vmap <C-k> gk
nmap <C-j> gj
nmap <C-k> gk

" Use par for text formatting (use gqip to format your paragraph)
" http://vimcasts.org/episodes/formatting-text-with-par/
" Format the text you want to higlight with gq
set formatprg=par\ -q

" http://vim.wikia.com/wiki/Dictionary_completions
" Complete dictionary with Ctrl-N
set complete+=k
set dictionary+=/usr/share/dict/words

" Language aware completion
" https://vim.fandom.com/wiki/Omni_completion
set omnifunc=syntaxcomplete#Complete

function EnableWriting()
  set textwidth=72 " Default of par
  set formatoptions+=t
  highlight Normal guifg=#a3a3a3 guibg=Black
  set spell spelllang=en_us
endfunction

function DisableWriting() abort
  set textwidth=0
  set formatoptions=tcqj
  set nospell
endfunction

command DisableWriting :call DisableWriting()
command EnableWriting :call EnableWriting()

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

" http://vimcasts.org/episodes/spell-checking/
nmap <silent> <leader>p :set spell!<CR>

" Copy path to unnamed register
" https://github.com/vim-scripts/copypath.vim/blob/master/plugin/copypath.vim
let g:copypath_copy_to_unnamed_register = 1

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

" Easier way to exit terminal mode in nvim
" http://vimcasts.org/episodes/neovim-terminal-mappings/
if has('nvim')
  tnoremap <Esc> <C-\><C-n>
  tnoremap <C-v><Esc> <Esc>
endif

" Copy all file
nnoremap <C-a> <esc>ggVG<CR>

" Close quickfix
nnoremap <leader>qn :ccl<CR>

" Close buffer without losing the split from vim-bbye plugin
nnoremap <leader>qb :Bdelete<CR>

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

" Add a binding.pry or debugger for JS
autocmd FileType ruby nnoremap <leader>s <S-O>binding.pry<Esc>
autocmd FileType javascript nnoremap <leader>s <S-O>debugger<Esc>

" Shifting blocks visually http://vim.wikia.com/wiki/Shifting_blocks_visually
" In normal mode can't happen because it conflicts with Ctrl-i
" nnoremap <Tab> >>_
" nnoremap <S-Tab> <<_
" inoremap <S-Tab> <C-D>
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

" Undotree persistent configuration
" https://www.electricmonk.nl/log/2012/07/26/persistent-undo-history-in-vim/
set undodir=~/.vim/undodir
set undofile

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

" Create ctags using Exuberant Ctags
" https://chodounsky.net/2016/12/09/using-tags-to-browse-ruby-and-gem-source-with-vim/
" https://github.com/universal-ctags/ctags/issues/446 as an alternative
" ctags -R --languages=ruby --exclude=.git --exclude=log . $(bundle list --paths)<cr>

" Ctags using the ruby-specific https://github.com/tmm1/ripper-tags
" https://github.com/tmm1/ripper-tags/issues/91
" Local re-index
nnoremap <leader>ctl :silent ! ripper-tags -R --exclude=.git --exclude=log<cr>
" Global re-index
" nnoremap <leader>cta :silent ! ripper-tags -R --exclude=.git --exclude=log . $(bundle list --paths | sed 's/$/\/lib/')<cr>

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

" Autocomplete configuration
" https://github.com/lifepillar/vim-mucomplete
set completeopt+=menuone
set completeopt+=noselect
set shortmess+=c   " Shut off completion messages
let g:mucomplete#enable_auto_at_startup = 1
" https://github.com/lifepillar/vim-mucomplete/issues/149
" https://medium.com/usevim/set-complete-e76b9f196f0f
" :help 'complete' and :set complete to see what's available
set complete-=k
let g:mucomplete#chains = { 'default': ['c-p'] }

" TODO: Autocomplete for end keyword
" https://github.com/tpope/vim-endwise

" TODO: Auto-add closing quotes/parenthesis/etc
" https://github.com/Raimondi/delimitMate

" TODO: Automatically generate ctags for rbenv Ruby stdlibs
" https://chodounsky.net/2016/12/09/using-tags-to-browse-ruby-and-gem-source-with-vim/
" https://github.com/tpope/rbenv-ctags

" TODO: Automatic ctags generation on gem install
" https://chodounsky.net/2016/12/09/using-tags-to-browse-ruby-and-gem-source-with-vim/
" https://github.com/tpope/gem-ctags

" TODO: Plug 'ludovicchabant/vim-gutentags'
" Automatically generate tags
" let g:gutentags_define_advanced_commands = 1
" let g:gutentags_ctags_executable_ruby = 'ripper-tags -R --ignore-unsupported-options'
" For debugging gutentags
" Read the output with :messages
" let g:gutentags_trace = 1
" To see when we are indexing, but it seems to mess up the ruler
" set statusline+=%{gutentags#statusline()}

" MAYBE: Syntaxt checking
" https://vimawesome.com/plugin/syntastic
"
" MAYBE: Remember old yanks
" https://github.com/vim-scripts/YankRing.vim

" MAYBE: Show indentation levels
" https://github.com/nathanaelkane/vim-indent-guides

" MAYBE: Working with HAML using vim-haml Tim Pope
" https://stackoverflow.com/questions/1639606/how-do-i-install-a-plugin-for-vim

" MAYBE: Make tables aligned with
" https://github.com/godlygeek/tabular
" http://vimcasts.org/episodes/aligning-text-with-tabular-vim/

" MAYBE: https://github.com/jpalardy/vim-slime
" Easily copy and paste text from vim to another terminal

" MAYBE: https://github.com/SirVer/ultisnips
" Snippets solution
" https://www.oliversherouse.com/2017/08/21/vim_zero.html#snippets

