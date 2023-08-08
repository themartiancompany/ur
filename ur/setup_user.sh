#!/usr/bin/env bash

_setup_user() {
  local _user="${1}"
  local _home="/home/${_user}"
  useradd "${_user}"
  mkdir -p "${_home}"
  chown -R "${_user}" "${_home}"
  chmod 700 "${_home}"
}

_user="${1}"

_setup_user "${_user}"
