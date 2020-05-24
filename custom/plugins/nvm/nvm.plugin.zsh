# NVM, lazy loaded
#
# Dependence:
# * plugin confirm

nvm() {
    export NVM_DIR="$HOME/.nvm"
    if [ -s "$NVM_DIR/nvm.sh" ]; then
        unset -f nvm
        source "$NVM_DIR/nvm.sh"
        source "$NVM_DIR/bash_completion"
        nvm $@ # call real function
    else
        confirm "NVM is not installed, do you want to install?" && \
        mkdir -p "$NVM_DIR" && \
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
    fi
}

nvm_find_up() {
  local path_
  path_="${PWD}"
  while [ "${path_}" != "" ] && [ ! -f "${path_}/${1-}" ]; do
    path_=${path_%/*}
  done
  echo "${path_}"
}

nvm_find_nvmrc() {
  local dir
  dir="$(nvm_find_up '.nvmrc')"
  if [ -e "${dir}/.nvmrc" ]; then
    echo "${dir}/.nvmrc"
  fi
}

load-nvmrc() {
  if [ -e "$HOME/.nvm/nvm.sh" ]; then
    # NVM is installed
    if [ -n "$(nvm_find_nvmrc)" ]; then
      # Found nvmrc, load NVM and use this version
      nvm use --silent
    fi
  else
    # NVM is not installed
    if [ -e ".nvmrc" ]; then
      # Promote to install this version
      echo "Current folder requires node version \"$(cat .nvmrc)\". But NVM is not installed."
    fi
  fi
}

autoload -U add-zsh-hook
add-zsh-hook chpwd load-nvmrc
load-nvmrc
