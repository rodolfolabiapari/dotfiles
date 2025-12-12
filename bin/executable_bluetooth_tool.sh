#!/bin/bash

# Verificar se o bluetoothctl está instalado
if ! command -v bluetoothctl &> /dev/null; then
    echo "ERRO: bluetoothctl não encontrado. Instale o pacote bluez."
    exit 1
fi

# Variável global para o controlador selecionado
CONTROLLER=""

list_controllers() {
    echo "-----------------------------------"
    echo "   CONTROLADORES DISPONÍVEIS       "
    echo "-----------------------------------"
    bluetoothctl list
    echo "-----------------------------------"
}

select_controller() {
    list_controllers
    read -p "Digite o endereço MAC do controlador (ou aperte Enter para o padrão): " MAC
    if [ -z "$MAC" ]; then
        CONTROLLER=$(bluetoothctl list | grep "Default" | awk '{print $2}')
        # Se não houver um padrão marcado, pega o primeiro da lista
        [ -z "$CONTROLLER" ] && CONTROLLER=$(bluetoothctl list | head -n 1 | awk '{print $2}')
    else
        CONTROLLER=$MAC
    fi
    echo "Controlador selecionado: $CONTROLLER"
    bluetoothctl select "$CONTROLLER"
    bluetoothctl power on
}

show_menu() {
    echo ""
    echo "==================================="
    echo "   GERENCIADOR BLUETOOTH [ $CONTROLLER ]"
    echo "==================================="
    echo "1) Listar dispositivos pareados"
    echo "2) Escanear novos dispositivos"
    echo "3) Parear e Conectar novo dispositivo"
    echo "4) Conectar a dispositivo já pareado"
    echo "5) Desconectar dispositivo"
    echo "6) Remover/Desparear dispositivo"
    echo "7) Trocar Controlador"
    echo "8) Sair"
    echo "==================================="
    read -p "Escolha uma opção: " OPT
}

list_paired() {
    echo "--- Dispositivos Pareados ---"
    bluetoothctl paired-devices
}

scan_devices() {
    echo "Escaneando por 10 segundos... aguarde."
    # Inicia o scan em background, espera e desliga
    bluetoothctl scan on &
    SCAN_PID=$!
    sleep 10
    kill $SCAN_PID
    bluetoothctl scan off
    echo "--- Dispositivos Encontrados ---"
    bluetoothctl devices
}

pair_new() {
    bluetoothctl devices
    read -p "Digite o MAC do dispositivo para parear: " BT_MAC
    echo "Tentando parear, confiar e conectar..."
    bluetoothctl agent on
    bluetoothctl default-agent
    bluetoothctl pair "$BT_MAC"
    bluetoothctl trust "$BT_MAC"
    bluetoothctl connect "$BT_MAC"
}

connect_paired() {
    list_paired
    read -p "Digite o MAC do dispositivo para conectar: " BT_MAC
    bluetoothctl connect "$BT_MAC"
}

disconnect_bt() {
    read -p "Digite o MAC do dispositivo para desconectar: " BT_MAC
    bluetoothctl disconnect "$BT_MAC"
}

remove_bt() {
    list_paired
    read -p "Digite o MAC do dispositivo para REMOVER: " BT_MAC
    bluetoothctl remove "$BT_MAC"
    echo "Dispositivo removido."
}

# Inicialização
select_controller

while true; do
    show_menu
    case $OPT in
        1) list_paired ;;
        2) scan_devices ;;
        3) pair_new ;;
        4) connect_paired ;;
        5) disconnect_bt ;;
        6) remove_bt ;;
        7) select_controller ;;
        8) exit 0 ;;
        *) echo "Opção inválida." ;;
    esac
done
