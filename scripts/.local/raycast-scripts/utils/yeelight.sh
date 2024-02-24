ip="192.168.1.20"

# Function to send the command to the Yeelight device
fn_send() {
    # Redirecting echo to /dev/null to suppress output
    echo "Executing on [$ip] ... " $@ >/dev/null
    if ping -c1 -W1 $ip >/dev/null; then
        # Directly writing to the device without printing to stdout
        printf "{\"id\":1,$2}\r\n" >/dev/tcp/$ip/55443
    else
        # Redirecting error message to stderr or suppress it
        echo "$ip not available" >&2
    fi
}

fn_send $1
