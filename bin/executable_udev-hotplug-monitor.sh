#!/usr/bin/env bash

# Script utilizado pelo udev
#  realiza reload automático do i3 quando é conectado ou desconectado algo do HDMI

# sobre o udev:
#  para ver o udev funcionando, execute o comando e deixe funcionando
#   sudo udevadm monitor
#  Connect o hdmi. Deve aparecer logs de change. Isso é importante para configurar
#  o card do udev
#
#  Precisa ser criado uma regra do udev no arquivo:
#   /etc/udev/rules.d/95-hotplug-monitor.rules
#  com o conteúdo:
#   SUBSYSTEM=="drm", ACTION=="change", KERNEL=="card1", RUN+="/home/iay/bin/udev-hotplug-monitor.sh"
#  o conteúdo do Kernel deve ser a saída do que foi visto no sudo udevadm monitor
#  e depois deve-se recarregar o udev
#   sudo udevadm control --reload-rules

XAUTHORITY_PATH="/home/iay/.Xauthority"
export DISPLAY=":0"
export XAUTHORITY="$XAUTHORITY_PATH"

LOG_FILE="/tmp/udev-hotplug-monitor_debug.log"
echo "--- $(date) ---" >> $LOG_FILE

# Teste de Conexão: Simplesmente tenta aplicar o xrandr (com rate 60)
# 2>&1 | tee -a $LOG_FILE redireciona a saída e erro para o log

if /usr/bin/xrandr | grep "HDMI-1-1 connected" > /dev/null 2>&1; then
    echo "HDMI CONECTADO." >> $LOG_FILE
    /usr/bin/xrandr --output eDP-1-1 --mode 1920x1080 --pos 0x0 \
                    --output HDMI-1-1 --mode 1920x1080 --rate 60 --pos 1920x0 2>&1 | tee -a $LOG_FILE
    /usr/bin/i3-msg restart 2>&1 | tee -a $LOG_FILE
else
    echo "HDMI DESCONECTADO. Desligando HDMI-1-1..." >> $LOG_FILE
    /usr/bin/xrandr --output HDMI-1-1 --off 2>&1 | tee -a $LOG_FILE
    /usr/bin/i3-msg restart 2>&1 | tee -a $LOG_FILE
fi

echo "Fim do Script." >> $LOG_FILE

