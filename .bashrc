# vim: filetype=sh
set correct                                                  # Auto correct mistakes
set extendedglob        # Extended globbing. Allows using regular expressions with *
set nocaseglob                                           # Case insensitive globbing
set rcexpandparam                                  # Array expension with parameters
set nocheckjobs                    # Don't warn about running processes when exiting
set numericglobsort                 # Sort filenames numerically when it makes sense
set nobeep                                                   
set appendhistory                # Immediately append history instead of overwriting
set histignorealldups        # If a new command is a duplicate, remove the older one
set autocd                             # if only directory path is entered, cd there
set HIST_IGNORE_SPACE

set -o vi

HISTFILE=~/.bash_history
HISTSIZE=1000
SAVEHIST=500

# Seleccionar editor para editar linea de comandos con C-e
export EDITOR=vim
export VISUAL=vim

WORDCHARS=${WORDCHARS//\/[&.;]}                                 # Don't consider certain characters part of the word

# enable substitution for prompt
set prompt_subst

# Current prompt
PROMPT="%B%{$fg[white]%}%(4~|%-1~/.../%2~|%~)%u%b >%{$fg[white]%}>%B%(?.%{$fg[white]%}.%{$fg[red]%})>%{$reset_color%}%b "

ALIAS_DIRECTORY=$HOME/.config/alias

for file in $ALIAS_DIRECTORY/* ; do
  if [ -f "$file" ] ; then
    . "$file"
  fi
done
