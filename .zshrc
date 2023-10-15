#Fix the Java Problem 
export _JAVA_AWT_WM_NONREPARENTING=1 
#Path to your oh-my-zsh installation.  
setxkbmap -option caps:swapescape
#export TERM=xterm-256color


export ZSH="/root/.oh-my-zsh" 
# Set name of the theme to load --- if set to "random", it will load a random theme each time oh-my-zsh is loaded, in which case, to know which specific one was loaded, run: echo $RANDOM_THEME See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes 
ZSH_THEME="cypher" 
#Use emacs keybindings even if our EDITOR is set to vi bindkey -e Vi mode
#bindkey -v
export KEYTIMEOUT=1

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit -i

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none
ZSH_HIGHLIGHT_STYLES[arg0]=fg=white,bold
#source /home/kafka/powerlevel10k/powerlevel10k.zsh-theme
#ZSH_AUTOSUGGEST_HISTORY_IGNORE=*

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
#[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# Manual configuration

PATH=/root/.local/bin:/snap/bin:/usr/sandbox/:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/usr/share/games:/usr/local/sbin:/usr/sbin:/sbin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games

# GO PATH
export PATH=$PATH:/usr/local/go/bin

# Manual aliases
alias ll='lsd -lh --group-dirs=first'
alias la='lsd -a --group-dirs=first'
alias l='lsd --group-dirs=first'
alias lla='lsd -lha --group-dirs=first'
#alias ls='lsd --group-dirs=first'
#alias cat='batcat'
alias catn='/usr/bin/cat'
alias vpn='/usr/sbin/openvpn >/dev/null'
alias copy='/usr/bin/xclip -i -sel p -rmlastnl -f | xclip -i -sel c -rmlastnl >/dev/null 2>&1'
alias up='python3 -m http.server 80'
alias vi='/usr/bin/nvim'
## sshutle || Ex: sshutle-all -r kali-jump
alias sshuttle-all="sshuttle 0/0 -x 46.19.37.133 -x 164.138.25.191 -x 93.108.233.203 --dns"
# ghidra
alias ghidra='/opt/ghidra/ghidra_10.2.3_PUBLIC/ghidraRun'
# cutter
alias cutter='/opt/reversing/Cutter-v2.2.0-Linux-x86_64.AppImage'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Plugins
plugins=(
	git
	sudo
)

source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
#source /usr/share/zsh-sudo/sudo.plugin.zsh
source $ZSH/oh-my-zsh.sh

# Functions
function mkt(){
	mkdir {enum,content,exploits,scripts}
}

# Extract nmap information
function extractPorts(){
	ports="$(cat $1 | grep -oP '\d{1,5}/open' | awk '{print $1}' FS='/' | xargs | tr ' ' ',')"
	ip_address="$(cat $1 | grep -oP '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}' | sort -u | head -n 1)"
	echo -e "\n[*] Extracting information...\n" > extractPorts.tmp
	echo -e "\t[*] IP Address: $ip_address"  >> extractPorts.tmp
	echo -e "\t[*] Open ports: $ports\n"  >> extractPorts.tmp
	echo $ports | tr -d '\n' | xclip -sel clip
	echo -e "[*] Ports copied to clipboard\n"  >> extractPorts.tmp
	cat extractPorts.tmp; rm extractPorts.tmp
}

# Set 'man' colors
function man() {
    env \
    LESS_TERMCAP_mb=$'\e[01;31m' \
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    man "$@"
}

# fzf improvement
function fzf-lovely(){

	if [ "$1" = "h" ]; then
		fzf -m --reverse --preview-window down:20 --preview '[[ $(file --mime {}) =~ binary ]] &&
 	                echo {} is a binary file ||
	                 (bat --style=numbers --color=always {} ||
	                  highlight -O ansi -l {} ||
	                  coderay {} ||
	                  rougify {} ||
	                  cat {}) 2> /dev/null | head -500'

	else
	        fzf -m --preview '[[ $(file --mime {}) =~ binary ]] &&
	                         echo {} is a binary file ||
	                         (bat --style=numbers --color=always {} ||
	                          highlight -O ansi -l {} ||
	                         coderay {} ||
	                          rougify {} ||
	                          cat {}) 2> /dev/null | head -500'
	fi
}

function rmk(){
	scrub -p dod $1
	shred -zun 10 -v $1
}

function cheat(){
  curl -ks cht.sh/$(curl -ks cht.sh/:list | fzf --preview 'curl -ks cht.sh/{}' -q "$*");
}

function target(){
	echo $1 > /tmp/target
	export target=$1
}

function nif(){
	curl -v "https://nif.marcosantos.me/?i=1" 2> /dev/null | grep -o "<h2 id=\"nif\">.*</h2>" | sed 's/\(<h2 id=\"nif\">\|<\/h2>\)//g'
}

function cc(){
	curl -v "https://cc.marcosantos.me/?i=1" 2> /dev/null | grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox} -o "<span class=\"number\">.*</span>" | egrep -o "\w+<\/span>" | tr -d "</span>" | tr "\n" " "
}

export PATH="$HOME/.poetry/bin:$PATH"


#####KEYCHAIN
#eval `keychain --eval id_rsa -q`
#####END

