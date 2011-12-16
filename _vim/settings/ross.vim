autocmd BufReadPost * :call SetRossSettings()
cab SRS call SetRossSettings()

function SetRossSettings()
    " Temporary buffer, ignore
    if expand('%') == ''
        return
    endif

    if &ft =~ 'git'
        return
    endif

    if getcwd() =~ "TMS320DM365"
        let $p = substitute(getcwd(), '/TMS320DM365/.*', '/TMS320DM365', 'g')
        let $c = $p . "/source/programs"
        " Для плагина 'CommandT' -- игнорируем данные директории
        set wildignore+=system_source
    elseif getcwd() =~ "snd_time_daemon"
        let $p = substitute(getcwd(), '/snd_time_daemon/.*', '/snd_time_daemon', 'g')
        let $c = $p
    elseif getcwd() =~ "orinoko-install"
        let $p = substitute(getcwd(), '/orinoko-install/.*', '/orinoko-install', 'g')
        let $c = $p
    elseif getcwd() =~ "ini_client_test"
        let $p = substitute(getcwd(), '/ini_client_test/.*', '/ini_client_test', 'g')
        let $c = $p
    elseif getcwd() =~ "cicada-r2p-server"
        let $p = substitute(getcwd(), '/cicada-r2p-server/.*', '/cicada-r2p-server', 'g')
        let $c = $p
    elseif getcwd() =~ "axis_lib"
        let $p = substitute(getcwd(), '/axis_lib/.*', '/axis_lib', 'g')
        let $c = $p
    elseif getcwd() =~ "dispatcher_lib"
        let $p = substitute(getcwd(), '/dispatcher_lib/.*', '/dispatcher_lib', 'g')
        let $c = $p
    else
        return
    endif

    set wildignore-=system_source
    set wildignore+=*.d

    " Устанавливаем правильную кодировку, если необходимо
    "if &fileencoding != "cp1251"
        "execute "e ++enc=cp1251"
    "endif

    "set tags=$p/tags
    nnoremap <silent> <leader>t :CommandT $c<cr>

    " ROSS использует табы, не преобразовываем табуляцию в пробелы
    set noet
    "syntax on
endfunction

