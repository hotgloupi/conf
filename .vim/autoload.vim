
function! LoadTemplate(extension, type)
    if (a:type == 'all')
        silent! execute '0r ' . $HOME . '/.vim/templates/' . a:extension . '.tpl'
    endif
    if (a:type == 'all')
        silent! execute 'source ' . $HOME . '/.vim/templates/autocompletion.vim'
        silent! execute 'source ' . $HOME . '/.vim/templates/' . a:extension . '.vim'
    endif
    silent! execute 'source ' . $HOME . '/.vim/specific/' . a:extension . '.vim'
endfunction

autocmd BufNewFile *  silent! call LoadTemplate('%:e', 'all')
autocmd BufRead    *  silent! call LoadTemplate('%:e', 'no_template')

autocmd BufNewFile Makefile silent! call LoadTemplate('makefile', 'all')
autocmd BufRead    Makefile silent! call LoadTemplate('makefile', 'no_template')

autocmd BufNewFile,BufRead SCons* set filetype=scons
autocmd BufNewFile,BufRead *.py++ set filetype=cpp
