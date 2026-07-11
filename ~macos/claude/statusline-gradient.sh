#!/bin/bash

# Read JSON input
input=$(cat)

# Extract data
cwd=$(echo "$input" | jq -r '.workspace.current_dir')
model_name=$(echo "$input" | jq -r '.model.display_name')
usage=$(echo "$input" | jq '.context_window.current_usage')
total_in=$(echo "$input" | jq -r '.context_window.total_input_tokens // 0')
total_out=$(echo "$input" | jq -r '.context_window.total_output_tokens // 0')

# ── Truecolor helper ──
rgb() { printf '\033[38;2;%d;%d;%dm' "$1" "$2" "$3"; }

# Get repo name
repo_name=$(basename "$cwd")

# Get git branch (skip optional locks)
branch=""
if git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
    branch=$(git -C "$cwd" -c core.filesRefLockTimeout=0 -c core.packedRefsTimeout=0 rev-parse --abbrev-ref HEAD 2>/dev/null || echo "")
fi

# Calculate context percentage and get usage emoji
pct=0
usage_emoji=$'\xf0\x9f\xdf\xa2'  # 🟢
pct_color="\033[38;2;0;200;80m"  # green

if [ "$usage" != "null" ]; then
    current=$(echo "$usage" | jq '.input_tokens + .cache_creation_input_tokens + .cache_read_input_tokens')
    size=$(echo "$input" | jq '.context_window.context_window_size')
    pct=$((current * 100 / size))
    
# Set emoji and color based on percentage
    if [ $pct -lt 20 ]; then
        usage_emoji=$'\xf0\x9f\xdf\xa2'  # 🟢
        pct_color="\033[38;2;0;200;80m"  # green
    elif [ $pct -lt 70 ]; then
        usage_emoji=$'\xe2\x9a\xa1\xef\xb8\x8f' # ⚡️ 
        pct_color="\033[38;2;220;200;0m"  # yellow
    elif [ $pct -lt 90 ]; then
        usage_emoji=$'\xf0\x9f\x94\xa5'  # 🔥
        pct_color="\033[38;2;255;140;0m"  # orange
    else
        usage_emoji=$'\xf0\x9f\x9a\xa8'  # 🚨
        pct_color="\033[38;2;220;40;20m"  # red
    fi
fi

# Calculate session cost (rough estimate: $3/1M input, $15/1M output)
cost_input=$(echo "scale=4; $total_in / 1000000 * 3" | bc)
cost_output=$(echo "scale=4; $total_out / 1000000 * 15" | bc)
total_cost=$(echo "scale=3; $cost_input + $cost_output" | bc)

# Get code velocity (lines changed in git)
added=0
removed=0
if git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
    diff_stats=$(git -C "$cwd" -c core.filesRefLockTimeout=0 -c core.packedRefsTimeout=0 diff --numstat 2>/dev/null)
    if [ -n "$diff_stats" ]; then
        added=$(echo "$diff_stats" | awk '{sum+=$1} END {print sum+0}')
        removed=$(echo "$diff_stats" | awk '{sum+=$2} END {print sum+0}')
    fi
fi

# Generate 20-block RGB gradient context bar
blocks=""
filled_blocks=$((pct * 20 / 100))
empty_blocks=$((20 - filled_blocks))

for i in $(seq 1 20); do
    if [ $i -le $filled_blocks ]; then
        # Calculate RGB gradient from green(0,200,80) -> yellow(220,200,0) -> red(220,40,20)
        if [ $i -le 10 ]; then
            # First half: green to yellow
            ratio=$(((i - 1) * 100 / 10))
            r=$((0 + ratio * 220 / 100))
            g=200
            b=$((80 - ratio * 80 / 100))
        else
            # Second half: yellow to red
            ratio=$(((i - 11) * 100 / 10))
            r=220
            g=$((200 - ratio * 160 / 100))
            b=$((0 + ratio * 20 / 100))
        fi
        blocks="${blocks}\033[38;2;${r};${g};${b}m█"
    else
        # Dark gray empty blocks
        blocks="${blocks}\033[38;2;60;60;60m█"
    fi
done

# Color codes
BOLD_YELLOW="\033[1;38;2;255;215;0m"
BOLD_CYAN="\033[1;38;2;0;200;200m"
GREEN='\033[32m'
YELLOW='\033[33m'
RED='\033[31m'
MAGENTA='\033[35m'
DIM_GRAY="\033[38;2;100;100;100m"
RESET="\033[0m"

# Build status line
printf "📁 ${BOLD_YELLOW}${repo_name}${RESET}"

if [ -n "$branch" ]; then
    printf "${DIM_GRAY}${RESET} 🌿 ${BOLD_CYAN}${branch}${RESET}"
fi

printf " ${DIM_GRAY}|${RESET} 🤖 ${MAGENTA}${model_name}${RESET}"
# printf " ${DIM_GRAY}|${RESET} ${YELLOW}\$${total_cost}${RESET}"
printf " ${DIM_GRAY}|${RESET} 🔁 ${GREEN}+${added}${RESET} ${RED}-${removed}${RESET}"
printf " ${DIM_GRAY}|${RESET} ${usage_emoji} ${blocks}${RESET}"
printf " ${DIM_GRAY}${RESET}${pct_color}${pct}%%${RESET}"

echo ""
