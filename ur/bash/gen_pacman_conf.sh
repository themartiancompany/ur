#!/usr/bin/env bash

_gen_pacman_conf() {
  local _repo_name="${1}"
  local _server="${2}"
  local _pacman_conf="${3}"
  local _out_conf="${4}"
  _repo=(
    "[${_repo_name}]"
    "SigLevel = Optional TrustAll"
    "Server = file://${_server}")
  if ! grep -q "\[${_repo_name}\]" \
	       "${_pacman_conf}"; then
    cp -a "${_pacman_conf}" \
	  "${_out_conf}"
    for _line in "${_repo[@]}"; do
        sed -i \
	    "/\[core\]/i ${_line}" \
	    "${_out_conf}"
    done
  fi
}

profile="${1}"
server="${2}"
pacman_conf="${3}"
out_conf="${4}"

if [[ $# -eq 0 ]]; then
  echo "args: <profile name> <server> <pacman.conf> <out file>"
  exit 0
fi

_args=(
  "${profile}"
  "${server}"
  "${pacman_conf}"
  "${out_conf}")

_gen_pacman_conf "${_args[@]}"
