# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
#if [[ -r "${XDG_CACHE_HOME:-$HOMEby/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
#fi

# default_browser
export BROWSER=/usr/bin/firefox

#export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/coder/.oh-my-zsh"

# Set name of the theme to load
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=2

# Which plugins would you like to load?
plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-256color bgnotify)

#autoload -U compinit && compinit
#zstyle ':completion:*' rehash tru

source $ZSH/oh-my-zsh.sh

### User configuration ###

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#export HISTCONTROL=ignoreboth:erasedups
#PS1='[\u@\h \W]\$ '

if [ -d "$HOME/.bin" ]; then
  PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ]; then
  PATH="$HOME/.local/bin:$PATH"
fi

# # ex = EXtractor for all kinds of archives
# # usage: ex <file>
ex() {
  if [ -f $1 ]; then
    case $1 in
    *.tar.bz2) tar xjf $1 ;;
    *.tar.gz) tar xzf $1 ;;
    *.bz2) bunzip2 $1 ;;
    *.rar) unrar x $1 ;;
    *.gz) gunzip $1 ;;
    *.tar) tar xf $1 ;;
    *.tbz2) tar xjf $1 ;;
    *.tgz) tar xzf $1 ;;
    *.zip) unzip $1 ;;
    *.Z) uncompress $1 ;;
    *.7z) 7z x $1 ;;
    *.deb) ar x $1 ;;
    *.tar.xz) tar xf $1 ;;
    *) echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

### Aliases ###

alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -i'
alias ls='ls --color=auto'
alias la='ls -a'
alias ll='ls -la'
alias l='ls'
alias l.="ls -A | egrep '^\.'"

#configs
alias zshconfig="subl ~/.zshrc &"
alias i3config="subl ~/.i3/config &"
alias kittyconfg="subl ~/.config/kitty/kitty.conf &"
alias dunstconfig="subl ~/.config/dunst/dunstrc &"
alias polybarconfig="subl ~/.config/polybar/config &"
alias zathuraconfig="subl ~/.config/zathura/zathurarc &"
alias picomconfig="subl ~/.config/picom/picom.conf"
alias fusumaconfig="subl ~/.config/fusuma/config.yml"

#grub update
alias updategrub="sudo grub-mkconfig -o /boot/grub/grub.cfg"

#New fonts
alias updatefc='sudo fc-cache -fv'

#Recent Installed Packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"

#pacman
alias install="yay -S"
alias update="yay -Syyuu"
alias remove="yay -Rns"
#Re-Launch
alias polybar="~/.config/polybar/launch.sh &"
alias dunst="~/.config/dunst/launch.sh &"
alias picom='picom --experimental-backend'
#Multimedia
alias player="ncmpcpp"
alias mixer='ncpamixer'
alias vlc='devour vlc'
alias mute='amixer -q -D pulse sset Master toggle'
#alias dmusic='youtube-dl --config-location ~/.config/youtube-dl/music'
#alias dvideo='youtube-dl --config-location ~/.config/youtube-dl/video'
alias ristretto='devour ristretto'
alias zathura='devour zathura'
#legendary epic games cli
alias epiclist='legendary list-games'
alias epiclistinstalled='legendary list-installed'
alias epicinstall='legendary install'
alias epicupdate='legendary list-installed --check-updates'
alias epiclaunch='legendary launch'
#Utilities
alias class='xprop | grep -i -e "^wm_name\|^wm_class"'
alias date='date "+%A, %B %d, %Y [%T]"'
alias ping='ping -c 5'
alias cls=' echo -ne "\033c"'
alias grep='grep --color=auto'
alias q='exit'
alias clima='curl wttr.in'
alias color='colorpicker --short --one-shot | xsel -b'
#alias mongodb='mongod --port 27017 --dbpath ~/.config/mongodb'
alias dependencies="expac -l '\n' %E -S '$2' | sort -u"
alias lightdm='dm-tool switch-to-greeter'




#For Fun
alias noti='notify-send -i /usr/share/icons/manjaro-i3.png "Manjaro!!"'
alias acuarium='asciiquarium'
alias tt='tt'

### Aliases ###

export LESS=-R
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

#for man
man() {
  LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

###-tns-completion-start-###
if [ -f /home/brayanmb07/.tnsrc ]; then
  source /home/brayanmb07/.tnsrc
fi
###-tns-completion-end-###

export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'
