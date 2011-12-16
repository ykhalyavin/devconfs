" В AGAVA .ti, .tt, .tt2 это Template Toolkit
" Но tt2html работает медленно, подсвечиваем как простой html.
au BufEnter *.ti,*.tt,*.tt2  set ft=html

"autocmd BufReadPost * :call SetAgavaSettings()
"cab SAS call SetAgavaSettings()

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

