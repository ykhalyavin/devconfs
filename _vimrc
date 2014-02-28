" включаем несовместимость настроек с Vi (ибо Vi нам и не понадобится).
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" For normal vim colors in 'screen', recompiling screen is required

" mkdir -p $HOME/.tmp $HOME/bin
" wget http://ftp.gnu.org/gnu/screen/screen-4.0.3.tar.gz -O /tmp/screen-4.0.3.tar.gz
" tar xzf /tmp/screen-4.0.3.tar.gz -C /tmp
" cd /tmp/screen-4.0.3 && ./configure --enable-locale --enable-colors256 --enable-rxvt_osc --prefix=$HOME/.tmp/screen && make && make install && rm -rf /tmp/screen-4.0.3
" ln -sf $HOME/.tmp/screen/bin/screen $HOME/bin
" reload

" let Vundle manage Vundle
" required!
Bundle 'git://github.com/gmarik/vundle.git'

Bundle 'git://github.com/tomasr/molokai.git'
Bundle 'git://github.com/altercation/vim-colors-solarized.git'

Bundle 'git://github.com/mileszs/ack.vim'
Bundle 'git://github.com/itchyny/lightline.vim'
Bundle 'git://github.com/tomtom/tcomment_vim'
Bundle 'git://github.com/mhinz/vim-signify'
Bundle 'git://github.com/edsono/vim-matchit'
Bundle 'git://github.com/ervandew/supertab'

Bundle 'git://github.com/tpope/vim-fugitive'
Bundle 'git://github.com/gregsexton/gitv'

Bundle 'git://github.com/kien/ctrlp.vim'
Bundle 'git://github.com/majutsushi/tagbar'

Bundle 'git://github.com/scrooloose/nerdtree'

Bundle 'git://github.com/sjl/gundo.vim'
Bundle 'git://github.com/vim-scripts/Jinja'
Bundle 'git://github.com/vim-scripts/bufkill.vim'
Bundle 'git://github.com/vim-scripts/mako.vim'
Bundle 'git://github.com/vim-scripts/taglist.vim'
Bundle 'git://github.com/vim-scripts/vcscommand.vim'
Bundle 'git://github.com/tpope/vim-surround.git'


filetype plugin indent on

retab
syntax on

set fencs=utf8,koi8-r,cp1251 " порядок перебора кодировок при открытии файла
set nobackup    " не создавать бэкап
set hidden      " переключаем измененные буферы без предварительного сохранения
set wildmenu    " используем допол
set noswapfile  " не используем swap файлы, чтобы н езасорять память
set ignorecase  " игнорируем регистр
set smartcase   " при ignorecase позволяет искать с буквами верхнего регистра
set ttyfast     " перерисовываем терминальное окно быстрее
set autochdir   " изменять текущую директорию на директорию открываемого файла

set undolevels  =100
set wildmode    =longest,list,full
set wildignore  =*.o,*.obj,*.bak,*.exe,*.swp,*.a,*.svn,*.git,*.pyc
set backspace   =indent,eol,start whichwrap+=<,>,[,] " use backspace instead of "x"
set laststatus  =2        " всегда отображать линию статуса
set history     =500      " сохраняем 500 линий поисковой истории
set browsedir   =buffer
set display     =lastline " не отображать в последней строке '@@@@@'
"set shell       =/bin/bash
set wcm         =<Tab>
set pastetoggle =<F3>     " Переключение режима paste по F3
set t_Co=256
set linespace   =1

if v:version >= 703
    set colorcolumn =79 " отображать вертикальную линию после 79 столбца
    set undofile        " включим опцию persistent undo

    " сделаем так, чтобы файлы undo появлялись указанной директории,
    if has('win32') || has('win64')
        let s:undodir=$VIM.'/undofiles'
    else
        let s:undodir=$HOME.'/.vim/undofiles'
    endif
    let &undodir=s:undodir

    " если каталог не существует, создадим его рекурсивно
    if !isdirectory(s:undodir)
        call mkdir(s:undodir, 'p', 0700)
    endif
endif

set novisualbell  " отключаем пищание
set hlsearch      " подсвечивать найденную фразу

set list          " отображать табы (работает вместе с listchars)
set listchars=tab:\|\ \,trail:> " отображать табы и пробелы

set showmatch     " проверка скобок
set matchpairs+=<:>
set matchtime=2   " подсвечиваем парные скобки 2 секунды

set shortmess+=I  " не показывать заставку про помощь уганде при старте vim
set scrolloff =3  " начинать прокрутку текста, когда до края остается 3 линии
set sidescroll=5  " The minimal number of columns to scroll horizontally.
                  " Used only when the 'wrap' option is off.

"set statusline=%<[%n]\ %f\ %m%r%h%w\ %y\ %{&fileencoding}%=%b\ \ \ %c/%v\ %l/%L\ \ %P\ %a
"set statusline=%<[%n]\ %f\ %([%{Tlist_Get_Tagname_By_Line()}]%)\ %m%r%h%w\ %y\ %{&fileencoding}%=%b\ \ \ %c/%v\ %l/%L\ \ %P\ %a


set expandtab       " преобразование Таба в пробелы
set autoindent      " включить автоотступы
set copyindent      " при авто-отступах копировать текущую структуру отступов
set softtabstop =4  " сколько провелов в табе (при нажатии Tab или Backspace)
set tabstop     =4  " ширина таба 4 пробела
set shiftwidth  =4  " кол-во пробелов при отступах в 'cindent', >>, <<, и т.д.
set textwidth   =78 " ширина текстовой строки

set complete   -=i  " не искать по подключенным заголовкам

if has("gui_running")
    set guioptions =afgitef
    "set guifont    =Andale\ Mono\ Italic\ 11
    "set guifont    =Andale\ Mono\ for\ Powerline\ 11
    set guifont    =Mensch\ for\ Powerline\ 11

    set background =dark
    "colorscheme festoon
else
    "colorscheme desert
endif

set bg=dark
colorscheme solarized

" удаление лишних пробелов перед сохранением файла
au BufWritePre,FileWritePre * let au_line=line(".")
au BufWritePre,FileWritePre * let au_col=col(".")
au BufWritePre,FileWritePre * %s/\s\+$//e
au BufWritePost * silent call cursor(au_line, au_col)

au FileType html,mail set formatoptions=tq textwidth=78

au BufEnter *.htaccess set nowrap

"autocmd VimLeave * echo "Cya in Hell."

au BufNewFile  *.pl    0r /home/delphi/.vim/templates/perl
au BufNewFile  *.tex   0r /home/delphi/.vim/templates/tex
au BufNewFile  *.py    0r /home/delphi/.vim/templates/python
au BufNewFile  *.c     0r /home/delphi/.vim/templates/c

au BufRead,BufNewFile  *.c,*.h set formatoptions=ql cindent

" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif

au FileType python set omnifunc=pythoncomplete#Complete
au FileType javascript set omnifunc=javascriptcomplete#CompleteJS
au FileType html set omnifunc=htmlcomplete#CompleteTags
au FileType css set omnifunc=csscomplete#CompleteCSS
au FileType c set omnifunc=ccomplete#Complete

" при открытии файла перемещать курсор на последнюю запомненную позицию
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") |
            \ exe "normal g'\"" | endif

" переключение между .c и .h
" http://vim.wikia.com/wiki/Easily_switch_between_source_and_header_file
au BufEnter *.[ch] nmap ,s :find %:t:r.c<cr>
au BufEnter *.[ch] nmap ,h :find %:t:r.h<cr>

let python_highlight_all=1

nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

menu Encoding.koi8-r       :e ++enc=koi8-r<CR>
menu Encoding.windows-1251 :e ++enc=cp1251<CR>
menu Encoding.ibm-866      :e ++enc=ibm866<CR>
menu Encoding.utf-8        :e ++enc=utf-8 <CR>
map <Leader>e :emenu Encoding.<TAB>

" Выключаем ненавистный режим замены
imap <Ins> <Esc>a
" Проверка орфографии
"nmap <silent> ,sp :set spl=ru,en spell!<CR>

" нормальный PageUp/Down
nmap <PageUp> <C-U><C-U>
imap <PageUp> <C-O><C-U><C-O><C-U>
nmap <PageDown> <C-D><C-D>
imap <PageDown> <C-O><C-D><C-O><C-D>

" переход между окнами по Ctrl-hjkl
nmap <C-h> <C-W>h
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-l> <C-W>l

" форматирование по ближайшей скобке
imap <C-L> <C-O>=%

" 'умный' Home/End
noremap <expr> <Home> (col('.') == matchend(getline('.'), '^\s*')+1 ? '0' : '^')
noremap <expr> <End> (col('.') == match(getline('.'), '\s*$') ? '$' : 'g_')
vnoremap <expr> <End> (col('.') == match(getline('.'), '\s*$') ? '$h' : 'g_')
imap <Home> <C-o><Home><C-o>i
imap <End> <C-o><End><C-o>a<C-o>a

" сохранение текущего буфера
imap <unique> <C-S> <Esc>:w<CR>a
nmap <unique> <C-S>      :w<CR>

" закрываем текущий буфер, не закрывая окна
imap <F4> <Esc>:BD<CR>a
nmap <F4>      :BD<CR>

nnoremap <leader>p :NERDTreeToggle<cr>
let NERDTreeShowBookmarks = 1 " NERDTree показывает закладки
"let NERDTreeDirArrows = 0 " отображать '+~' вместо utf-8 стрелочек
let NERDTreeDirArrows = 1 " отображать utf-8 стрелочки вместо '+~'
let NERDTreeMinimalUI = 1 " убрать все лишнее (подсказка помощи, надписи и т.д.)
let NERDTreeIgnore=['\.vim$', '\~$', '\.pyc']

let g:qb_hotkey = "<F10>"    " запускаем quickbuf по 'F10'

nnoremap <silent> <F8> :TagbarToggle<CR>
let g:TagmaBufMgrMapCArrow = 0

function! MakeTags(dir, tagfile)
    let cmd = 'ctags -R --tag-relative=yes -f ' . a:tagfile . ' ' . a:dir
    echo 'run ' . cmd
    let x = system(cmd)
endfunction

if empty($TMP)
    let $TMP = $HOME."/.tmp"
endif

let g:pymode_options = 0
let g:pymode_lint_write = 0 "не проверять при каждом сохранении
let g:pymode_folding = 0 "мне не нужен авто-фолдинг
let g:pymode_rope_vim_completion = 0 "не использовать автодополнение rope

let g:tagbar_autofocus = 1
let g:tagbar_sort = 0 "tagbar shows tags in order of they created in file
let g:tagbar_foldlevel = 0 "close tagbar folds by default

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }
let g:signify_disable_by_default = 1

nmap <silent> <C-B> :CtrlPBuffer<CR>
imap <silent> <C-B> <Esc>:CtrlPBuffer<CR>

inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>

""""""""""""""
" tmux fixes "
""""""""""""""
" Handle tmux $TERM quirks in vim
if $TERM =~ '^screen-256color'
    map <Esc>OH <Home>
    map! <Esc>OH <Home>
    map <Esc>OF <End>
    map! <Esc>OF <End>
endif

autocmd FileType python let b:easytags_auto_highlight = 0
let g:easytags_autorecurse = 1

source $HOME/.vim/settings/binary.vim
source $HOME/.vim/settings/latex.vim
source $HOME/.vim/settings/perl.vim
source $HOME/.vim/settings/python.vim
source $HOME/.vim/settings/mako.vim
