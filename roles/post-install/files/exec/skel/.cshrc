
if ( -f "$HOME/.alias" ) then
    source "$HOME/.alias"
endif

if ( "`id -u`" == 0 ) then
    set prompt = ' %T %N@%m:%~ \n#>'
else
    set prompt = ' %T %N@%m:%~ \n$>'
endif
