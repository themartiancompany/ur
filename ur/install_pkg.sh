#!/usr/bin/env bash
#
# SPDX-License-Identifier: AGPL-3.0-or-later

set -e -u
shopt -s extglob

# Set application name from the script's file name
app_name="${0##*/}"
# Show a WARNING message
# $1: message string

_msg_warning() {
    local _msg="${1}"
    printf '[%s] WARNING: %s\n' "${app_name}" "${_msg}" >&2
}

# Show an ERROR message then exit with status
# $1: message string
# $2: exit code number (with 0 does not exit)
_msg_error() {
    local _msg="${1}"
    local _error=${2}
    printf '[%s] ERROR: %s\n' "${app_name}" "${_msg}" >&2
    if (( _error > 0 )); then
        exit "${_error}"
    fi
}

# Sets object string attributes
# $1: object
# $2: an object string attribute
# $3: a value
_set() {
    local _obj="${1}" \
          _var="${2}" \
          _value="${3}" \
          _type
    [[ "${_type}" == "declare -A "* ]] && \
      
    printf -v "${_obj}_${_var}" \
              "${_value}"
}

# Returns an attribute value for a 
# given object
# $1: an object
# $2: an object attribute
_get() {
    local _obj="${1}" \
          _var="${2}" \
          _msg \
          _ref \
          _type
    _ref="${_image}_${_var}[@]"
    _type="$(declare -p "${_ref}")"
    [[ "${_type}" == *"declare: "*": not found" ]] && \
      _msg=(
        "Attribute '${_var}' is not defined"
        "for object '${_obj}'") && \
      _msg_error "${_msg[*]}" 1
    [[ "${_type}" == "declare -A "* ]] && \
      echo "${_image[${_var}]}" && \
      return
    printf "%s\n" "${!_ref}"
}

_global_variables() {
    file_list=""
    pacman_conf=""
    repo_name=""
    repo_publisher=""
    install_dir=""
    work_dir=""
    gpg_key=""
    gpg_sender=""
    gpg_home=""
    quiet=""
}

install_pkg() {
  local _packages_extra="${1}" \
	_repo_name="${2}" \
        _server="${3}" \
        _pacman_conf="${4}"
  local _awk_split_cmd=() \
	_build_repo \
	_build_repo_cmds=() \
	_build_repo_options=() \
	_build_repo_cmd \
	_ci_bin \
	_conflict \
	_conflicts=() \
	_conflicts_line \
	_gen_pacman_conf \
	_home \
        _packages=() \
	_pacman_conf \
	_pacman_opts=() \
	_pkg \
	_repo \
        _setup_repo_msg \
        _setup_user \
        _src \
        _src_profile \
        _user="user"
  [[ "${_repo_name}" == "" ]] && \
    _repo_name="ur"
  [[ "${_server}" == "" ]] && \
    _server="/tmp/ur/${repo_name}"
  _build_repo_options=(
    'src'
    'packages.extra'
    "${_server}"
  )
  _awk_split_cmd=('{split($0,pkgs," ");'
	          'for (pkg in pkgs)'
		    '{ print pkgs[pkg] } }')
  _home="/home/${_user}"
  _profile="${_home}/${profile}"
  _pacman_conf="${_profile}/pacman.conf"
  _pacman_opts+=(--config "${_pacman_conf}")
  _src="$(pwd)"
  _ci_bin="${_src}/.gitlab/ci"
  _src_profile="${_src}/configs/${profile}"
  _packages_extra="${_src_profile}/packages.extra"
  _build_repo="${_ci_bin}/build_repo.sh"
  _setup_user="${_ci_bin}/setup_user.sh"
  _gen_pacman_conf="${_ci_bin}/set_custom_repo.sh"
  [ -e "${_build_repo}" ] || \
    _build_repo="mkarchisorepo"
  [ -e "${_gen_pacman_conf}" ] || \
    _gen_pacman_conf="mkarchisosetrepo"
  [ -e "${_setup_user}" ] || \
    _setup_user="mkarchisorepobuilder"
  _build_repo_cmds=(
    "cd ${_profile}"
    "${_build_repo} ${_build_repo_options[*]}")
  _build_repo_cmd="$(IFS=";" ; \
                     echo "${_build_repo_cmds[*]}")"
  [ -e "${_packages_extra}" ] && \
    #shellcheck disable=SC1090
    source "${_packages_extra}"
  if [[ "${_packages[*]}" != "" ]] ; then
    sh -c "${_build_repo_cmd}"
    "${_gen_pacman_conf}" "${repo_name}" \
                          "${_server}" \
      		          "${_src_profile}/pacman.conf" \
      		          "${_pacman_conf}"
    pacman "${_pacman_opts[@]}" -Sy
    for _pkg in "${_packages[@]}"; do
      echo "Removing conflicts for ${_pkg}"
      _conflicts_line="$(pacman "${_pacman_opts[@]}" \
	                        -Si "${_pkg}" \
	                   | grep Conflicts)"
      _conflicts=(
        $(echo ${_conflicts_line##*:} | \
	    awk "${_awk_split_cmd[*]}"))
      for _conflict in "${_conflicts[@]}"; do
	echo "Removing '${_conflict}'"
        pacman -Rdd "${_conflict}" \
		--noconfirm || true
      done
    done
    echo "Installing ${_packages[@]}"
    pacman "${_pacman_opts[@]}" \
	    -Sdd "${_packages[@]}" \
	    --noconfirm
  fi
}

_set_override() {
    local _obj="${1}" \
          _var="${2}" \
          _default="${3}"
    if [[ -v "override_${_obj}_${_var}" ]]; then
        _set "${_obj}" \
             "${_var}" \
             "$(_get "override_${obj}" \
                     "${_var}")"
    elif [[ -z "$(_get "${_obj}" \
                       "${_var}")" ]]; then
        _set "${_obj}" \
             "${_var}" \
             "${_value}"
    fi
}

_override_path() {
    local _obj="${1}" \
          _var="${2}" \
          _value="${3}"
    _set_override "${_obj}" \
                  "${_var}" \
                  "${_value}"
    _set "${_obj}" \
         "${_var}" \
         "$(realpath -- "$(_get "${_obj}" \
                                "${_var}")")"
}

_set_overrides() {
  
}

while getopts 'f:C:L:P:D:w:g:G:H:vh?' arg; do
    case "${arg}" in
        f) override_file_list="${OPTARG}" ;;
        C) override_pacman_conf="${OPTARG}" ;;
        L) override_repo_name="${OPTARG}" ;;
        P) override_repo_publisher="${OPTARG}" ;;
        D) override_install_dir="${OPTARG}" ;;
        w) override_work_dir="${OPTARG}" ;;
        g) override_gpg_key="${OPTARG}" ;;
        G) override_gpg_sender="${OPTARG}" ;;
        H) override_gpg_home="${OPTARG}" ;;
        v) override_quiet="n" ;;
        h|?) _usage 0 ;;
        *)
            _msg_error "Invalid argument '${arg}'" 0
            _usage 1
            ;;
    esac
done

shift $((OPTIND - 1))

if (( $# < 1 )); then
    _msg_error "No package specified" 0
    _usage 1
fi

if (( EUID != 0 )); then
    _msg_error "${app_name} must be run as root." 1
fi

_packages_extra=("${@}")
_set_overrides
_install_pkg ""
