#!/usr/bin/env bash
# gcpctl.sh - gerenciador de contextos gcloud (estilo kubectl/kubectx)
#
# Instalação:
#   mkdir -p ~/.local/share/gcpctl && cp gcpctl.sh ~/.local/share/gcpctl/
#   echo 'source ~/.local/share/gcpctl/gcpctl.sh' >> ~/.bashrc
#
# Requer bash 4+ e gcloud.

# ---------------------------------------------------------------- helpers ---

_gcpctl_cfgdir() { echo "${CLOUDSDK_CONFIG:-$HOME/.config/gcloud}"; }

# Nome do contexto ativo NESTE terminal (variável de ambiente tem prioridade)
_gcpctl_active() {
  echo "${CLOUDSDK_ACTIVE_CONFIG_NAME:-$(cat "$(_gcpctl_cfgdir)/active_config" 2>/dev/null || echo default)}"
}

# Lê o projeto direto do arquivo (rápido, sem chamar gcloud)
_gcpctl_project_fast() {
  awk -F' *= *' '$1=="project"{print $2}' \
    "$(_gcpctl_cfgdir)/configurations/config_$(_gcpctl_active)" 2>/dev/null
}

# Liga/desliga a flag de produção (usada pelo starship e pelo guard)
_gcpctl_refresh() {
  local p n; p=$(_gcpctl_project_fast); n=$(_gcpctl_active)
  p=${p,,}; n=${n,,}
  if [[ "$p" =~ (prd|prod) ]] || [[ "$n" =~ (prd|prod)$ ]]; then
    export GCPCTL_PROD="PRD"
  else
    unset GCPCTL_PROD
  fi
}

# Aponta o ADC para o arquivo específico do contexto, se existir
_gcpctl_adc_env() {
  local f; f="$(_gcpctl_cfgdir)/adc/$(_gcpctl_active).json"
  if [ -f "$f" ]; then
    export GOOGLE_APPLICATION_CREDENTIALS="$f"
  else
    unset GOOGLE_APPLICATION_CREDENTIALS
  fi
}

_gcpctl_exists() {
  command gcloud config configurations list --format="value(name)" 2>/dev/null | grep -qx "$1"
}

# --------------------------------------------------------------- comandos ---

_gcpctl_help() {
  cat <<'EOF'
gcpctl - gerenciador de contextos do gcloud

CONTEXTOS (cada um = conta + projeto)
  gcpctl ctx                 lista contextos (● = ativo neste terminal)
  gcpctl ctx <nome>          troca de contexto SÓ neste terminal
  gcpctl ctx -               volta ao contexto anterior
  gcpctl new <nome> <projeto> <email>
                             cria contexto completo e faz login
  gcpctl rm <nome>           exclui contexto

AJUSTES NO CONTEXTO ATUAL
  gcpctl project             lista projetos disponíveis
  gcpctl project <id>        define projeto
  gcpctl account <email>     define conta
  gcpctl whoami              mostra contexto, conta, projeto e ADC

AUTENTICAÇÃO
  gcpctl login               gcloud auth login (conta do contexto)
  gcpctl adc                 application-default login, salvo POR contexto
                             (usado por Terraform, SDKs, bibliotecas)

EXECUÇÃO PONTUAL (sem trocar de contexto)
  gcpctl run <ctx> -- <comando...>
    ex: gcpctl run empresa-prd -- gcloud filestore instances list

ATALHOS
  gcpctx [nome|-]            = gcpctl ctx [nome|-]

DICAS
  - A troca vale só para o terminal atual (CLOUDSDK_ACTIVE_CONFIG_NAME).
  - Contextos com "prd" ou "prod" no projeto ativam o selo PRD no prompt
    e pedem confirmação em comandos destrutivos (delete, update, create...).
  - Para desligar a confirmação: export GCPCTL_NOGUARD=1
EOF
}

_gcpctl_status() {
  local acc proj
  acc=$(command gcloud config get-value account 2>/dev/null)
  proj=$(command gcloud config get-value project 2>/dev/null)
  echo "contexto: $(_gcpctl_active)${GCPCTL_PROD:+  [PRODUÇÃO]}"
  echo "conta:    ${acc:-(não definida)}"
  echo "projeto:  ${proj:-(não definido)}"
  echo "adc:      ${GOOGLE_APPLICATION_CREDENTIALS:-(padrão global, pode ser de outro contexto!)}"
}

_gcpctl_ctx() {
  local cur; cur=$(_gcpctl_active)

  if [ -z "$1" ]; then
    printf '   %-22s %-32s %s\n' "CONTEXTO" "CONTA" "PROJETO"
    command gcloud config configurations list \
      --format="value(name,properties.core.account,properties.core.project)" |
      awk -F'\t' -v cur="$cur" \
        '{m=($1==cur)?"●":" "; printf " %s %-22s %-32s %s\n", m,$1,$2,$3}'
    return
  fi

  local name="$1"
  if [ "$name" = "-" ]; then
    name="${GCPCTL_PREV:-}"
    [ -z "$name" ] && { echo "Nenhum contexto anterior."; return 1; }
  fi

  if ! _gcpctl_exists "$name"; then
    echo "Contexto '$name' não existe. Veja: gcpctl ctx"
    return 1
  fi

  export GCPCTL_PREV="$cur"
  export CLOUDSDK_ACTIVE_CONFIG_NAME="$name"
  _gcpctl_adc_env
  _gcpctl_refresh
  _gcpctl_status
}

_gcpctl_new() {
  if [ $# -ne 3 ]; then
    echo "uso: gcpctl new <nome> <projeto-id> <email>"
    return 1
  fi
  local name="$1" proj="$2" email="$3"
  command gcloud config configurations create "$name" --no-activate || return 1
  command gcloud config set project "$proj" --configuration="$name"
  command gcloud config set account "$email" --configuration="$name"
  CLOUDSDK_ACTIVE_CONFIG_NAME="$name" command gcloud auth login "$email"
  _gcpctl_ctx "$name"
}

_gcpctl_rm() {
  [ -z "$1" ] && { echo "uso: gcpctl rm <nome>"; return 1; }
  if [ "$1" = "$(_gcpctl_active)" ]; then
    echo "'$1' está ativo neste terminal. Troque antes: gcpctl ctx <outro>"
    return 1
  fi
  command gcloud config configurations delete "$1"
  rm -f "$(_gcpctl_cfgdir)/adc/$1.json"
}

_gcpctl_project() {
  if [ -z "$1" ]; then
    command gcloud projects list --limit=50
    return
  fi
  command gcloud config set project "$1"
  _gcpctl_refresh
}

_gcpctl_account() {
  [ -z "$1" ] && { echo "uso: gcpctl account <email>"; return 1; }
  command gcloud config set account "$1"
}

_gcpctl_adc() {
  local name dir; name=$(_gcpctl_active); dir="$(_gcpctl_cfgdir)"
  mkdir -p "$dir/adc"
  command gcloud auth application-default login || return 1
  # O gcloud grava sempre no mesmo arquivo global; copiamos para o do contexto
  cp "$dir/application_default_credentials.json" "$dir/adc/$name.json" &&
    chmod 600 "$dir/adc/$name.json"
  _gcpctl_adc_env
  echo "ADC do contexto '$name' salvo em $dir/adc/$name.json"
}

_gcpctl_run() {
  local ctx="$1"; shift
  [ "$1" = "--" ] && shift
  if [ -z "$ctx" ] || [ $# -eq 0 ]; then
    echo "uso: gcpctl run <ctx> -- <comando...>"
    return 1
  fi
  _gcpctl_exists "$ctx" || { echo "Contexto '$ctx' não existe."; return 1; }
  (
    export CLOUDSDK_ACTIVE_CONFIG_NAME="$ctx"
    _gcpctl_adc_env
    _gcpctl_refresh
    "$@"
  )
}

# ------------------------------------------------------------ entrypoints ---

gcpctl() {
  local cmd="${1:-}"
  [ $# -gt 0 ] && shift
  case "$cmd" in
    ""|help|-h|--help) _gcpctl_help ;;
    ctx|use)           _gcpctl_ctx "$@" ;;
    new)               _gcpctl_new "$@" ;;
    rm|delete)         _gcpctl_rm "$@" ;;
    project|proj)      _gcpctl_project "$@" ;;
    account|acc)       _gcpctl_account "$@" ;;
    whoami|status|current) _gcpctl_status ;;
    login)             command gcloud auth login ;;
    adc)               _gcpctl_adc ;;
    run|exec)          _gcpctl_run "$@" ;;
    *) echo "Comando desconhecido: $cmd"; echo "Veja: gcpctl help"; return 1 ;;
  esac
}

gcpctx() { _gcpctl_ctx "$@"; }

# ------------------------------------------------------- guard de produção ---

gcloud() {
  if [ -n "$GCPCTL_PROD" ] && [ -z "$GCPCTL_NOGUARD" ] &&
     [[ "$*" =~ (^|[[:space:]])(delete|update|create|patch|resize|reset|stop|start|add-iam-policy-binding|remove-iam-policy-binding|set-iam-policy|deploy|import|restore)([[:space:]]|$) ]]; then
    local p; p=$(command gcloud config get-value project 2>/dev/null)
    echo "⚠️  PRODUÇÃO — contexto '$(_gcpctl_active)', projeto '$p'"
    echo "    gcloud $*"
    read -r -p "Continuar? (digite 'sim'): " r
    [ "$r" = "sim" ] || { echo "Cancelado."; return 1; }
  fi
  command gcloud "$@"
}

# ------------------------------------------------------------ autocomplete ---

_gcpctl_names() {
  command gcloud config configurations list --format="value(name)" 2>/dev/null
}

_gcpctl_complete() {
  local cur="${COMP_WORDS[COMP_CWORD]}" prev="${COMP_WORDS[COMP_CWORD-1]}"
  if [ "$COMP_CWORD" -eq 1 ]; then
    COMPREPLY=( $(compgen -W "ctx new rm project account whoami login adc run help" -- "$cur") )
  elif [ "$COMP_CWORD" -eq 2 ]; then
    case "$prev" in
      ctx|use|rm|delete|run|exec)
        COMPREPLY=( $(compgen -W "$(_gcpctl_names) -" -- "$cur") ) ;;
    esac
  fi
}
_gcpctx_complete() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  [ "$COMP_CWORD" -eq 1 ] && COMPREPLY=( $(compgen -W "$(_gcpctl_names) -" -- "$cur") )
}
complete -F _gcpctl_complete gcpctl
complete -F _gcpctx_complete gcpctx

# Ao abrir um terminal, calcula a flag PRD e o ADC do contexto atual
_gcpctl_refresh
_gcpctl_adc_env
