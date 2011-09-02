" Basics {
    " Включаем несовместимость настроек с Vi (ибо Vi нам и не понадобится).
    set nocompatible
    retab
    syntax on
" }

" General {
    filetype off

    call pathogen#runtime_append_all_bundles()
    call pathogen#helptags()

    filetype plugin indent on

    set autochdir " always switch to the current file directory
    set nobackup
    set hidden " you can change buffers without saving
    set wildmenu
    set noswapfile
    set ttyfast
    set undolevels  =100
    set wildmode    =longest,list,full
    set wildignore  =*.o,*.obj,*.bak,*.exe,*.swp,*.a,*.svn,*.git
    set backspace   =indent,eol,start whichwrap+=<,>,[,] " use backspace instead of "x"
    set laststatus  =2
    set history     =500
    set browsedir   =buffer
    set display     =lastline
    set shell       =/bin/bash
    set wcm         =<Tab>
    set pastetoggle =<F3>  " Переключение режима paste по F3
" }

" Vim UI {
    set novisualbell  " don't blink
    set nostartofline " leave my cursor where it was
    set incsearch     " incremental search
    set nohlsearch    " do not highlight searched for phrases
    set list          " we do what to show tabs, to ensure we get them out of my files
    set listchars=tab:\|\ \,trail:> " show tabs and trailing
    set showmatch     " проверка скобок
    set matchpairs+=<:>
    set matchtime=2   " how many tenths of a second to blink matching brackets for
    set shortmess+=I  " Не показывать заставку про помощь уганде при старте vim
    set scrolloff=3   " Начинать прокрутку текста, когда до края остается 3 линии
    set sidescroll=5  " The minimal number of columns to scroll horizontally.
                      " Used only when the 'wrap' option is off.
    set ruler         " Показывать положение курсора всё время.
    set showmode      " Отображать текущий режим Insert/Replace/etc
    "set statusline=%<[%n]\ %f\ %m%r%h%w\ %y\ %{&fileencoding}%=%b\ \ \ %c/%v\ %l/%L\ \ %P\ %a
    set statusline=%<[%n]\ %f\ %([%{Tlist_Get_Tagname_By_Line()}]%)\ %m%r%h%w\ %y\ %{&fileencoding}%=%b\ \ \ %c/%v\ %l/%L\ \ %P\ %a
    set colorcolumn=79
" }

" Text Formatting/Layout {
    set expandtab     " Преобразование Таба в пробелы
    set softtabstop=4 " when hitting tab or backspace, how many spaces
                      " should a tab be (see expandtab)
    set tabstop=4     " real tabs should be 8, and they will show with
                      " set list on. But I like 4.
    set shiftwidth=4  " Number of spaces to use for each step of (auto)indent.
                      " Used for 'cindent', >>, <<, etc
    set autoindent    " Включить автоотступы
    set copyindent    " copy the indentation structure of existing lines when
                      " autoindenting
    set textwidth=78
" }


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" gui - settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if $DISPLAY != '' && !has('gui_running') && $MRXVT_TABTITLE != ''
    let xterm16bg_Normal = 'none'
endif
if has("gui_running")
    set guioptions =afgitef
    set guifont    =Liberation\ Mono\ 10
    set lines      =75
    set columns    =185
    set background =dark

    colorscheme github
endif

autocmd BufEnter * :syntax sync fromstart

" Omni menu colors
hi Pmenu    guibg=#333333
hi PmenuSel guibg=#555555 guifg=#ffffff

""""""""""""""""""""""""""""""
" Visual
""""""""""""""""""""""""""""""

function Mycopen()
    :copen
    :setlocal nobuflisted
    :setlocal bufhidden=hide
    :setlocal noswapfile
endfunction

cab copen call Mycopen()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" own stuff
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" menu for fast enc change
menu Encoding.koi8-r       :e ++enc=koi8-r<CR>
menu Encoding.windows-1251 :e ++enc=cp1251<CR>
menu Encoding.ibm-866      :e ++enc=ibm866<CR>
menu Encoding.utf-8        :e ++enc=utf-8 <CR>

map <Leader>e :emenu Encoding.<TAB>


menu Global.mru  :TRecentlyUsedFiles<CR>
menu Global.zsh  :ConqueTermSplit zsh<CR> <ESC>:wincmd r<CR>:resize 3<CR>i
menu Global.bash :ConqueTermSplit bash<CR><ESC>:wincmd r<CR>:resize 3<CR>i
menu Global.tags :call LstTags('tsg')<CR>

map <Leader>g :emenu Global.<TAB>

" Выключаем ненавистный режим замены
imap <Ins> <Esc>a
" Включаем, выключаем отображение номеров строк
nmap <C-N><C-N> :set invnumber<CR>
" Проверка орфограции
"nmap <silent> ,sp :set spl=ru,en spell!<CR>

" нормальный PageUp/Down
nmap <PageUp> <C-U><C-U>
imap <PageUp> <C-O><C-U><C-O><C-U>
nmap <PageDown> <C-D><C-D>
imap <PageDown> <C-O><C-D><C-O><C-D>
" Форматирование по ближайшей скобке
imap <C-L> <C-O>=%
" 'умный' Home
nmap <Home> ^
imap <Home> <Esc>I
" Format text
imap <C-J> <C-O>gqap
nmap <C-J>      gqap
vmap <C-J>      gq
" Комментируем/раскомментируем строки по Ctrl-C
imap <C-C> <Esc>:call NERDComment(0, "invert")<CR>a
nmap <C-C>      :call NERDComment(0, "invert")<CR>
vmap <C-C>      :call NERDComment(0, "invert")<CR>
" Switch between open buffers
imap <F1> <Esc>:bn<CR>a
nmap <F1>      :bn<CR>
" сохранение текущего буфера
imap <unique> <F2> <Esc>:w<CR>a
nmap <unique> <F2>      :w<CR>
" Destroy current buffer with F4
imap <F4> <Esc>:BD<CR>a
nmap <F4>      :BD<CR>
" вкл/выкл отображения найденных соответствий
imap <S-F1> <Esc>:set<Space>hls!<CR>a
nmap <S-F1>      :set<Space>hls!<CR>

" Хоткей для NERDTree
nnoremap <leader>p :NERDTreeToggle<cr>
" NERDTree показывает закладки
let NERDTreeShowBookmarks = 1

" Insert mode when entering ConqueTerm buffer
let g:ConqueTerm_InsertOnEnter = 1
" Keep updating terminal buffer
let g:ConqueTerm_ReadUnfocused = 1

" TagList: Не расширять окошко
let Tlist_Inc_Winwidth = 0
let Tlist_Exit_OnlyWindow = 1     " exit if taglist is last window open
let Tlist_Show_One_File = 1 " Only show tags for current buffer
let Tlist_Enable_Fold_Column = 0  " no fold column (only showing one file)
let Tlist_Compact_Format = 1 " show small menu
let Tlist_Sort_Type = "name" " order by
let tlist_sql_settings = 'sql;P:package;t:table'
let tlist_ant_settings = 'ant;p:Project;r:Property;t:Target'

nnoremap <silent> <F8> :TlistToggle<CR>

map <Up> gk
imap <Up> <C-O><Up>
map <Down> gj
imap <Down> <C-O><Down>
map <End> g$
imap <End> <C-O><End>

nmap <silent> <F6> \bs
imap <silent> <F6> <ESC>\bs

map <esc>[23~ <s-f1>
map <esc>[24~ <s-f2>
map <esc>[25~ <s-f3>
map <esc>[26~ <s-f4>
map <esc>[28~ <s-f5>
map <esc>[29~ <s-f6>
map <esc>[31~ <s-f7>
map <esc>[32~ <s-f8>
map <esc>[33~ <s-f9>
map <esc>[34~ <s-f10>
map <esc>[23$ <s-f11>
map <esc>[24$ <s-f12>

" сборка с сохранением
if filereadable("Makefile")
    set makeprg=make\ -j2
    imap <unique> <F9> <Esc>:wa<CR>:make<CR>:cw<CR>
    nmap <unique> <F9> :wa<CR>:make<CR>:cw<CR>
else
    imap <unique> <F9> <Esc>:make %:r<CR>:cw<CR>
    nmap <unique> <F9> :wa<CR>:make %:r<CR>:cw<CR>
endif

" Always cd to the current file's directory
autocmd BufEnter * silent! lcd %:p:h:gs/ /\\ /

autocmd FileType html,mail set formatoptions=tq textwidth=78

" Perl settings {
    autocmd FileType perl set nowrap textwidth=78 keywordprg=perldoc\ -f
    autocmd FileType perl set errorformat=%f:%l:%m
    autocmd FileType perl set autowrite
    " Check perl code with :make
    autocmd FileType perl set makeprg=perl\ -c\ %\ $*

    autocmd BufEnter *.pl,*.pm compiler perl
    autocmd BufEnter *.pl,*.pm set softtabstop=4 sw=4

    " syntax color complex things like @{${"foo"}}
    let perl_extended_vars = 1
    let perl_include_pod = 1
" }

" LaTeX settings {
    autocmd FileType tex set makeprg=rubber\ --warn\ boxes\ -d\ %\ 2>&1\ \\\|\ sed\ 's/-.*:/:/'
    autocmd FileType tex nmap <F10> :!rubber -d --clean %<CR>
    autocmd FileType tex imap <F10> <ESC>:!rubber -d --clean %<CR>i
    autocmd FileType tex nmap <F12> :!okular %<.pdf &<CR>
    autocmd FileType tex imap <F12> <ESC>:!okular %<.pdf &<CR>i
" }

au BufEnter *.rb   set makeprg=ruby\ %
au BufEnter *.mako set ft=mako softtabstop=2 sw=2
au BufEnter *.tmpl set ft=tmpl softtabstop=2 sw=2
au BufEnter *.py   set softtabstop=4 sw=4

" В AGAVA .ti, .tt, .tt2 это Template Toolkit
" Но tt2html работает медленно, подсвечиваем как простой html.
au BufEnter *.ti,*.tt,*.tt2  set ft=html

au BufEnter *.htaccess set nowrap
au BufEnter *.tmpl set softtabstop=2 sw=2
au BufEnter wiki.botik.ru* set ft=twiki

au Filetype html,eruby,tt2html set softtabstop=2 sw=2

autocmd BufRead *.session so %

au BufReadPost *.cpp set isk+=:

"autocmd VimLeave * echo "Cya in Hell."
"autocmd VimLeavePre * silent mksession ~/.vim/lastSession.vim

autocmd BufNewFile  *.pl    0r /home/delphi/.vim/templates/perl
autocmd BufNewFile  *.tex   0r /home/delphi/.vim/templates/tex
autocmd BufNewFile  *.py    0r /home/delphi/.vim/templates/python
autocmd BufNewFile  *.c     0r /home/delphi/.vim/templates/c
autocmd BufNewFile  *.cpp   0r /home/delphi/.vim/templates/c
autocmd BufNewFile  *.{pl,py,tex,c,cpp} :10000 " go cursor to last line

" reading Ms-Word documents, requires antiword
augroup msword
    au!
    autocmd BufReadPre  *.doc set ro
    autocmd BufReadPre  *.doc set hlsearch!
    autocmd BufReadPost *.doc %!catdoc -d utf-8 "%"
augroup END

autocmd BufRead  *.txt  set ft=text
autocmd BufRead,BufNewFile  *.c,*.h set formatoptions=ql cindent comments=sr:/*,mb:*,el:*/,://

augroup completions
    au!
    autocmd FileType python set omnifunc=pythoncomplete#Complete
    autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
    autocmd FileType css set omnifunc=csscomplete#CompleteCSS
    autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
    autocmd FileType php set omnifunc=phpcomplete#CompletePHP
    autocmd FileType c set omnifunc=ccomplete#Complete
augroup END

" for display function in statusline. plugin ctags.
"""""""""""""""""""""""""""""""""""""""""""""""""""
augroup ctags
    au!
    autocmd BufRead *.c,*.h,*.pl,*.pm,*.py let g:ctags_path='/usr/bin/ctags'
    autocmd BufRead *.c,*.h,*.pl,*.pm,*.py let g:ctags_statusline=1
    autocmd BufRead *.c,*.h,*.pl,*.pm,*.py let generate_tags=1
augroup END

" tell vim to restore last cursor position on file open (cygwin doesn't have
" it by default somehow)
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") |
            \ exe "normal g'\"" | endif

" vim -b : edit binary using xxd-format
augroup Binary
    au!
    au BufReadPre   *.bin let &bin=1
    au BufReadPost  *.bin if &bin | %!xxd
    au BufReadPost  *.bin set ft=xxd | endif
    au BufWritePre  *.bin if &bin | %!xxd -r
    au BufWritePre  *.bin endif
    au BufWritePost *.bin if &bin | %!xxd
    au BufWritePost *.bin set nomod | endif
    au BufEnter     *.bin colo moria
augroup END

" Easily switch_between source_and header file.
" Stolen from:
" http://vim.wikia.com/wiki/Easily_switch_between_source_and_header_file
au BufEnter *.[ch] nmap ,s :find %:t:r.c<cr>
au BufEnter *.[ch] nmap ,S :sf %:t:r.c<cr>
au BufEnter *.[ch] nmap ,h :find %:t:r.h<cr>
au BufEnter *.[ch] nmap ,H :sf %:t:r.h<cr>
"
" Automatic insertion of C/C++ header gates (Modified version)
" Stolen from:
" http://vim.wikia.com/wiki/Automatic_insertion_of_C/C%2B%2B_header_gates
function! s:insert_gates()
  let gatename = substitute(toupper(expand("%:t")), "\\.", "_", "g")
  execute "normal! i#ifndef " . gatename
  execute "normal! o#define " . gatename
  execute "normal! 3o"
  execute "normal! Go#endif /* " . gatename . " */"
  normal! kk
endfunction
autocmd BufNewFile *.{h,hpp} nmap ,g :call <SID>insert_gates()<cr>

cab W  w
cab Wq wq
cab wQ wq
cab WQ wq
cab Q  q

syn sync minlines=10000 maxlines=10000

iab tdate <C-R>=strftime("%a\ %b\ %e\ %I:%M\ %p")<CR>
iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>

let python_highlight_all=1

au BufReadPost *.vim  map K :exe ":help ".expand("<cword>")<CR>
au BufReadPost .vimrc map K :exe ":help ".expand("<cword>")<CR>

" Search keyword in current finction or block.
" Stolen from:
" http://vim.wikia.com/wiki/Search_keywords_in_c_function
" Search within top-level block for word at cursor.
nnoremap <Leader>[ "ayiw/<C-R>=ScopeSearch("[[")<CR><C-R>a<CR>
" Search within current block for word at cursor.
nnoremap <Leader>{ "ayiw/<C-R>=ScopeSearch("[{")<CR><C-R>a<CR>
" Search within current top-level block for user-entered text.
nnoremap <Leader>/ /<C-R>=ScopeSearch("[[")<CR>

" Return a string to place at the beginning of a search to limit
" the search to a certain scope.
" navigator is a command to jump to the beginning of the desired scope.
function! ScopeSearch(navigator)
  exec 'normal ' . a:navigator
  let l:s = line(".")
  normal %
  let l:e = line(".")
  normal %
  if l:s < l:e
    return '\%>' . (l:s-1) . 'l\%<' . (l:e+1) . 'l'
  endif
  echo "Cannot find search scope with command " . a:navigator . " %"
  return ""
endfunction

function SaveSession()
    :silent mksession! ~/.vim/lastSession.session
endfunction
cab savesession call SaveSession()

function RestoreSession()
    :silent source ~/.vim/lastSession.session
endfunction
cab restoresession call RestoreSession()


" Этот код автоматически удаляет лишие пробелы в тексте перед сохранением
" файла
"au BufWritePre,FileWritePre * let au_line=line(".")
"au BufWritePre,FileWritePre * let au_col=col(".")
"au BufWritePre,FileWritePre * %s/\s\+$//e
"au BufWritePost * silent call cursor(au_line, au_col)


autocmd BufReadPost * :call SetAgavaSettings()
cab SAS call SetAgavaSettings()
function SetAgavaSettings()
    " Temporary buffer, ignore
    if expand('%') == ''
        return
    endif

    set wildignore-=AGAVA
    set wildignore-=pOfficeCol
    set wildignore-=log
    set wildignore-=logs
    set wildignore-=app_log
    set wildignore-=personal_office
    set wildignore-=session
    set wildignore-=sessions

    if getcwd() =~ "cgi/billing"
        let $p = substitute(getcwd(), '/cgi/billing.*', '/cgi/billing', 'g')

        " Устанавливаем правильную кодировку, если необходимо
        if &fileencoding != "koi8-r"
            execute "e ++enc=koi8-r"
        endif
    elseif getcwd() =~ "poffice/personal_office"
        let $p = substitute(getcwd(), '/poffice/personal_office.*', '/poffice/personal_office', 'g')

        " Устанавливаем правильную кодировку, если необходимо
        if &fileencoding != "koi8-r"
            execute "e ++enc=koi8-r"
        endif

        " Для плагина 'CommandT' -- игнорируем данные директории
        set wildignore+=AGAVA
        set wildignore+=pOfficeCol
        set wildignore+=session
    elseif getcwd() =~ "poffice/registration"
        let $p = substitute(getcwd(), '/poffice/registration.*', '/poffice/registration', 'g')

        " Для плагина 'CommandT' -- игнорируем данные директории
        set wildignore+=personal_office
        set wildignore+=sessions
    else
        let $p = getcwd()
    endif

    " Если мы в одном из проектов AGAVA -- устанавливаем общие настройки
    if $p != getcwd()
        " Для плагина 'CommandT' -- игнорируем данные директории
        set wildignore+=log
        set wildignore+=logs
        set wildignore+=app_log
    endif

    set tags=$p/tags
    nnoremap <silent> <leader>t :CommandT $p<cr>
    syntax on
endfunction

let g:qb_hotkey = "<F10>"

let Tlist_Show_One_File = 1
let Tlist_Compact_Format = 1
let Tlist_Close_On_Select = 1
let Tlist_Use_SingleClick = 1
let Tlist_Process_File_Always = 1
let Tlist_GainFocus_On_ToggleOpen = 1
