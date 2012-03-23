autocmd BufReadPost * :call SetAgRuSettings()
cab SAS call SetAgRuSettings()

function! SetAgRuSettings()
    " Temporary buffer, ignore
    if expand('%') == ''
        return
    endif

    if &ft =~ 'git'
        return
    endif

    " Для плагина 'CommandT' -- игнорируем данные директории
    set wildignore+=*.o,*.obj,*.so,*.d,*~,*.a,*.ico,*.jpg,*.png,*.gif,tags

    if getcwd() =~ "ag/ag_15"
        let $p = substitute(getcwd(), 'ag/ag_15/.*', 'ag/ag_15', 'g')

        set tags=$p/tags
        nmap <silent> <leader>t :CommandT $p<cr>
        nmap <silent> <C-P> :CtrlP $p<cr>
        imap <C-P> <Esc>:CtrlP $p<cr>

        " старый AG.ru использует табы, не преобразовываем табуляцию в пробелы
        set noet
    endif

endfunction
