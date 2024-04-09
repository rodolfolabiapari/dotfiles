#!/bin/bash

# exit on error
set -e

brew_not_exists() {
  if [ -x "/usr/local/Homebrew/bin/brew" ]; then
    echo "O binario /usr/local/Homebrew/bin/brew existe no Intel."
    return 1
  elif [ -e "/opt/Homebrew/bin/brew" ]; then
    echo "O binario /opt/Homebrew/bin/brew existe no Arm."
    return 1
  else
    echo "O binário brew nao existe."
    return 0
  fi
  return 0
}

install_brew_on_mac() {
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

OS="$(uname -s)"
case "${OS}" in
    Linux*)
        if [ -f /etc/lsb-release ]; then
            echo "Linux"
            exit 1
        #    install_on_ubuntu
        #elif [ -f /etc/lsb-release ]; then
        #    install_on_rasp
        else
            echo "Unsupported Linux distribution"
            exit 1
        fi
        ;;
    Darwin*)
        if brew_not_exists ; then
          echo "Installing Brew."
          install_brew_on_mac
        else
          echo "Pulando instalacao Brew."
        fi
        ;;
    *)
        echo "Unsupported operating system: ${OS}"
        exit 1
        ;;
esac

echo "Check Brew installation complete."
