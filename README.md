# dotfiles

This repo contains the configuration to setup my machines. This is using [Chezmoi](https://chezmoi.io), the dotfile manager to setup the install.

This automated setup is currently only configured for Fedora machines.

## How to install these configs

Normal system use:

```shell
export GITHUB_USERNAME=rodolfolabiapari
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply $GITHUB_USERNAME
```

Raspberry Pi Model B Plus Rev 1.2 using Raspbian GNU/Linux 11 (bullseye) armv6l/armhf:

```shell
# Install go for armv6l
# https://go.dev/dl/
# I used go1.22.2.linux-armv6l.tar.gz

cd /tmp/
curl -OL https://go.dev/dl/go1.22.2.linux-armv6l.tar.gz

# Clean old go
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.22.2.linux-amd64.tar.gz

git clone https://github.com/twpayne/chezmoi.git
cd chezmoi
make install-from-git-working-copy
```

Containers:

```shell
# install in short-lived linux (containers)
# then remove all traces of chezmoi, including the source directory and 
# chezmoi’s configuration directory
export GITHUB_USERNAME=rodolfolabiapari
sh -c "$(curl -fsLS https://chezmoi.io/get)" -- init --one-shot $GITHUB_USERNAME
```

## See changes before apply

```shell
chezmoi git pull -- --rebase && chezmoi diff
```

## How to update afeter install

```shell
chezmoi -v update
```

## How apply configs made in local machine

```shell
# -v is verbose
# -n is dry run
chezmoi -vn apply
```

## Files that have different info over machines

Use `chezmoi add --template FILE_NAME` with `~/.config/chezmoi/chezmoi.toml` config for vars.

Use `chezmoi data` to see all variables available.
