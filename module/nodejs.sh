#!/bin/bash

set -e 

if [[ -z $format_output ]]; then
	source ./include/format_output.sh
fi

info "installing the latest NVM..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash

info "checking the shell type..."
if [ -n "$SHELL" ]; then
  case "$SHELL" in
    */zsh)
      SHELL_RC="$HOME/.zshrc"
      ;;
    */bash)
      SHELL_RC="$HOME/.bashrc"
      ;;
    *)
      SHELL_RC="$HOME/.profile"
      ;;
  esac
else
  SHELL_RC="$HOME/.profile"
fi

info "configuring the NVM env vars..."
if ! grep -q 'export NVM_DIR' "$SHELL_RC"; then
	echo -e "\n# NVM configuration" >> "$SHELL_RC"
	echo 'export NVM_DIR="$HOME/.nvm"' >> "$SHELL_RC"
	echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> "$SHELL_RC"
	echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' >> "$SHELL_RC"
fi

export NVM_DIR="$HOME/.nvm"

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

info "installing the latest Node.js..."
nvm install --lts

info "set the default Node.js as the latest LTS."
nvm alias default 'lts/*'

echo "the Node.js and npm version..."
node -v
npm -v

info "please run source $SHELL_RC..."


