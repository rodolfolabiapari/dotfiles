# Enable history substitution, etc.
set -o history
set -o histexpand

# Bash options
shopt -s histappend # Append history rather than overwriting
shopt -s histverify # Show command before executing if it's a history substitution
shopt -s autocd     # Automatically cd to a directory if it's the only argument
shopt -s cdspell    # Correct minor errors in directory names when using cd
