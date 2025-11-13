#!/usr/bin/env bash

# Usar o source para funconar esse script pois ele possui exports
# usar então com `source ~/bin/setProfile.sh`

if [ -z "$AWS_SESSION_TOKEN" ]; then
    echo "ERRO: As variáveis AWS não foram encontradas. Você está no sub-shell do 'aws-vault exec'?"
    exit 1
fi

mkdir -p "$HOME/.aws"
cat <<EOF > "$HOME/.aws/credentials"
[default]
aws_access_key_id=${AWS_ACCESS_KEY_ID}
aws_credential_expiration=${AWS_CREDENTIAL_EXPIRATION}
aws_default_region=${AWS_DEFAULT_REGION}
aws_region=${AWS_REGION}
aws_secret_access_key=${AWS_SECRET_ACCESS_KEY}
aws_session_token=${AWS_SESSION_TOKEN}
aws_vault=${AWS_VAULT}
EOF

export AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
export AWS_CREDENTIAL_EXPIRATION="$AWS_CREDENTIAL_EXPIRATION"
export AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION}
export AWS_REGION=${AWS_REGION}
export AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
export AWS_SESSION_TOKEN=${AWS_SESSION_TOKEN}
export AWS_VAULT=${AWS_VAULT}

if command -v tmux &> /dev/null && [ -n "$TMUX" ]; then

    tmux setenv AWS_ACCESS_KEY_ID "$AWS_ACCESS_KEY_ID"
    tmux setenv AWS_CREDENTIAL_EXPIRATION "$AWS_CREDENTIAL_EXPIRATION"
    tmux setenv AWS_SECRET_ACCESS_KEY "$AWS_SECRET_ACCESS_KEY"
    tmux setenv AWS_SESSION_TOKEN "$AWS_SESSION_TOKEN"
    tmux setenv AWS_VAULT "$AWS_VAULT"

    if [ -n "$AWS_REGION" ]; then
        tmux setenv AWS_DEFAULT_REGION "${AWS_DEFAULT_REGION}"
        tmux setenv AWS_REGION "${AWS_REGION}"
    fi
else
    echo "⚠️ Não está em uma sessão tmux. Credenciais salvas apenas no arquivo ~/.aws/credentials."
fi
