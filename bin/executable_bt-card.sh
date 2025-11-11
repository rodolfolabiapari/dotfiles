#!/usr/bin/env zsh

CARD_NAME=$(pactl list cards | grep -o 'bluez_card\.[0-9A-F_]*')

if [[ -z "$CARD_NAME" ]]; then
  echo "Nenhum card bluetooth conectado"
  exit 1
fi

case $1 in
  music|a2dp)
    PROFILE="a2dp_sink_sbc"
    echo "Mudando para modo Música (A2DP)"
    ;;
  call|hfp)
    PROFILE="headset_head_unit"
    echo "Mudando para modo Chamada (hands free HFP)"
    ;;
  off)
    PROFILE="off"
    echo "Desligando o perifl"
    ;;
  *)
    echo "Uso: $(basename $0) <music|call|off>"
    echo "\nPerfis disponíveis para o card $CARD_NAME:"
    pactl list cards | grep -A5 "$CARD_NAME" | grep -oP '\s+\K\w+:\s.*'
    exit 1
    ;;
esac

echo pactl set-card-profile "$CARD_NAME" "$PROFILE"

if [[ $? -eq 0 ]]; then
  echo "$PROFILE alterado com sucesso."
else
  echo "Falha ao alterar o profile para $PROFILE"
fi

