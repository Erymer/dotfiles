# enable substitution for prompt
setopt prompt_subst

# Prompt (on left side) similar to default bash prompt, or redhat zsh prompt with colors
# PROMPT="%(!.%{$fg[red]%}[%n@%m %1~]%{$reset_color%}# .%{$fg[green]%}[%n@%m %1~]%{$reset_color%}$ "
# Maia prompt
# PROMPT="%B%{$fg[cyan]%}%(4~|%-1~/.../%2~|%~)%u%b >%{$fg[cyan]%}>%B%(?.%{$fg[cyan]%}.%{$fg[red]%})>%{$reset_color%}%b " # Print some system information when the shell is first started
# Print a greeting message when shell is started
# echo $USER@$HOST  $(uname -srm) $(lsb_release -rcs)
## Prompt on right side:
#  - shows status of git when in git repository (code adapted from https://techanic.net/2012/12/30/my_git_prompt_for_zsh.html)
#  - shows exit status of previous command (if previous command finished with an error)
 
# Original prompt 
#PS1="%B\
#%{$fg[blue]%}[\
#%{$fg[blue]%}%n\
#%{$fg[yellow]%}@\
#%{$fg[yellow]%}%M \
#%{$fg[yellow]%}%~\
#%{$fg[yellow]%}]\
#%{$reset_color%}$\
#%b "

#Prompt example tha allows to use more colors
#PS1="%F{202}%K{000}%m\
#%F{015}%K{000}:\
#%F{039}%K{000}%~\
#%F{015}%K{000}\$ "

# PS1="%F{202}%K{000}%n\
# %F{202}%K{000}@\
# %F{white}%K{000}%~\
# %F{202}%K{000}:\
# %F{202}%K{000}\$ "

# Fedora prompt
# PROMPT="%B%{$fg[gray]%}%(4~|%-1~/.../%2~|%~)%u%b >%{$fg[gray]%}>%B%(?.%{$fg[gray]%}.%{$fg[red]%})>%{$reset_color%}%b "

# Current prompt
PROMPT="%(!.%#.%{$fg[magenta]%}[%n@%m %1~]%{$reset_color%}$ "

# Base16 Shell
# For more info:
# https://github.com/chriskempson/base16-shell
# BASE16_SHELL="$HOME/.config/base16-shell/"
# [ -n "$PS1" ] && \
#     [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
#         eval "$("$BASE16_SHELL/profile_helper.sh")"


# Apply different settigns for different terminals
case $(basename "$(cat "/proc/$PPID/comm")") in
  login)
    	RPROMPT="%{$fg[red]%} %(?..[%?])" 
    	alias x='startx ~/.xinitrc'      # Type name of desired desktop after x, xinitrc is configured for it
        # If the terminal is running without xorg, this is the promp that will be used
        PS1="%F{yellow}%K{000}%n%F{yellow}%K{000}@%F{white}%K{000}%~%F{yellow}%K{000}:%F{yellow}%K{000}\$ "
    ;;
 'tmux: server')
       RPROMPT='$(git_prompt_string)'
#		## Base16 Shell color themes.
		# possible themes: 3024, apathy, ashes, atelierdune, atelierforest, atelierhearth,
#		#atelierseaside, bespin, brewer, chalk, codeschool, colors, default, eighties, 
#		#embers, flat, google, grayscale, greenscreen, harmonic16, isotope, londontube,
#		#marrakesh, mocha, monokai, ocean, paraiso, pop (dark only), railscasts, shapesifter,
#		#solarized, summerfruit, tomorrow, twilight
		theme="monokai"
#		#Possible variants: dark and light
		shade="dark"
		# BASE16_SHELL="/usr/share/zsh/scripts/base16-shell/base16-$theme.$shade.sh"
		BASE16_SHELL="$HOME/.config/base16-shell/scripts/base16-$theme.$shade.sh"
		[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL
#		# Use autosuggestion
    # PS1="%F{yellow}%K{000}%n%F{yellow}%K{000}@%F{white}%K{000}%~%F{yellow}%K{000}:%F{yellow}%K{000}\$ "
		source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
		ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
 		ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
    ;;
  *)
        RPROMPT='$(git_prompt_string)'
		# Use autosuggestion
		source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
		ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
  		ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
    ;;
esac

