#!/usr/bin/env bash
config="$(dirname "$0")/init.lua"
if [[ ! -e "$config" ]]; then
  cp -v "$config.tpl" "$config"
fi
nvim --clean "+source $config" "$@"
