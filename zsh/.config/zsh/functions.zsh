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

###############
###  Other  ###
###############
sshmpirun () {
  num_hosts=$1
  shift
  program=$1
  shift
  program_args=("$@")

  scp "$program" asaday@turing.u-strasbg.fr:~ &&
  ssh asaday@turing.u-strasbg.fr "
    mpicc -march=native $(basename "$program") -o $(basename "$program".out) &&
    scp $(basename "$program".out) vmCalculParallelegrp1-0:/partage/arhun.saday &&
    ssh vmCalculParallelegrp1-0 '
      cd /partage/arhun.saday &&
      mpirun -hostfile /partage/hosts -n $num_hosts ./$(basename "$program".out) ${program_args[@]} &&
      rm $(basename "$program".out)
    ' &&
    rm ~/$(basename "$program").out ~/$(basename "$program")
  "
}

killport () {
  local port=$1
  local pid=$(lsof -t -i :$port)
  if [ -n "$pid" ]; then
      kill -9 $pid
      echo "Killed process with PID $pid that was using port $port"
  else
      echo "No process found listening on port $port"
  fi
}

copilot() {
  eval "$(github-copilot-cli alias -- "$0")"
}

pp() {
  local chemin="$HOME/depots"
  local dossier='projet-pp-2223'
  local identifiant='asaday'
  local name='arhun.saday'

  ssh ${identifiant}@turing.u-strasbg.fr "rm -rf ~/projet-pp-2223"
  scp -r ${chemin}/${dossier} ${identifiant}@turing.u-strasbg.fr:~

  ssh -t ${identifiant}@turing.u-strasbg.fr "
    scp -r ${dossier} vmCalculParallelegrp1-0:/partage/${name}/ &&
    ssh -t vmCalculParallelegrp1-0 '
      cd /partage/${name}/${dossier} &&
      cleanup() {
        rm -rf /partage/${name}/${dossier}
      }
      trap cleanup EXIT
      bash -i
    '
  "
}

ft() {
  if [[ $# -eq 1 ]]; then
    selected=$1
  else
    selected=$(find ~/depots/ ~/repos ~/ -mindepth 1 -maxdepth 1 -type d | fzf)
  fi

if [[ -z $selected ]]; then
    exit 0
  fi

  selected_name=$(basename "$selected" | tr . _)
  tmux_running=$(pgrep tmux)

  if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s $selected_name -c $selected
    exit 0
  fi

  if [[ -z $tmux_running ]]; then
    tmux new-session -s $selected_name -c $selected
  else
    if ! tmux has-session -t=$selected_name 2> /dev/null; then
      tmux new-session -ds $selected_name -c $selected
    fi

    tmux switch-client -t $selected_name
  fi
}

cht() {
  languages=`echo "js rust python c ts" | tr ' ' '\n'`
  core_utils=`echo "xargs find" | tr ' ' '\n'`

  selected=`printf "$languages\n$core_utils" | fzf`
  printf "Enter query: "
  read query

  if printf $languages | grep -qs $selected; then
    curl cht.sh/$selected/`echo $query | tr ' ' '+'`
  else
    curl cht.sh/$selected~$query | less
  fi

}