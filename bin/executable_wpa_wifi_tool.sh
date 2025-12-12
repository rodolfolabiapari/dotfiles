#!/bin/bash

# Verificar se o script está sendo executado como root
if [ "$EUID" -ne 0 ]; then
  echo "ERRO: Por favor, execute como root (sudo)."
  exit 1
fi

# Variável global para a interface selecionada
INTERFACE=""

# Função para listar todas as interfaces de rede do sistema
list_all_interfaces() {
    echo "-----------------------------------"
    echo "   INTERFACES DE REDE DETECTADAS   "
    echo "-----------------------------------"
    # Exibe nome, estado e endereço MAC de forma limpa
    ip -br link show
    echo "-----------------------------------"
}

# Função para selecionar a interface de trabalho
select_interface() {
    list_all_interfaces
    read -p "Digite o nome da interface WiFi (ex: wlan0): " SELECTED
    
    # Verifica se a interface existe no sistema
    if ip link show "$SELECTED" > /dev/null 2>&1; then
        INTERFACE=$SELECTED
        echo "Interface '$INTERFACE' selecionada."
    else
        echo "Interface inválida. Tente novamente."
        select_interface
    fi
}

show_menu() {
    echo ""
    echo "==================================="
    echo "   GERENCIADOR WIFI [ $INTERFACE ]"
    echo "==================================="
    echo "1) Listar redes salvas"
    echo "2) Escanear redes próximas (Scan)"
    echo "3) Conectar a uma rede salva (por ID)"
    echo "4) Adicionar e conectar a NOVA rede"
    echo "5) Desconectar"
    echo "6) Remover rede salva (por ID)" # Nova opção
    echo "7) Trocar Interface"
    echo "8) Sair"
    echo "==================================="
    read -p "Escolha uma opção: " OPT
}

list_saved() {
    echo "--- Redes configuradas no wpa_supplicant ---"
    wpa_cli -i "$INTERFACE" list_networks
}

scan_networks() {
    echo "Escaneando redes... aguarde."
    wpa_cli -i "$INTERFACE" scan > /dev/null
    sleep 2
    echo "--- Redes Encontradas ---"
    wpa_cli -i "$INTERFACE" scan_results | awk -F'\t' 'NR>1 {print "BSSID: "$1" | Sinal: "$3" | SSID: "$5}'
}

connect_saved() {
    list_saved
    read -p "Digite o ID da rede que deseja ativar: " NET_ID
    wpa_cli -i "$INTERFACE" select_network "$NET_ID"
    echo "Comando de conexão enviado."
}

add_new() {
    read -p "SSID (Nome da rede): " SSID
    read -sp "Senha: " PASS
    echo ""
    
    ID=$(wpa_cli -i "$INTERFACE" add_network | tail -n 1)
    
    wpa_cli -i "$INTERFACE" set_network "$ID" ssid "\"$SSID\""
    wpa_cli -i "$INTERFACE" set_network "$ID" psk "\"$PASS\""
    wpa_cli -i "$INTERFACE" enable_network "$ID"
    wpa_cli -i "$INTERFACE" save_config
    echo "Rede '$SSID' configurada com sucesso no ID $ID."
}

disconnect() {
    wpa_cli -i "$INTERFACE" disconnect
    echo "Interface $INTERFACE desconectada."
}

remove_network() {
    list_saved
    read -p "Digite o ID da rede que deseja REMOVER permanentemente: " REMOVE_ID
    
    # Confirmação antes de remover
    read -p "Tem certeza que deseja remover o ID $REMOVE_ID? (S/N): " CONFIRM
    
    if [[ "$CONFIRM" =~ ^[Ss]$ ]]; then
        wpa_cli -i "$INTERFACE" remove_network "$REMOVE_ID"
        wpa_cli -i "$INTERFACE" save_config
        echo "Rede com ID $REMOVE_ID removida da configuração e salva."
    else
        echo "Remoção cancelada."
    fi
}

# Inicialização do script
select_interface

while true; do
    show_menu
    case $OPT in
        1) list_saved ;;
        2) scan_networks ;;
        3) connect_saved ;;
        4) add_new ;;
        5) disconnect ;;
        6) select_interface ;;
        7) exit 0 ;;
        *) echo "Opção inválida." ;;
    esac
done
