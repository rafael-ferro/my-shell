# Personalizar prompt no terminal
# hostname (\h) e working directory (\w) com cores
# If id command returns zero, you’ve root access.
if [ $(id -u) -eq 0 ];
then # you are root, set red colour prompt
  PS1="\\[$(tput setaf 1)\\]\\u@\\h:\\w #\\[$(tput sgr0)\\]"
else # normal
  PS1="\[\e[34m\]\u @ \h \[\e[36m\]\w \[\e[35m\]\$(__git_ps1 '(%s)') \n\[\e[36m\]└─▶\[\e[0m\] \[\e[1;31m\]\$ \[\e[0m\]"
fi
