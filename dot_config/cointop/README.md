# Instrucoes


## Crypt

### Simétrico

Verifique a versão do gpg com

```bash
gpg --version
# Saída esperada 2.4.4 ou mais
```

Encriptando com chave simétrica (usando senha)

```bash
gpg --armor --symmetric config.toml
# --armor: ASCII output
# --symetric: pede password para encriptar
```

### Assimétrico

Para Assymetric utiliza-se o `--encrypt`.

```bash
# --armor: ASCII output
gpg --armor --encrypt --recipient ${KEY_ADDRESS} config.toml
```

## Para decriptar

Basta usar

```bash
gpg --decrypt config.toml.gpg --output config.toml
```

