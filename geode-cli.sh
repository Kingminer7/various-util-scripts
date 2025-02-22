#!/bin/bash

version=$(curl -s https://api.github.com/repos/geode-sdk/cli/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')
version=${version#v}
wget "https://github.com/geode-sdk/cli/releases/download/v${version}/geode-cli-v${version}-linux.zip"
if [ $? -ne 0 ]; then
    echo "Failed to download Geode CLI"
    exit 1
fi
BIN_DIR="${HOME}/.local/bin"
mkdir -p "${BIN_DIR}" # just gotta make sure lmao
unzip "geode-cli-v${version}-linux.zip"
rm -rf "geode-cli-v${version}-linux.zip"
chmod +x "geode"
mv geode "${BIN_DIR}/"
if ! grep -q "${BIN_DIR}" <<< "$PATH"; then
    echo "export PATH=\"\$PATH:${BIN_DIR}\"" >> "${HOME}/.profile"
    source "${HOME}/.profile"
fi
if [ -x "${BIN_DIR}/geode" ]; then
    echo "Geode CLI successfully installed to ${BIN_DIR}"
else
    echo "Failed to install Geode CLI"
    exit 1
fi
