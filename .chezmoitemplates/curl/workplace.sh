# -*-mode:sh-*-

set -e

# Create temp dir to download files
mkdir -p /tmp/beans
cd /tmp/beans

# Install bat
echo "Downloading Bat"
BAT="bat-v0.24.0-x86_64-unknown-linux-gnu"
curl -OL "https://github.com/sharkdp/bat/releases/download/v0.24.0/${BAT}.tar.gz"

# Extract a single file from tar.gz
tar -zxf ${BAT}.tar.gz ${BAT}/bat

chmod +x ${BAT}/bat

rm -f ${HOME}/bin/bat
mv ${BAT}/bat $HOME/bin/


# Install Node20
# https://nodejs.org/dist/v20.12.2/node-v20.12.2-linux-x64.tar.xz
echo "Downloading Node@20.12.2"
NODE="node-v20.12.2-linux-x64"
curl -OL "https://nodejs.org/dist/v20.12.2/node-v20.12.2-linux-x64.tar.xz"

tar -xf ${NODE}.tar.xz

rm -rf ${HOME}/bin/${NODE}
rm -f ${HOME}/bin/node
rm -f ${HOME}/bin/npm
rm -f ${HOME}/bin/npx

mv ${NODE} ${HOME}/bin/${NODE}

ln -s ${HOME}/bin/node-v20.12.2-linux-x64/bin/node ${HOME}/bin/node
ln -s ${HOME}/bin/node-v20.12.2-linux-x64/bin/npm  ${HOME}/bin/npm
ln -s ${HOME}/bin/node-v20.12.2-linux-x64/bin/npx  ${HOME}/bin/npx


# Installing git-delta
# https://github.com/dandavison/delta/releases/download/0.17.0/delta-0.17.0-x86_64-unknown-linux-gnu.tar.gz
echo "Downloading git-delta"
DELTA="delta-0.17.0-x86_64-unknown-linux-gnu"
curl -OL "https://github.com/dandavison/delta/releases/download/0.17.0/delta-0.17.0-x86_64-unknown-linux-gnu.tar.gz"

# Extract a single file from tar.gz
tar -zxf ${DELTA}.tar.gz ${DELTA}/delta

chmod +x ${DELTA}/delta

rm -f ${HOME}/bin/delta
mv ${DELTA}/delta $HOME/bin/


rm -rf /tmp/beans

