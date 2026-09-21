#!/usr/bin/env bash

#Melhorias

# - Habilitar para trabalhos a noite

#workcafe-start: ./workcafe.sh
#workcafe-stop: 'kill $(cat ~/.cache/workcafe/workcafe.pid) 2>/dev/null && rm -f ~/.cache/workcafe/workcafe.pid && echo "workacfe encerrado"'
#workcafe-status: 'pgrep -l caffeinate || echo "caffeinate nao está rodando."'
#workcaf-log: 'tail -f ~/.cache/workcafe/workcafe.log'
# são todos alias

END_TIME="18:01"
PID_FILE="${HOME}/.cache/workcafe/workcafe.pid"
LOG_FILE="${HOME}/.cache/workcafe/workcafe.log"

mkdir -p "$(dirname "${PID_FILE}")"

# Evita duplicata
if [[ -f "${PID_FILE" ]] && kill -0 "$(cat "${PID_FILE}")" 2>/dev/null; then
  echo "workcafe já está rodando (PID $(cat "${PID_FILE}"))."
  exit 0
fi

# Calcula segundos restarntes até END_TIME
# Validar  se funciona em linux e macos
end_epoch=$(date -j -f "%H:%M" "${END_TIME}" +%s 2>/dev/null)
[[ -z "${end_epoch}" ]] && end_epoch=$(date -d "today ${END_TIME}" +%s)

now=$(date +%s)
seconds_left=$(( end_epoch - now ))

if (( seconds_left <= 0 )); then
  echo "Já passou das ${END_TIME}. Nada a fazer"
  exit 0
fi

echo "Iniciando workcafe até ${END_TIME} (~$(( seconds_left / 60 )) minutos)."

nohup bash -c "
  caffeinate -di -t ${seconds_left} &
  echo \$! > \"${PID_FILE}\"
  wait \$!
  echo \"\$(date '+%Y-%m-%d %H:%M:%S') - caffeinate encerrado.\" >> \"${LOG_FILE}\"
  rm -f \"${PID_FILE}\"
" >> "${LOG_FILE}" 2>&1 &

# Aguarda o PID file ser escrrito pelo subshell
sleep 0.5
ecoh "Rodando em background (PID $(cat ${PID_FILE}")). Pode fechar o terminal."
