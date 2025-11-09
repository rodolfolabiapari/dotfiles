function sleep_with_countdown() {

  # Help message
  local help_message="Usage: sleep_with_countdown <duration>

  Sleeps for the specified duration while displaying a countdown.

  Arguments:
    <duration>      Duration in seconds to sleep for. Must be a positive integer.

  Options:
    -h, --help      Show this help message and exit."

  # Check if -h or --help option is provided
  if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    echo "$help_message"
    return 0
  fi

  # Check if an argument is provided
  if [[ $# -ne 1 ]]; then
    echo "Usage: sleep_with_countdown <duration>"
    return 1
  fi

  # Check if the argument is a positive integer
  if ! [[ $1 =~ ^[0-9]+$ ]] || [[ $1 -le 0 ]]; then
    echo "Duration must be a positive integer"
    return 1
  fi

  local duration=$1
  local countdown=$1

  # Start the countdown
  printf "\rCounting down: %3d seconds left (0%%)" $countdown

  # The do-while loop
  while true; do
    # Wait for one second
    sleep 1

    # Update the countdown value
    ((countdown--))

    # Calculate the percentage
    local percent=$((100 - countdown * 100 / duration))

    # Print the countdown progress
    printf "\rCounting down: %3d seconds left (%d%%)" $countdown $percent

    # Check if the countdown reaches zero
    if [[ $countdown -eq 0 ]]; then
      echo
      break
    fi
  done
}
