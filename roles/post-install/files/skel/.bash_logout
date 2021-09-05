# ~/.bash_logout: executed by bash(1) when login shell exits.

##############################
## 
## permit to be excuted on sh end
##
##############################

if [ -f "${HOME}/.logout" ]; then
    . "${HOME}/.logout"
fi