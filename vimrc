" vim-plug package manager configuration
call plug#begin('~/.vim/plugged')

" Download vim-plug if not present
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Vimplug https://github.com/junegunn/vim-plug
" To delete a plugin :PlugClean

" To navigate files
Plug 'scrooloose/nerdtree'
" To quickly open a file
Plug 'ctrlpvim/ctrlp.vim'
" Use ctrlp to jump between tags
Plug 'ivalkeen/vim-ctrlp-tjump'
" Use ctrlp with Ag to search
" Editor theme
" Plug 'overcache/NeoSolarized'
Plug 'morhetz/gruvbox'
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
" Makes vim-surround commands repeatable with dot
Plug 'tpope/vim-repeat'
" Vim plugin to issue git commands
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
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rbenv'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-dadbod'
" Easily select parts of a line
" https://stackoverflow.com/questions/20165596/select-entire-line-in-vim-without-the-new-line-character
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'
Plug 'nelstrom/vim-textobj-rubyblock'
" Easily create scratch windows
Plug 'mtth/scratch.vim'
" Copy file path
Plug 'mottalrd/copypath.vim'
" Add comments
Plug 'tpope/vim-commentary'
" Close quotes / parenthesis
Plug 'jiangmiao/auto-pairs'
" Visualise undo tree
Plug 'mbbill/undotree'
" Autocomplete
Plug 'ervandew/supertab'
" Highlight text objects when you select them using hotkeys
Plug 'machakann/vim-highlightedyank'
" Indexed search, shows the number of matches
Plug 'henrik/vim-indexed-search'
" Better yank register
" http://vimcasts.org/blog/2013/11/registers-the-good-the-bad-and-the-ugly-parts/
Plug 'maxbrunsfeld/vim-yankstack'
" Visual star search
Plug 'bronson/vim-visual-star-search'
" Grammar check
Plug 'dpelle/vim-LanguageTool'
" Tables
" http://vimcasts.org/episodes/aligning-text-with-tabular-vim/
Plug 'godlygeek/tabular'
" Run interactive shell with alias etc when invoking commands
" http://parobalth.github.io/vim-run-line
Plug 'christoomey/vim-run-interactive'
Plug 'sk1418/HowMuch'
Plug 'Yggdroot/indentLine'

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

" Disable Vi compatible mode https://github.com/nelstrom/vim-textobj-rubyblock
set nocompatible

" Enable syntaxt detection based on the file type
syntax on

" Line numbers enabled
set number

" set termguicolors
" set background=dark
colorscheme gruvbox

" Hightlight line with cursor
set cursorline
hi CursorLine term=bold cterm=bold guibg=#303030

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

" Don't use it https://www.cs.swarthmore.edu/oldhelp/vim/modelines.html
set nomodeline

" Folds always open by default
" http://vim.wikia.com/wiki/All_folds_open_when_opening_a_file
" In YAML files I need to set this explicitly
set foldmethod=indent
set foldlevel=20

set ignorecase

" Make backspace behave in a sane manner.
set backspace=indent,eol,start

" Enable mouse support
set mouse=a

" Let neovim use the bashprofile
let &shell='/bin/zsh --login'

" https://github.com/mhinz/neovim-remote
" This is a remote server tool for neovim
" this is to make things work when neovim is the default
" editor for git and you don't want to open neovim inside
" neovim when doing a commit via :terminal
if has('nvim')
  let $GIT_EDITOR = 'nvr -cc split --remote-wait'
endif
autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete

if !exists("*ReloadVimrc")
  function ReloadVimrc()
    source ~/.vim/vimrc
  endfunction
end

command! ReloadVimrc :call ReloadVimrc()

" https://learnvimscriptthehardway.stevelosh.com/chapters/23.html
" Open a terminal in a new tab
function Terminal()
  :tabnew
  :terminal
endfunction

function ExecuteLine()
  " Copy the line to next and run external command
  " which replaces the line with the output
  normal! yyp
  :. !sh

  " Alternatively open a clipboard
  " Otherwise need this https://vim.fandom.com/wiki/Capture_ex_command_output
  " :.w !sh -- to open a clipboard
endfunction
command! ExecuteLine :call ExecuteLine()

" Standard “free” key where you can place custom mappings under https://nvie.com/posts/how-i-boosted-my-vim/
let mapleader = ","
" Keep backward char search (opposite of ; to repeat last f{char})
noremap ;; ;
noremap ;b ,

" More intuitive movement on softwrap
" http://vimcasts.org/episodes/soft-wrapping-text/
vmap <C-j> gj
vmap <C-k> gk
nmap <C-j> gj
nmap <C-k> gk

" Autosave on buffer leave
" https://vi.stackexchange.com/questions/7617/how-to-auto-save-file-when-moving-between-split
autocmd BufLeave * silent! wall

" Use par for text formatting (use gqip to format your paragraph)
" http://vimcasts.org/episodes/formatting-text-with-par/
" Format the text you want to higlight with gq
set formatprg=par\ -q

" Language aware completion
" https://vim.fandom.com/wiki/Omni_completion
set omnifunc=syntaxcomplete#Complete

if !exists("*EnableWriting")
  function EnableWriting()
    set textwidth=72 " Default of par
    set formatoptions+=t
    highlight Normal guifg=#a3a3a3 guibg=Black
    set spell spelllang=en_us
    set statusline+=%=%{WordCount()}\ words
    set nonumber
  endfunction
end

if !exists("*DisableWriting")
  function DisableWriting() abort
    set textwidth=0
    set formatoptions=tcqj
    set nospell
    set statusline&
    set number
  endfunction
end

command! DisableWriting :call DisableWriting()
command! EnableWriting :call EnableWriting()

" Save automatically when text is changed with vim-auto-save
" let g:auto_save = 1
" let g:auto_save_in_insert_mode = 0

" vim-session configuration
let g:session_autosave = 'yes'
let g:session_autoload = 'yes'
let g:session_directory = ".vim-session"

" https://stackoverflow.com/questions/307148/vim-scrolling-slowly
" https://eduncan911.com/software/fix-slow-scrolling-in-vim-and-neovim.html
set lazyredraw

" Enable clipboard on macosx
" http://www.markcampbell.me/2016/04/12/setting-up-yank-to-clipboard-on-a-mac-with-vim.html
" http://vimcasts.org/episodes/accessing-the-system-clipboard-from-vim/
" also see :help clipboard on nvim
if has('unnamedplus')
  set clipboard+=unnamed,unnamedplus
endif

" Open new split panes to right and bottom, which feels more natural than Vim’s default:
set splitbelow
set splitright

" http://vimcasts.org/episodes/spell-checking/
" https://gist.github.com/brandonpittman/9d15134057c7267a88a8
" Toggle spellchecking
function! ToggleSpellCheck()
  set spell!
  if &spell
    " This is because the highlight setting
    " was getting overridden somehow by language settings
    syntax off
    echo "Spellcheck ON"
  else
    syntax on
    echo "Spellcheck OFF"
  endif
endfunction

nnoremap <silent> <leader>z :call ToggleSpellCheck()<CR>

" Wordcount without the need of adding a status bar to vim
" https://stackoverflow.com/questions/114431/fast-word-count-function-in-vim#new-answer?s=8dd5d8441d6d4ca99b7ed34b8915c68d
" https://github.com/vim-airline/vim-airline/issues/760
function! WordCount()
  let s:old_status = v:statusmsg
  let position = getpos(".")
  exe ":silent normal g\<c-g>"
  let stat = v:statusmsg
  let s:word_count = 0
  if stat != '--No lines in buffer--'
    if stat =~ "^Selected"
      let s:word_count = str2nr(split(v:statusmsg)[5])
    else
      let s:word_count = str2nr(split(v:statusmsg)[11])
    end
    let v:statusmsg = s:old_status
  end
  call setpos('.', position)
  return s:word_count
endfunction

function! MarkdownFoldExpr()
    " Fold based on Markdown headers (e.g., #, ##, ###)
    let line = getline(v:lnum)
    if line =~ '^#'
        return '>' . (strlen(matchstr(line, '^#*')))
    endif
    return '='
endfunction

autocmd FileType markdown setlocal foldmethod=expr
autocmd FileType markdown setlocal foldexpr=MarkdownFoldExpr()

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
nnoremap <C-g> <esc>ggVG<CR>

" Close quickfix
nnoremap <leader>qn :ccl<CR>

" Close buffer without losing the split from vim-bbye plugin
nnoremap <leader>qb :Bdelete<CR>

" Go back to terminal with leader space instead of Ctrl-Z
nnoremap <leader><Space> <C-Z>

" Autocomplete line
nnoremap <leader>r A<C-x><C-l><C-n>

" Quick save
" https://vim.fandom.com/wiki/Quick_save
noremap <Leader>s :update<CR>

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
" For YAML do
" :setlocal foldmethod=indent

" Yank registers https://github.com/maxbrunsfeld/vim-yankstack
call yankstack#setup()
nmap <leader>v <Plug>yankstack_substitute_older_paste
nmap <leader>c <Plug>yankstack_substitute_newer_paste
let g:yankstack_map_keys = 0

" Quick git commands
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gr :GitGutterUndoHunk<CR>
nnoremap <leader>gh :GitGutterPreviewHunk<CR>
let g:fugitive_summary_format = '%cD - %s'

" Add a binding.pry or debugger for JS
autocmd FileType ruby nnoremap <leader>tb <S-O>debugger<Esc>
autocmd FileType javascript nnoremap <leader>tb <S-O>debugger<Esc>

" Shifting blocks visually http://vim.wikia.com/wiki/Shifting_blocks_visually
" In normal mode can't happen because it conflicts with Ctrl-i
" nnoremap <Tab> >>_
" nnoremap <S-Tab> <<_
" inoremap <S-Tab> <C-D>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Center the screen when jumping back
" https://www.andrewferrier.com/degrade-gracefully-vim/#/6/1
nnoremap <C-o> <C-o>zz

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
nnoremap <leader>bo :b#<cr>

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

" Add custom tags here, jump with :tag <tagname> or :tselect <tagname>
set tags+=my_tags

" Ag silver search setup with vim
" https://robots.thoughtbot.com/faster-grepping-in-vim
" https://vi.stackexchange.com/questions/14923/my-ag-shortcut-chokes-on-spaces
" https://vi.stackexchange.com/questions/17206/how-to-keep-ag-the-silver-searcher-open-when-no-matches-are-found
set grepprg=ag\ --nogroup\ --nocolor
nnoremap K :silent! grep! "<C-R><C-W>"<CR>:cw<CR>
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>

" Write a log of what I am working on
function! WriteLog()
  let currentlyEditing = expand('%:t').':'.line(".")

  if len(currentlyEditing) > 0
    " personal_log available in bin/personal_log
    let cmd = 'silent !personal_log '.currentlyEditing
    execute cmd
  endif
endfunction

autocmd BufWritePost,BufEnter * call WriteLog()

function! CleanBuffers()
  let l:current_buffer = bufnr('%')
  let l:visible_buffers = [l:current_buffer]

  " Check for visible buffers in split windows and add them to the list
  " This accounts for more than one visible buffer in a split window setup
  for win in range(1, winnr('$'))
    let l:bufnr = winbufnr(win)
    if index(l:visible_buffers, l:bufnr) == -1
      call add(l:visible_buffers, l:bufnr)
    endif
  endfor

  " Iterate through all buffers
  for l:buffer_number in range(1, bufnr('$'))
    " Check if the buffer is a terminal and its name matches '_spec'
    let l:is_terminal_with_spec = getbufvar(l:buffer_number, '&buftype') == 'terminal' && match(bufname(l:buffer_number), '_spec') >= 0
    " Check if the buffer is not a terminal
    let l:is_not_terminal = getbufvar(l:buffer_number, '&buftype') != 'terminal'

    if buflisted(l:buffer_number) && (l:is_terminal_with_spec || l:is_not_terminal)
      " Check if the buffer is not in the list of visible buffers to keep
      if index(l:visible_buffers, l:buffer_number) == -1
        execute 'bdelete' l:buffer_number
      endif
    endif
  endfor
endfunction

" Better % to jump between keywords
" https://thoughtbot.com/upcase/videos/navigating-within-ruby-files
" https://github.com/tpope/vim-sensible/blob/master/plugin/sensible.vim
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

" https://github.com/tpope/vim-sensible/blob/master/plugin/sensible.vim
if &synmaxcol == 3000
  " Lowering this improves performance in files with long lines.
  set synmaxcol=500
endif

" Leave some space when scrolling down
" https://items.sjbach.com/319/configuring-vim-right
set scrolloff=3

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

" Create ctags using Exuberant Ctags
" https://chodounsky.net/2016/12/09/using-tags-to-browse-ruby-and-gem-source-with-vim/
" https://github.com/universal-ctags/ctags/issues/446 as an alternative
" ctags -R --languages=ruby --exclude=.git --exclude=log . $(bundle list --paths)<cr>

" Ctags using the ruby-specific https://github.com/tmm1/ripper-tags
" https://github.com/tmm1/ripper-tags/issues/91
" Local re-index
nnoremap <leader>ctl :Dispatch ripper-tags -R --exclude=.git --exclude=log<cr>
" Global re-index
nnoremap <leader>cta :Dispatch ripper-tags -R --exclude=.git --exclude=log . $(bundle list --paths \| sed 's/$/\/lib/')<cr>
" Shortlist gems
let libs_pipe_separated = join(split($WORK_GEMS, ","), "\\|")
execute "nnoremap <leader>cts :Dispatch ripper-tags -R --exclude=.git --exclude=log . $(bundle list --paths \\| sed 's/$/\\/lib/' \\| grep -E \"(".libs_pipe_separated.")\")<cr>"
" This gem
nnoremap <leader>ctt :Dispatch ripper-tags -R --exclude=.git --exclude=log %:p:h<cr>

" vim-ruby configuration
let ruby_fold = 1
let ruby_foldable_groups = 'def do'
let ruby_spellcheck_strings = 1

" ctrlp.vim ignore files in .gitignore
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
" ag is fast enough that CtrlP doesn't need to cache
let g:ctrlp_use_caching = 0

" Cool ctags navigation with vim-ctrlp-tjump
nnoremap <c-]> :CtrlPtjump<cr>
vnoremap <c-]> :CtrlPtjumpVisual<cr>
let g:ctrlp_tjump_only_silent = 1

" Set a nicer foldtext function
set foldtext=MyFoldText()
highlight Folded guibg=black guifg=yellow

" Set prettier as a formatter for Javascript
" https://hackernoon.com/5-vim-plugins-i-cant-live-without-for-javascript-development-f7e98f98e8d5
autocmd FileType javascript set formatprg=prettier\ --stdin

" Clean session on exit
autocmd VimLeave * exec "!rm -rf .vim-session"

" Please, no Spring in Rails.
" Ideally that would be loaded from the bash, but for some reason it does not.
" https://vi.stackexchange.com/questions/16019/neovim-terminal-not-reading-bash-profile
let $DISABLE_SPRING=1

" languagetool and vim-LanguageTool
let g:languagetool_jar = '/usr/local/Cellar/languagetool/5.0/libexec/languagetool-commandline.jar'

" MAYBE: hotkeys for smart substitutions and camelcase to sneakcase
" https://github.com/tpope/vim-abolish

" MAYBE: Automatically generate ctags for rbenv Ruby stdlibs
" https://chodounsky.net/2016/12/09/using-tags-to-browse-ruby-and-gem-source-with-vim/
" https://github.com/tpope/rbenv-ctags

" MAYBE: Automatic ctags generation on gem install
" https://chodounsky.net/2016/12/09/using-tags-to-browse-ruby-and-gem-source-with-vim/
" https://github.com/tpope/gem-ctags

" MAYBE: Syntaxt checking
" https://vimawesome.com/plugin/syntastic

" MAYBE: Show indentation levels
" https://github.com/nathanaelkane/vim-indent-guides

" MAYBE: Working with HAML using vim-haml Tim Pope
" https://stackoverflow.com/questions/1639606/how-do-i-install-a-plugin-for-vim

" MAYBE: https://github.com/jpalardy/vim-slime
" Easily copy and paste text from vim to another terminal

" MAYBE: https://github.com/SirVer/ultisnips
" Snippets solution
" https://www.oliversherouse.com/2017/08/21/vim_zero.html#snippets

" MAYBE: https://github.com/tpope/vim-sleuth
" Automatically sets shiftwidth and expandtab

" MAYBE: https://github.com/dense-analysis/ale
" Automatically run code linters

" MAYBE: https://github.com/junegunn/vim-peekaboo
" Show registers content in sidebar

" MAYBE: https://github.com/terryma/vim-expand-region
" Visually select increasingly larger regions of text 
