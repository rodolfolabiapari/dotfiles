#!/usr/bin/env bash

# Define o diretório alvo (usa o atual se nenhum for passado)
DIRETORIO_ALVO="${1:-.}"

echo "========================================================"
echo "🔍 Analisando diretórios Terraform e Terragrunt em:"
echo "   -> $DIRETORIO_ALVO"
echo "========================================================"

# Cria arquivos temporários para listar o que foi encontrado
LISTA_TERRAFORM=$(mktemp)
LISTA_TERRAGRUNT=$(mktemp)

# Busca pastas .terraform (ignorando subdiretórios dentro delas)
find "$DIRETORIO_ALVO" -type d -name ".terraform" -prune > "$LISTA_TERRAFORM"

# Busca pastas .terragrunt-cache (ignorando subdiretórios dentro delas)
find "$DIRETORIO_ALVO" -type d -name ".terragrunt-cache" -prune > "$LISTA_TERRAGRUNT"

QTD_TF=$(wc -l < "$LISTA_TERRAFORM")
QTD_TG=$(wc -l < "$LISTA_TERRAGRUNT")

if [ "$QTD_TF" -eq 0 ] && [ "$QTD_TG" -eq 0 ]; then
    echo "✅ Nenhum cache encontrado. Seu disco está limpo!"
    rm "$LISTA_TERRAFORM" "$LISTA_TERRAGRUNT"
    exit 0
fi

echo "📦 Encontrado:"
echo "   - $QTD_TF pastas '.terraform'"
echo "   - $QTD_TG pastas '.terragrunt-cache'"
echo ""

# Calcula o tamanho total (pode demorar um pouco dependendo do disco)
echo "⏳ Calculando espaço que será liberado (aguarde)..."
du -shc $(cat "$LISTA_TERRAFORM" "$LISTA_TERRAGRUNT") 2>/dev/null | tail -n1 | awk '{print "   -> Tamanho Total: " $1}'

echo "========================================================"
echo "⚠️  ATENÇÃO: Isso apagará os binários de providers e módulos baixados."
echo "   Você terá que rodar 'terraform init' ou 'terragrunt init' novamente."
echo "========================================================"
read -p "Deseja excluir essas pastas e liberar espaço? (s/N): " CONFIRMACAO

if [[ "$CONFIRMACAO" =~ ^[sS]$ ]]; then
    echo ""
    echo "🗑️  Apagando..."
    
    # Lê os arquivos linha por linha e apaga
    while IFS= read -r pasta; do
        rm -rf "$pasta"
        echo "   [OK] $pasta"
    done < "$LISTA_TERRAFORM"

    while IFS= read -r pasta; do
        rm -rf "$pasta"
        echo "   [OK] $pasta"
    done < "$LISTA_TERRAGRUNT"
    
    echo ""
    echo "✨ Limpeza concluída com sucesso!"
else
    echo "❌ Operação cancelada. Nada foi apagado."
fi

# Remove arquivos temporários
rm "$LISTA_TERRAFORM" "$LISTA_TERRAGRUNT"
