#!/usr/bin/env bash

if [ -z "$AWS_SESSION_TOKEN" ]; then
    echo "ERRO: As variáveis AWS não foram encontradas. Você está no sub-shell do 'aws-vault exec'?"
    exit 1
fi

mkdir -p "$HOME/.aws"
cat <<EOF > "$HOME/.aws/credentials"
[default]
aws_session_token=${AWS_SESSION_TOKEN}
aws_secret_access_key=${AWS_SECRET_ACCESS_KEY}
aws_access_key_id=${AWS_ACCESS_KEY_ID}
aws_credential_expiration=${AWS_CREDENTIAL_EXPIRATION}
aws_vault=${AWS_VAULT}
eOF

if command -v tmux &> /dev/null && [ -n "$TMUX" ]; then

    tmux setenv AWS_ACCESS_KEY_ID "$AWS_ACCESS_KEY_ID"
    tmux setenv AWS_SECRET_ACCESS_KEY "$AWS_SECRET_ACCESS_KEY"
    tmux setenv AWS_SESSION_TOKEN "$AWS_SESSION_TOKEN"
    tmux setenv AWS_CREDENTIAL_EXPIRATION "$AWS_CREDENTIAL_EXPIRATION"
    tmux setenv AWS_VAULT "$AWS_VAULT"

    if [ -n "$AWS_REGION" ]; then
        tmux setenv AWS_DEFAULT_REGION "$AWS_DEFAULT_REGION"
        tmux setenv AWS_REGION "$AWS_REGION"
    fi
else
    echo "⚠️ Não está em uma sessão tmux. Credenciais salvas apenas no arquivo ~/.aws/credentials."
fi
