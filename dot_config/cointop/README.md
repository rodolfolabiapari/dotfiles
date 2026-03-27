# Crypt

## Symetric

```bash
gpg --version # 2.4.4

# crypting with symetric
# --armor: ASCII output
# --symetric: 
gpg --armor --symmetric config.toml

# decrypt
gpg -d config.toml
```

## Assymetric

```bash
# crypting with assymetric
gpg --armor --encrypt --recipient ${KEY_ADDRESS} config.toml

gpg --decrypt config.toml.gpg --output config.toml
```
