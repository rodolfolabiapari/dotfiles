#!/bin/bash

# Executa o caffeinate em background
caffeinate -di &

# Armazena o PID do processo
CaffeinatePID=$!

# Define o horário para cancelar (em segundos, 17h em relação a 00h)
# gdate pois estou usando o brew coreutils para ter produtos gnu no macock
CancelAt=$(gdate -d '18:05' +%s)
Now=$(date +%s)

# Calcular o tempo até o cancelamento
SleepTime=$((CancelAt - Now))

# Verifica se o horário para cancelamento já passou
if [ $SleepTime -gt 0 ]; then
  sleep $SleepTime
  kill $CaffeinatePID

  echo "Caffeinate cancelado às 18:05h."
  echo ""
  echo "Colocando o sistema para dormir"

  # Não necessita de root
  osascript -e 'tell application "System Events" to sleep'
else
  echo "O horário para cancelamento já passou."
fi

