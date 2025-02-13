#!/bin/bash

# Obtém o ID do dispositivo 'LIFT Mouse' automaticamente
device_id=$(xinput list | grep -i 'LIFT Mouse' | grep -o 'id=[0-9]*' | cut -d= -f2)

if [ -z "$device_id" ]; then
  echo "Erro: Dispositivo 'LIFT Mouse' não encontrado."
  exit 1
fi

# Habilita o natural scroll
property_id=$(xinput list-props "$device_id" | grep "libinput Natural Scrolling Enabled (" | grep -o '([0-9]*)' | tr -d '()')

if [ -z "$property_id" ]; then
  echo "Erro: Propriedade 'libinput Natural Scrolling Enabled' não encontrada."
  exit 1
fi

# Ativa o natural scroll
xinput set-prop "$device_id" "$property_id" 1

echo "Natural scroll habilitado para o dispositivo 'LIFT Mouse' (ID: $device_id)"

