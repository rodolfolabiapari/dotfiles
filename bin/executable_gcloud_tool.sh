#!/bin/bash

# Verificar se gcloud está instalado
if ! command -v gcloud &> /dev/null; then
    echo "ERRO: gcloud CLI não encontrado. Instale o Google Cloud SDK."
    exit 1
fi

show_menu() {
    echo ""
    echo "==================================="
    echo "   GCLOUD PROFILE MANAGER          "
    echo "==================================="
    echo "Configuração Ativa:"
    gcloud config configurations list --filter="IS_ACTIVE=true" --format="value(name)" | sed 's/^/  >> /'
    echo "-----------------------------------"
    echo "1) Listar todos os perfis (configs)"
    echo "2) Criar novo perfil"
    echo "3) Trocar perfil ativo"
    echo "4) Definir Projeto no perfil atual"
    echo "5) Definir Conta (E-mail) no perfil atual"
    echo "6) Excluir um perfil"
    echo "7) Ver detalhes da config atual"
    echo "8) Sair"
    echo "==================================="
    read -p "Escolha uma opção: " OPT
}

list_configs() {
    echo "--- Perfis Disponíveis ---"
    gcloud config configurations list
}

create_config() {
    read -p "Digite o nome para o novo perfil (ex: empresa-producao): " NAME
    gcloud config configurations create "$NAME"
    echo "Perfil $NAME criado e ativado."
    
    read -p "Deseja fazer login agora? (s/n): " LOGIN
    if [[ "$LOGIN" =~ ^[Ss]$ ]]; then
        gcloud auth login
    fi
}

switch_config() {
    list_configs
    read -p "Digite o nome do perfil para ativar: " NAME
    gcloud config configurations activate "$NAME"
}

set_project() {
    echo "--- Seus Projetos Disponíveis ---"
    gcloud projects list --limit=10
    read -p "Digite o ID do projeto: " PROJ_ID
    gcloud config set project "$PROJ_ID"
}

set_account() {
    read -p "Digite o e-mail da conta: " EMAIL
    gcloud config set account "$EMAIL"
}

delete_config() {
    list_configs
    read -p "Digite o nome do perfil para EXCLUIR: " NAME
    gcloud config configurations delete "$NAME"
}

show_details() {
    echo "--- Detalhes do Perfil Atual ---"
    gcloud config list
}

while true; do
    show_menu
    case $OPT in
        1) list_configs ;;
        2) create_config ;;
        3) switch_config ;;
        4) set_project ;;
        5) set_account ;;
        6) delete_config ;;
        7) show_details ;;
        8) exit 0 ;;
        *) echo "Opção inválida." ;;
    esac
done
