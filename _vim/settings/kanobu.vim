autocmd BufReadPost * :call SetKanobuSettings()
cab SAS call SetKanobuSettings()

function! SetKanobuSettings()
    " Temporary buffer, ignore
    if expand('%') == ''
        return
    endif

    if &ft =~ 'git'
        return
    endif

    " Для плагина 'CommandT' -- игнорируем данные директории
    set wildignore+=*.o,*.obj,*.so,*.d,*~,*.a,*.ico,*.jpg,*.png,*.gif,tags

    set tags=

    if getcwd() =~ "plus_gw/lib/cardsgateway"
        let $p = substitute(getcwd(), 'plus_gw/lib/cardsgateway.*', 'plus_gw', 'g')
        let $t = $HOME . "/.tmp/pgw_tags"

        command! -nargs=* MakeTags call MakeTags($p, $t)

        set tags=$t
        nmap <silent> <leader>t :CommandT $p<cr>
        nmap <silent> <C-P> :CtrlP $p<cr>
        imap <C-P> <Esc>:CtrlP $p<cr>

        set noet
    elseif getcwd() =~ "src/projects/plus_adm"
        let $p = substitute(getcwd(), 'src/projects/plus_adm.*', 'src/projects/plus_adm', 'g')
        let $t = $HOME . "/.tmp/padm_tags"

        command! -nargs=* MakeTags call MakeTags($p, $t)

        set tags=$t
        nmap <silent> <leader>t :CommandT $p<cr>
        nmap <silent> <C-P> :CtrlP $p<cr>
        imap <C-P> <Esc>:CtrlP $p<cr>

        set noet
    endif
endfunction

