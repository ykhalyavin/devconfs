autocmd FileType tex set makeprg=rubber\ --warn\ boxes\ -d\ %\ 2>&1\ \\\|\ sed\ 's/-.*:/:/'
autocmd FileType tex nmap <F10> :!rubber -d --clean %<CR>
autocmd FileType tex imap <F10> <ESC>:!rubber -d --clean %<CR>i
autocmd FileType tex nmap <F12> :!okular %<.pdf &<CR>
autocmd FileType tex imap <F12> <ESC>:!okular %<.pdf &<CR>i
