" We're using Vim for a reason, so turn off the Vi compatibility mode
set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Keep Plugin commands between vundle#begin/end
Plugin 'tpope/vim-fugitive'

" Command-T (http://www.vim.org/scripts/script.php?script_id=3025) "provides an extremely fast,
" intuitive mechanism for opening files with a minimal number of keystrokes.
"Plugin 'git://git.wincent.com/command-t.git'

" ctrlp Similar to Command-T, makes it easy to fuzzy-find files
Plugin 'kien/ctrlp.vim'
let g:ctrlp_custom_ignore = {
            \ 'dir': '\v[\/]\.(git|hg|svn)$',
            \ 'file': '\v\.(class|so|jar|war)$'
            \ }

" Recommendations from "Equipping Vim for JavaScript" (http://oli.me.uk/2013/06/29/equipping-vim-for-javascript/)
" Colorscheme
Plugin 'Lokaltog/vim-distinguished'
" Syntax highlighting
Plugin 'jelera/vim-javascript-syntax'
" "completely fix the weird indentation in standalone JavaScript files and code that’s embedded
" within HTML"
Plugin 'pangloss/vim-javascript'
" "lovely highlighting for your perfectly indented callback hell"
Plugin 'nathanaelkane/vim-indent-guides'
" Automatically add the closing quote, bracket, etc. Unfortunately, if you just press Enter after a
" brace, it doesn't put the closing brace on the next line. The guide has a trick for doing this,
" but it would be nice to do it automatically.
Plugin 'Raimondi/delimitMate'
" Linting integration, but requires external linting tool
Plugin 'scrooloose/syntastic'
set statusline+=%#warningmsg#
set statusline+=%{SyntaxStatusLineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1
let g:syntastic_javascript_checkers = ['jshint', 'jscs']

:au BufRead,BufNewFile *.json set filetype=json

" Autocompletion, but require extra install work
" "Dumb" completion
"Plugin 'Valloric/YouCompleteMe'
"" These are the tweaks I apply to YCM's config, you don't need them but they might help.
"" YCM gives you popups and splits by default that some people might not like, so these should tidy it up a bit for you.
"let g:ycm_add_preview_to_completeopt=0
"let g:ycm_confirm_extra_conf=0
"set completeopt-=preview
" Smarter JavaScript parsing for completion
"Plugin 'marijnh/tern_for_vim'

" vim-airline gives a nice statusbar, similar to powerline, but without external dependencies
" (although powerline will also integrate with bash, tmux, etc.)
Plugin 'bling/vim-airline'
" Needed in order to get the statusline when the window isn't split
set laststatus=2
" Accomodate /** */ comments where in-between lines start with a ' *' to line things up
let g:airline#extensions#whitespace#mixed_indent_algo = 1

" For scala syntax highlighting (installed for work on Apache Spark)
Plugin 'derekwyatt/vim-scala'

"All of your Plugins must be added before the following line
call vundle#end() " required
filetype plugin indent on " required

" Use ack because its awesome.
"set grepprg="ack -a"
"set grepprg="echo "
set grepprg=grep\ -Hn\ --binary-files=without-match

" Set shorter tabs
set tabstop=4
set shiftwidth=4
set expandtab

" Now ; works just like : but with 866% less keypresses!
nnoremap ; :

" Gnome Terminal doesn't properly advertise its color support
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

" Turn on the pretty colors and highlight search matches, but only if there are
" colors available
if &t_Co > 2 || has("gui_running")
	syntax on
	"highlight Normal guibg=Black guifg=White
    set background=dark
    colorscheme distinguished
	set hlsearch
endif

" Make sure that backspace will delete indents, newlines, and before where the
" Insert mode was started
set backspace=indent,eol,start

" Display the cursor position in the lower right corner of the Vim window
set ruler
" Display an incomplete command in the lower right corner of the Vim window
set showcmd
" Do not display the current mode; airline will handle that
set noshowmode
" Highlight the line that the cursor is on
set cursorline

" Display the match for a search pattern when halfway typing it
set incsearch
" Do case insensitive searching...
set ignorecase
" ...unless the search term has uppercase letters
set smartcase

" Remember the last 50 commands
set history=50

" This makes it so that vim doesn't beep; it flashes the display instead.
set visualbell

" When a ')' is typed, show the matching '('
set showmatch

" Make it easier to type boxed comments and #include's
iabbrev #b /********************************************************************************
iabbrev #e <Space>********************************************************************************/
iabbrev #i #include

" Make it easy to start a simple Qt application
"function SimpleQt()
"append
"#include <QApplication>
"#include <QWidget>
"
"int main(int argc, char** argv)
"{
"    QApplication app(argc, argv);
"    QWidget* win = new QWidget;
"
"    win->show();
"    return app.exec();
"}
".
"endfunction
"command Sqt call SimpleQt()

" This will highlight extra whitespace only when opening the buffer and
" leaving insert mode. It can be disabled with this command:
" :highlight clear ExtraWhitespace
highlight ExtraWhitespace ctermbg=red guibg=red
au ColorScheme * highlight ExtraWhitespace guibg=red
au BufEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhiteSpace /\s\+$/

" Make it so that using the <Up> and <Down> arrow keys move by one _screen_ line
" (not one file line)
map <Up> gk
map <Down> gj

" Make it so that gf will open the file under the cursor in a new window
map gf :sfind <cfile><CR>
" Make gf search the standard include places
"set path=/usr/include,/usr/include/c++/4.0.2,/usr/local/include,$PROJECT_SRC/**,$PROJECT_DIR/scripting/**,.
set path=.

" Ignore things
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.gif,*.psd,*.o,*.obj,*.min.js
set wildignore+=*/bower_components/*,*/node_modules/*
set wildignore+=*/vendor/*,*/.git/*,*/.hg/*,*/.svn/*,*/log/*,*/tmp/*

"set printoptions=paper:Letter,syntax:y,bottom:10pc

" Wrap lines at 80 characters, very convenient for comments, etc.
set textwidth=100

" Make it so that make errors, etc. will switch to the open buffer,
" if there is one available. If there isn't, the screen is split to
" display the offending file.
set switchbuf=split,useopen,usetab

"set guifont=Bitstream\ Vera\ Sans\ Mono\ 10
"set guifont=FreeMono/11/-1/5/50/0/0/0/1/0

" Use autoindenting by default.
set autoindent

" List the matching file names instead of just jumping to one when you press Tab
set wildmode=longest,list

" For C-like files, use the more specialized indenting algorithm.
autocmd FileType c,cpp,impl,java set cindent

" When a file is first opened, expand all of the folds.
set foldlevel=1000
" Turn on folding for XML files.
let g:xml_syntax_folding = 1
" For C, C++, and XML turn on syntax-based folding.
autocmd FileType c,cpp,impl,xml syn sync fromstart
autocmd FileType c,cpp,impl,xml set foldmethod=syntax foldcolumn=5

" Doxygen auto-generating comments stuff.
let g:DoxygenToolkit_authorName="Tom Panning"
" We don't use the @brief tag.
let g:DoxygenToolkit_briefTag_pre=""
" Set the syntax for pure doxygen files.
au BufNewFile,BufRead *.doxygen setfiletype doxygen

" Command to compare the contents of a recovered buffer (.swp file) with what is currently on the
" disk. Use this with the script
"     for file in $(find . -type f -name '.*.sw?'); do vim -r "$file" -c DiffOrig && rm -iv "$file"; done
" Taken from http://superuser.com/questions/904031/vim-automatically-delete-swp-file-after-recovery-doesnt-change-the-original-f
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis

