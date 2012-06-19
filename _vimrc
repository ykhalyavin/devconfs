" включаем несовместимость настроек с Vi (ибо Vi нам и не понадобится).
set nocompatible
filetype off

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

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
set wildignore  =*.o,*.obj,*.bak,*.exe,*.swp,*.a,*.svn,*.git
set backspace   =indent,eol,start whichwrap+=<,>,[,] " use backspace instead of "x"
set laststatus  =2        " всегда отображать линию статуса
set history     =500      " сохраняем 500 линий поисковой истории
set browsedir   =buffer
set display     =lastline " не отображать в последней строке '@@@@@'
set shell       =/bin/bash
set wcm         =<Tab>
set pastetoggle =<F3>     " Переключение режима paste по F3

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
set incsearch     " инкрементальный поиск
set nohlsearch    " не подсвечивать найденную фразу

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
set statusline=%<[%n]\ %f\ %([%{Tlist_Get_Tagname_By_Line()}]%)\ %m%r%h%w\ %y\ %{&fileencoding}%=%b\ \ \ %c/%v\ %l/%L\ \ %P\ %a


set expandtab       " преобразование Таба в пробелы
set autoindent      " включить автоотступы
set copyindent      " при авто-отступах копировать текущую структуру отступов
set softtabstop =4  " сколько провелов в табе (при нажатии Tab или Backspace)
set tabstop     =4  " ширина таба 4 пробела
set shiftwidth  =4  " кол-во пробелов при отступах в 'cindent', >>, <<, и т.д.
set textwidth   =78 " ширина текстовой строки

if has("gui_running")
    set guioptions =afgitef
    "set guifont    =Andale\ Mono\ Italic\ 11
    set guifont    =Andale\ Mono\ for\ Powerline\ 11

    set background =dark
    colorscheme festoon
else
    colorscheme desert
endif

" удаление лишних пробелов перед сохранением файла
au BufWritePre,FileWritePre * let au_line=line(".")
au BufWritePre,FileWritePre * let au_col=col(".")
au BufWritePre,FileWritePre * %s/\s\+$//e
au BufWritePost * silent call cursor(au_line, au_col)

au FileType html,mail set formatoptions=tq textwidth=78
au Filetype html,eruby,tt2html,jinja,htmldjango set softtabstop=2 sw=2

au FileType javascript set softtabstop=2 sw=2 nowrap

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

" переход между окнами по Ctrl-стрелочка
nnoremap <silent> <C-Up>             :wincmd k<CR>
nnoremap <silent> <C-Down>           :wincmd j<CR>
nnoremap <silent> <C-Left>           :wincmd h<CR>
nnoremap <silent> <C-Right>          :wincmd l<CR>

inoremap <silent> <C-Up>        <Esc>:wincmd k<CR>a
inoremap <silent> <C-Down>      <Esc>:wincmd j<CR>a
inoremap <silent> <C-Left>      <Esc>:wincmd h<CR>a
inoremap <silent> <C-Right>     <Esc>:wincmd l<CR>a

" форматирование по ближайшей скобке
imap <C-L> <C-O>=%

" 'умный' Home/End
noremap <expr> <Home> (col('.') == matchend(getline('.'), '^\s*')+1 ? '0' : '^')
noremap <expr> <End> (col('.') == match(getline('.'), '\s*$') ? '$' : 'g_')
vnoremap <expr> <End> (col('.') == match(getline('.'), '\s*$') ? '$h' : 'g_')
imap <Home> <C-o><Home><C-o>i
imap <End> <C-o><End><C-o>a<C-o>a

" комментируем/раскомментируем строки по Ctrl-/
"imap <C-C> <Esc>:call NERDComment(0, "invert")<CR>a
"nmap <C-C>      :call NERDComment(0, "invert")<CR>
"vmap <C-C>      :call NERDComment(0, "invert")<CR>

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
let g:AutoPairsFlyMode = 1
let g:TagmaBufMgrMapCArrow = 0

function! MakeTags(dir, tagfile)
    let cmd = 'ctags -R --tag-relative=yes -f ' . a:tagfile . ' ' . a:dir
    echo 'run ' . cmd
    let x = system(cmd)
endfunction

let g:Powerline_symbols = 'fancy'

nmap <silent> <C-B> :CtrlPBuffer<CR>
imap <silent> <C-B> <Esc>:CtrlPBuffer<CR>

source $HOME/.vim/settings/binary.vim
source $HOME/.vim/settings/latex.vim
source $HOME/.vim/settings/perl.vim
source $HOME/.vim/settings/python.vim
source $HOME/.vim/settings/mako.vim
source $HOME/.vim/settings/agru.vim
source $HOME/.vim/settings/kanobu.vim
