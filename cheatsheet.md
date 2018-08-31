# Move around
* w - move ahead by word
* b - move back by word
* gg - move to top of file
* :[n] - move to line n
* :$ - go to last line

# Insert character
* i/I - start insert mode at cursor or beginning of line.
* a/A - append after the cursor or at the end of the line.
* o/O - open (append) blank line below or above current line (no need to press return)
* ea - append at end of word
* r/R - replace one or multiple chars

# Windows movements
* ctrl-w <direction> - Go to the other tab
* :vs <filename> - Open new file in vertical
* ctrl-w r - Switch buffers (or :wincmd r)
* :tabedit <filename> - Open new tab

# Buffers
* :buffers - see all buffers
* :b# - open the previously editing buffer
* :vert sb <num> - open buffer in vertical split. # for current buffer
* :bd - delete the buffer

# Execute commands
* :! <your command string>
* ctrl-z - go back to bash
* fg <id> - go back to VIM (resume the background process started with ctrl-z)

# Code navigation/editing
* gg=G indent all the file
* <ctrl-p> + <ctrl-v> to open file in vertical split (ctrlp plugin)
* :ccl[ose] or :cope[n] to open/close the quick fix window
* % to jump between matching parentesis

# Navigating Ruby
* [m or ]m to jump between methods

# Configuration
* vim -V9myVim.log - start vim and saves a log of everything it does in this file when you close

# Cursor movement
*  w / W - jump by start of words (punctuation considered words)
* e / E - jump to end of words (punctuation considered words)
* b / B - jump backward by words (punctuation considered words)
* 0 - (zero) start of line
* ^ - first non-blank character of line
* $ - end of line
* G - Go To command (prefix with number - 5G goes to line 5)
Note: Prefix a cursor movement command with a number to repeat it. For example, 4j moves down 4 lines.

# Editing
* r - replace a single character (does not use insert mode)
* J - join line below to the current one
* cc - change (replace) an entire line
* cw - change (replace) to the end of word
* c$ - change (replace) to the end of line
* s - delete character at cursor and subsitute text
* S - delete line at cursor and substitute text (same as cc)
* xp - transpose two letters (delete and paste, technically)
* u - undo
* . - repeat last command

# Marking text (visual mode)
* v - start visual mode, mark lines, then do command (such as y-yank)
* V - start Linewise visual mode
* o - move to other end of marked area
* Ctrl+v - start visual block mode
* O - move to Other corner of block
* aw - mark a word
* ab - a () block (with braces)
* aB - a {} block (with brackets)
* ib - inner () block
* iB - inner {} block

# Visual commands
* > - shift right
* < - shift left
* y - yank (copy) marked text
* d - delete marked text
* ~ - switch case

# Cut and Paste
* yy - yank (copy) a line
* 2yy - yank 2 lines
* yw - yank word
* y$ - yank to end of line
* p - put (paste) the clipboard after cursor
* P - put (paste) before cursor
* dd - delete (cut) a line
* dw - delete (cut) the current word
* x - delete (cut) current character

# Search/Replace
* /pattern - search for pattern
* ?pattern - search backward for pattern
* n - repeat search in same direction
* N - repeat search in opposite direction
* : %s/old/new/g - replace all old with new throughout file
* : %s/old/new/gc - replace all old with new throughout file with confirmations
* : .s/old/new - replace in current line

# Working with multiple files
* :e filename - Edit a file in a new buffer
* :bnext (or :bn) - go to next buffer
* :bprev (of :bp) - go to previous buffer
* :bd - delete a buffer (close a file)
* :b# - open the previously editing buffer
* :sp filename - Open a file in a new buffer and split window
* ctrl+ws - Split windows
* ctrl+ww - switch between windows
* ctrl+wq - Quit a window
* ctrl+wv - Split windows vertically

