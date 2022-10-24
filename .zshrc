# vim:filetype=sh
## Options section
setopt correct                                                  # Auto correct mistakes
setopt extendedglob        # Extended globbing. Allows using regular expressions with *
setopt nocaseglob                                           # Case insensitive globbing
setopt rcexpandparam                                  # Array expension with parameters
setopt nocheckjobs                    # Don't warn about running processes when exiting
setopt numericglobsort                 # Sort filenames numerically when it makes sense
setopt nobeep                                                   
setopt appendhistory                # Immediately append history instead of overwriting
setopt histignorealldups        # If a new command is a duplicate, remove the older one
setopt autocd                             # if only directory path is entered, cd there
setopt HIST_IGNORE_SPACE

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' rehash true      # automatically find new executables in path 
# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
HISTFILE=~/.zhistory
HISTSIZE=1000
SAVEHIST=500

# Seleccionar editor para editar linea de comandos con C-e
export EDITOR=nvim
export VISUAL=nvim
export PREDGER_ID="Marcelo"
# export PAGER=bat

WORDCHARS=${WORDCHARS//\/[&.;]}                                 # Don't consider certain characters part of the word


# ## Keybindings Originales
# bindkey -e
bindkey '^[[7~' beginning-of-line                               # Home key
# bindkey '^[[H' beginning-of-line                                # Home key
# if [[ "${terminfo[khome]}" != "" ]]; then
#   bindkey "${terminfo[khome]}" beginning-of-line                # [Home] - Go to beginning of line
# fi
# bindkey '^[[8~' end-of-line                                     # End key
# bindkey '^[[F' end-of-line                                     # End key
# if [[ "${terminfo[kend]}" != "" ]]; then
#   bindkey "${terminfo[kend]}" end-of-line                       # [End] - Go to end of line
# fi
# bindkey '^[[2~' overwrite-mode                                  # Insert key
# bindkey '^[[3~' delete-char                                     # Delete key
# bindkey '^[[C'  forward-char                                    # Right key
# bindkey '^[[D'  backward-char                                   # Left key
# bindkey '^[[5~' history-beginning-search-backward               # Page up key
# bindkey '^[[6~' history-beginning-search-forward                # Page down key

# # Navigate words with ctrl+arrow keys
# bindkey '^[Oc' forward-word                                     #
# bindkey '^[Od' backward-word                                    #
# bindkey '^[[1;5D' backward-word                                 #
# bindkey '^[[1;5C' forward-word                                  #
# bindkey '^[[Z' undo                                             # Shift+tab undo last action

# vi mode
bindkey -v
export KEYTIMEOUT=1

bindkey '^H' backward-kill-word                                 # delete previous word with ctrl+backspace
# # Use vim keys in tab complete menu:
# bindkey -M menuselect 'h' vi-backward-char
# bindkey -M menuselect 'k' vi-up-line-or-history
# bindkey -M menuselect 'l' vi-forward-char
# bindkey -M menuselect 'j' vi-down-line-or-history
# bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
    if [[ ${KEYMAP} == vicmd ]] ||
           [[ $1 = 'block' ]]; then
        echo -ne '\e[1 q'
    elif [[ ${KEYMAP} == main ]] ||
             [[ ${KEYMAP} == viins ]] ||
             [[ ${KEYMAP} = '' ]] ||
             [[ $1 = 'beam' ]]; then
        echo -ne '\e[5 q'
    fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Theming section  
autoload -U compinit colors zcalc
compinit -d
colors

# Color man pages
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-r


## Plugins section: Enable fish style features

CURRENT_OS=$(grep -e '^NAME' </etc/os-release | sed 's/NAME=//')

if [ "${CURRENT_OS}" = '"Arch Linux"' ] ; then
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
elif [ "${CURRENT_OS}" = '"Fedora Linux"' ] ; then
  source /usr/share/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  source /usr/share/zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
fi

# bind UP and DOWN arrow keys to history substring search
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^[[A' history-substring-search-up			
bindkey '^[[B' history-substring-search-down


export PATH="${PATH}:$HOME/.magBin"
export PATH="${PATH}:/home/mag/.local/bin/"
export PATH="${PATH}:$HOME/.emacs.d/bin"


source $HOME/.config/zshrc/git-prompt.sh
source $HOME/.config/zshrc/constant-definition.sh
source $HOME/.config/zshrc/prompt.sh
source $HOME/.config/zshrc/zoxide # cd replacement

# source all files in alias directory
for file in $ALIAS_DIRECTORY/* ; do
  if [ -f "$file" ] ; then
    . "$file"
  fi
done

$HOME/Projects/Python/oracle-cli/oracle-cli.py

PATH="/home/mag/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/mag/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/mag/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/mag/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/mag/perl5"; export PERL_MM_OPT;
