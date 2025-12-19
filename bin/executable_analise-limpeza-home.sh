#!/bin/bash

# ==============================================================================
# SCRIPT: analise_limpeza.sh
# FUNÇÃO: Analisa o uso de disco em um sistema Linux (especialmente Mint/Debian)
#         e gera um relatório inteligente de potenciais otimizações de espaço.
# OBJETIVO: Listar lixo residual (cache, dependências órfãs) e pacotes instalados
#           via APT, Snap, Flatpak e Brew para ação manual subsequente.
# ==============================================================================

# Define a cor para cabeçalhos
VERMELHO='\033[0;31m'
VERDE='\033[0;32m'
AZUL='\033[0;34m'
ROXO='\033[0;35m'
NORMAL='\033[0m'

# Log de início
echo -e "${AZUL}=====================================================${NORMAL}"
echo -e "${AZUL}== Relatório de Análise e Otimização de Espaço (Linux) ==${NORMAL}"
echo -e "${AZUL}=====================================================${NORMAL}"
echo -e "Data de Execução: $(date)"
echo " "

# --- 1. Resumo do Uso do Disco ---
echo -e "${VERDE}### 1. Resumo Geral de Uso do Disco${NORMAL}"
df -h / | grep /
echo " "

# --- 2. Análise de Cache e Resíduos (APT/DPKG) ---
echo -e "${VERDE}### 2. Análise de Cache APT (Pacotes Baixados)${NORMAL}"
CACHE_SIZE=$(du -sh /var/cache/apt/archives | awk '{print $1}')
echo "Tamanho Atual do Cache APT: ${CACHE_SIZE}"
echo "Sugestão de Limpeza: 'sudo apt clean' pode liberar este espaço (são pacotes que já foram instalados e podem ser re-baixados se necessário)."
echo " "

echo -e "${VERDE}### 3. Pacotes APT Órfãos (Para Remoção Segura)${NORMAL}"
# Lista pacotes instalados como dependências, mas que não são mais necessários por nenhum outro pacote.
ORPHAN_PKGS=$(apt autoremove --simulate 2>/dev/null | grep 'Remv ' | awk '{print $2}')

if [ -z "$ORPHAN_PKGS" ]; then
    echo "Nenhum pacote órfão (residual) detectado."
else
    echo "Os seguintes pacotes podem ser removidos com 'sudo apt autoremove':"
    echo -e "${ROXO}-------------------------------------${NORMAL}"
    echo "$ORPHAN_PKGS"
    echo -e "${ROXO}-------------------------------------${NORMAL}"
fi
echo " "

# --- 4. Análise de Pacotes Alternativos (Snap, Flatpak, Brew) ---
echo -e "${VERDE}### 4. Análise de Pacotes Alternativos (Snap, Flatpak, Brew)${NORMAL}"

# 4.1. SNAP - Identificação de Versões Antigas
if command -v snap &> /dev/null; then
    echo -e "${VERMELHO}--- SNAP (Sistemas de Containers)${NORMAL}"
    # Lista todos os snaps instalados, focando em versões antigas que podem ser removidas.
    snap list | grep disabled
    echo "Pacotes SNAP desabilitados listados acima. Verifique também versões inativas com 'snap list --all'."
    echo "A remoção de versões antigas exige um script de iteração (ex: 'snap set system refresh.retain=2')."
    echo " "
else
    echo "Gerenciador SNAP não encontrado ou não utilizado."
fi

# 4.2. FLATPAK - Lista de Aplicações e Runtimes Não Utilizados
if command -v flatpak &> /dev/null; then
    echo -e "${VERMELHO}--- FLATPAK (Sistemas de Containers)${NORMAL}"
    echo "Runtimes FLATPAK não utilizados (candidatos à remoção com 'flatpak uninstall --unused'):"
    flatpak uninstall --unused --columns=Application,Runtime,Size -y --dry-run 2>/dev/null | tail -n +2
    echo " "
    echo "Sugestão: Revise os pacotes instalados com 'flatpak list' para remover aplicativos não usados."
    echo " "
else
    echo "Gerenciador FLATPAK não encontrado ou não utilizado."
fi

# 4.3. HOMEBREW (Se Instalado)
if command -v brew &> /dev/null; then
    echo -e "${VERMELHO}--- HOMEBREW (Pacotes não Nativos)${NORMAL}"
    echo "Pacotes/Fórmulas Brew instalados (candidatos à remoção com 'brew autoremove' ou 'brew cleanup'):"
    brew list -1
    echo "Sugestão: Execute 'brew cleanup' para remover versões antigas e 'brew autoremove' para dependências órfãs."
    echo " "
else
    echo "Gerenciador Homebrew (brew) não encontrado ou não utilizado."
fi


# --- 5. Análise de Arquivos Grandes no Diretório HOME ---
echo -e "${VERDE}### 5. Análise de Arquivos Grandes e Diretórios Pesados (${HOME})${NORMAL}"
echo " "

# 5.1. Listagem dos 10 Maiores Diretórios no HOME
echo -e "${ROXO}--- 10 Maiores Diretórios em ${HOME} ---${NORMAL}"
# -x: Permanece no mesmo filesystem (não segue montagens externas)
# -d 1: Profundidade 1 (somente subdiretórios de HOME)
# | sort -nr: Ordena numericamente, em ordem reversa (do maior para o menor)
# | head -n 10: Limita aos 10 primeiros
sudo du -h -x --max-depth=1 ${HOME} 2>/dev/null | sort -hr | head -n 10
echo " "

# 5.2. Arquivos Grandes (Ex: Logs, ISOs, Backups)
echo -e "${ROXO}--- Arquivos com mais de 100MB no HOME (Para Revisão) ---${NORMAL}"
# -size +100M: Procura arquivos maiores que 100 Megabytes
# -type f: Somente arquivos (não diretórios)
# -exec ls -lh {} \; | awk '{print $5 "\t" $9}' : Formata para mostrar tamanho e nome
find ${HOME} -type f -size +100M -exec du -h {} \; 2>/dev/null | sort -hr | head -n 10
echo " "

# --- 6. Conclusão e Próximas Ações ---
echo -e "${AZUL}=====================================================${NORMAL}"
echo -e "${AZUL}== Próximas Ações Sugeridas (Manual) ==================${NORMAL}"
echo -e "${AZUL}=====================================================${NORMAL}"
echo "1. Analise a Seção 3 e execute: ${VERDE}sudo apt autoremove${NORMAL} e ${VERDE}sudo apt clean${NORMAL}."
echo "2. Analise a Seção 4 e execute: ${VERDE}flatpak uninstall --unused${NORMAL} (se aplicável)."
echo "3. Revise as listagens na Seção 5 para identificar e remover arquivos de backup, ISOs, VMs ou logs grandes não utilizados no seu diretório HOME."
echo "4. Use ${VERDE}sudo deborphan${NORMAL} (após instalação) para análise mais profunda de bibliotecas órfãs, se necessário."
echo " "

# Fim do script
