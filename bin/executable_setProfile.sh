#!/usr/bin/env bash

# ATENÇÃO: Para que isso funcione, você deve EXECUTAR o script com 'source'
# (ex: source meu_script.sh), e NÃO com './meu_script.sh'.
# criei um alias par isso chamado setProfileAws

mkdir -p "$HOME/.aws"

cat <<EOF > "$HOME/.aws/credentials"
[default]
aws_session_token=${AWS_SESSION_TOKEN}
aws_secret_access_key=${AWS_SECRET_ACCESS_KEY}
aws_access_key_id=${AWS_ACCESS_KEY_ID}
EOF


export AWS_SESSION_TOKEN=${AWS_SESSION_TOKEN}
export AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
export AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
export AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION}
export AWS_REGION=${AWS_REGION}

aws configure set default.region ${AWS_REGION}
