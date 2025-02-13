#!/bin/bash

# Script para configurar o teclado para US Internacional no Linux
# Ele faz a alteração de forma TEMPORÁRIA e PERMANENTE

# Verifica se o usuário tem permissão de root
if [[ $EUID -ne 0 ]]; then
    echo "Este script precisa ser executado como root."
    exit 1
fi

echo "Alterando teclado para US Internacional..."

# Aplicação temporária (imediata)
setxkbmap -layout us -variant intl
echo "Teclado alterado temporariamente."

# Configuração permanente no arquivo /etc/default/keyboard
if [[ -f /etc/default/keyboard ]]; then
    sed -i 's/^XKBLAYOUT=.*/XKBLAYOUT="us"/' /etc/default/keyboard
    sed -i 's/^XKBVARIANT=.*/XKBVARIANT="intl"/' /etc/default/keyboard
    echo "Configuração salva no arquivo /etc/default/keyboard."
fi

# Aplicação da configuração no systemd (se disponível)
if command -v localectl &> /dev/null; then
    localectl set-x11-keymap us intl
    echo "Configuração aplicada via localectl."
fi

echo "Reinicie o computador para que a mudança permanente tenha efeito."

exit 0

