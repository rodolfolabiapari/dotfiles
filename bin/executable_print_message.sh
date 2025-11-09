# Function to print messages in bold and with different colors
function print_message() {
  local color="$1"
  shift

  # Help message
  local help_message="Usage: $color [OPTIONS] <message>

  Prints a message in bold and with $color text.

  Arguments:
    <message>      Message to be printed.

  Options:
    -h, --help     Show this help message and exit.
    -n             Do not append a newline character at the end of the message.
    -e             Enable interpretation of backslash escapes."

  local newline_flag=""
  local escape_flag=""

  # Parse options
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -h|--help)
        echo "$help_message"
        return 0
        ;;
      -n)
        newline_flag="-n"
        ;;
      -e)
        escape_flag="-e"
        ;;
      *)
        break
        ;;
    esac
    shift
  done

  # Check if an argument is provided
  if [[ $# -ne 1 ]]; then
    echo "Usage: $color [OPTIONS] <message>"
    return 1
  fi

  # Print the message with the specified color
  echo $newline_flag $escape_flag "\033[1;$color"m"$1\033[0m"
}

# Function to print success messages in bold and green
function print_success() {
  print_message "32" "$@"
}

# Function to print status messages in bold and white
function print_status() {
  print_message "37" "$@"
}

# Function to print alert messages in bold and yellow
function print_alert() {
  print_message "33" "$@"
}

# Function to print error messages in bold and red
function print_error() {
  print_message "31" "$@"
}
