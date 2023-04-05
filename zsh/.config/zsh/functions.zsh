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

# Safer rm
trash() {
  echo "[x] moving files to trash..."
  mv "$@" "$HOME/.trash"
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

# Cheat.sh
ch() {
  unset query
  selected=$(cat ~/.tmux-cht-languages ~/.tmux-cht-command | fzf)
  if [[ -z $selected ]]; then
      exit 0
  fi

  vared -p "Enter Query: " -c query

  if grep -qs "$selected" ~/.tmux-cht-languages; then
      query=$(echo "$query" | tr ' ' '+')
      curl -s cht.sh/$selected/$query
  else
      curl -s cht.sh/$selected~$query
  fi
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

###############
###  Other  ###
###############

# Go up [n] directories
up() {
  local cdir="$(pwd)"
  if [[ "${1}" == "" ]]; then
      cdir="$(dirname "${cdir}")"
  elif ! [[ "${1}" =~ ^[0-9]+$ ]]; then
      echo "Error: argument must be a number"
  elif ! [[ "${1}" -gt "0" ]]; then
      echo "Error: argument must be positive"
  else
      for ((i=0; i<${1}; i++)); do
          local ncdir="$(dirname "${cdir}")"
          if [[ "${cdir}" == "${ncdir}" ]]; then
              echo "Error: reached root directory"
              break
          else
              cdir="${ncdir}"
          fi
      done
  fi
  cd "${cdir}"
}


p () {
  num_hosts=$1
  program=$2
  program_args=("$@")

  scp "$program" vmCalculParallelegrp1-0:/partage/arhun.saday &&
  ssh vmCalculParallelegrp1-0 "
    mpicc -march=native /partage/arhun.saday/$(basename "$program") -o /partage/arhun.saday/$(basename "$program".out) &&
    mpirun -hostfile /partage/hosts -n $num_hosts /partage/arhun.saday/$(basename "$program".out) ${program_args[@]} &&
    rm /partage/arhun.saday/$(basename "$program".out)
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

  ssh vmCalculParallelegrp1-0 "rm -rf /partage/${name}/${dossier}"
  scp -r ${chemin}/${dossier} vmCalculParallelegrp1-0:/partage/${name}/

  ssh -t vmCalculParallelegrp1-0 "
    cd /partage/${name}/${dossier} &&
    cleanup() {
      rm -rf /partage/${name}/${dossier}
    }
    trap cleanup EXIT
    bash -i
  "
}

tp() {
  local chemin="$(pwd)"
  local dossier="tp-note"
  local identifiant='asaday'
  local name='arhun.saday'

  ssh vmCalculParallelegrp1-0 "rm -rf /partage/${name}/${dossier}"
  scp -r ${chemin} vmCalculParallelegrp1-0:/partage/${name}/${dossier}

  ssh -t vmCalculParallelegrp1-0 "
    cd /partage/${name}/${dossier} &&
    cleanup() {
      rm -rf /partage/${name}/${dossier}
    }
    trap cleanup EXIT
    bash -i
  "
}

sharefile() {
  file="$1"
  url=$(curl --upload-file "$file" https://transfer.sh/"${file##*/}")
  echo "$url" | xclip -selection clipboard
}
