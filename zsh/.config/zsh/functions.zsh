##########################
###  Simple functions  ###
##########################

# Copy current directory into clipboard
copydir() {
  DIR=$(pwd)
  echo "Copied current directory into clipboard: $DIR"; pwd | xclip -selection clipboard
}

# Copy file content into clipboard
copyfile() {
  echo "Copied file content into clipboard: $1"; cat $1 | xclip -selection clipboard
}

# Change directories and view the contents
cl() {
    DIR="$*";
        # if no DIR given, go home
        if [ $# -lt 1 ]; then
                DIR=$HOME;
    fi;
    builtin cd "${DIR}" && \
    # use your preferred ls command
        ls -F --color=auto
}

# Print each PATH entry on a separate line
path() {
  echo "${PATH//:/$'\n'}"
}

##############################
###  Functions using curl  ###
##############################

# Upload and share formatted code file
sharecode() {
    file="$1"
    (cat "$1" | curl -F 'f:1=<-' ix.io) | sed "s/$/\/${file##*.}/" | xclip -selection clipboard;
}

# Upload and share text file
sharetxt() {
    (cat "$1" | curl -F 'f:1=<-' ix.io) | xclip -selection clipboard;
}

# Upload and transfer all types of file (max 5gb)
transfer() {
    if [ $# -eq 0 ];then echo "No arguments specified.\nUsage:\n transfer <file|directory>\n ... | transfer <file_name>">&2;return 1;fi;if tty -s;then file="$1";file_name=$(basename "$file");if [ ! -e "$file" ];then echo "$file: No such file or directory">&2;return 1;fi;if [ -d "$file" ];then file_name="$file_name.zip" ,;(cd "$file"&&zip -r -q - .)|curl --progress-bar --upload-file "-" "https://transfer.sh/$file_name"|tee /dev/null,;else cat "$file"|curl --progress-bar --upload-file "-" "https://transfer.sh/$file_name"|tee /dev/null;fi;else file_name=$1;curl --progress-bar --upload-file "-" "https://transfer.sh/$file_name"|tee /dev/null;fi;
}

# Cheat.sh
ch() {
    curl cht.sh/$1
}

# Test internet speed
speedtest() {
    curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -;
}

# Expand a shortened url
expand() {
    curl -sIL "$1" | grep -i ^location;
}

# Create a qr code
qrcode() {
    curl qrenco.de/"$1";
}

# Get the current weather
weather() {
    curl https://v2.wttr.in/"$1";
}

# Get random numbers
random() {
    curl "https://www.random.org/integers/?num=${1:-1}&min=${2:-1}&max=${3:-100}&col=1&base=10&format=plain&rnd=new"
}

# Extract all links from a page
alllinks() {
  curl -s "https://api.hackertarget.com/pagelinks/?q=$1"
}

# Safer rm
trash() {
  echo "[x] moving files to trash..."
  mv "$@" "$HOME/.trash"
}