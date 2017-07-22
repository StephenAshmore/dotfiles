#ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias sl='ls'

#safe rm:
#alias rm='rm --preserve-root'

#mkdir alias
alias mk='mkdir'

#Clear with an Echo Message
alias clear='echo -e "\n\n\n\n\n\n\n\n\nConsole Cleared.";clear;'

#Chrome alias:
alias chrome='google-chrome'

#time:
alias time='/usr/bin/time'

#Game Dev:
alias love='/Applications/love.app/Contents/MacOS/love'

#Misc:
alias top='top -d 2.0'
alias pdflatex='pdflatex -file-line-error -interaction nonstopmode'
alias findhere='find . -name '
alias df="df -Tha --total"
alias du="du -ach | sort -h"
alias ps="ps aux"
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"

alias myip="curl http://ipecho.net/plain; echo" #Get my IP

# Vagrant Specific Aliases for SupplyPike
alias vagrantup="cd ~/casestack/vm;vagrant up"
alias vagrantssh="cd ~/casestack/vm;vagrant ssh"
alias vagrantall="cd ~/casestack/vm;vagrant up;vagrant ssh"

# Activate Tensorflow:
alias tensorflow="source ~/tensorflow/bin/activate"

function svgforlatex() {
  if [ ! $# == 2 ]; then
    echo "Usage: svgforlatex filename.svg output.pdf"
  else
    inkscape -D -z --file=$1 --export-pdf=$2
  fi
}

# Make beep work in terminator:
alias beep="paplay /usr/share/sounds/KDE-Im-Low-Priority-Message.ogg --volume=125000"

# Ding Pomodoro Technique Alias:
# Requires Ding to be installled.
if [ -f ~/apps/ding/ding/ding.py ]
  then
    function ding() {
      if [ -z $@ ]; then
        echo "You must provide a time to ding, such as: in or at. Ex. in 5s, in 1h."
      else
        ~/apps/ding/ding/ding.py $@  -c "paplay /usr/share/sounds/KDE-Im-Low-Priority-Message.ogg --volume=125000"
      fi
    }
    function pomo() {
      ~/apps/ding/ding/ding.py in 25m  -c "paplay /usr/share/sounds/KDE-Im-Low-Priority-Message.ogg --volume=125000"
    }
fi

#Scatter plot alias:
if [ -f /usr/local/bin/waffles_plot ]
  then
    function scatter() {
      if [ ! $# == 2 ]; then
        echo "Usage: scatter <arff file> <out svg>"
        echo "Uses default size of 1920 by 1080."
        echo "If you want a different size, here's the command: waffles_plot scatter -size 1920 1080 row <arff file> 0 1 > <out svg>"
      else
        waffles_plot scatter -size 1920 1080 row $1 0 1 > $2
        chrome $2
      fi
    }
fi

#Check for existance of fooplot in usr/local/bin
[ -f /usr/local/bin/fooplot ] && alias plot='fooplot'

function extract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
 else
    if [ -f $1 ] ; then
        # NAME=${1%.*}
        # mkdir $NAME && cd $NAME
        case $1 in
          *.tar.bz2)   tar xvjf $1    ;;
          *.tar.gz)    tar xvzf $1    ;;
          *.tar.xz)    tar xvJf $1    ;;
          *.lzma)      unlzma $1      ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       unrar x -ad $1 ;;
          *.gz)        gunzip $1      ;;
          *.tar)       tar xvf $1     ;;
          *.tbz2)      tar xvjf $1    ;;
          *.tgz)       tar xvzf $1    ;;
          *.zip)       unzip $1       ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1        ;;
          *.xz)        unxz $1        ;;
          *.exe)       cabextract $1  ;;
          *)           echo "extract: '$1' - unknown archive method" ;;
        esac
    else
        echo "$1 - file does not exist"
    fi
fi
}

# Calculate Math from command line:
if [ -f /usr/bin/gcalccmd ]
  then
  function math() {
      calc="$@"
      if [ "$calc" = "help" ]; then
        echo "Usage: math <expression>"
        echo "Examples: math 2*2 or math 'ln(2)'"
        echo "Available Functions are: ln, sqrt, abs, int, frac, sin, cos, tan, asin, acos, atan, sinh, cosh, tanh, asinh, acosh, atanh, ones, twos."
      else
        # Uncomment the below for (p → +) and (x → *)
        #calc="${calc//p/+}"
        #calc="${calc//x/*}"
        echo -ne "$calc\n quit" | gcalccmd | sed 's:^> ::g'
      fi
  }
else
  function math() {
    echo "You need to install gnome-calculator in order to use this method."
  }
fi
