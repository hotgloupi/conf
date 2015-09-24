
if exists("$FULLNAME")
  let mename = $FULLNAME
elseif exists("$LOGIN")
  let mename = $LOGIN
else
  let mename = "@NAME@"
endif

if exists("$LOGIN")
    let melogin = $LOGIN
elseif exists("$USER")
    let melogin = $USER
else
    let melogin = "@LOGIN@"
endif

if exists("$EMAIL")
  let memail = $EMAIL
else
  let memail = $LOGIN . '@'  . $HOST
endif

3match Todo /@[^@ ]\+@/
execute "% s,@FILE-NAME@," . expand('%:t') . ",ge"
execute "% s,@FILE-NAME-UPPER@," . substitute(toupper(expand('%:t')), "\\.", "_", 'g') . ",ge"
execute "% s,@LOGIN-STRING@," . g:melogin . ",ge"
execute "% s,@USER-MAIL@," . g:memail . ",ge"
execute "% s,@USER-NAME@," . g:mename . ",ge"
execute "% s/@DATE-STAMP@/" . strftime("%c") . "/ge"
execute "% s,@PWD@," . $PWD . ",ge"

