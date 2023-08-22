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
    _ref="${_obj}_${_var}[@]"
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
    pkg_list=""
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
   _override_path "pkg" \
                  "list" \
		  "packages.extra"
   _override_path "pacman" \
                  "conf" \
		  "/etc/pacman.conf"
   _set_override "repo" \
	         "name" \
                 "${app_name}"
   _set_override "repo" \
	         "publisher" \
		 "${repo_name}"
   if [[ -v override_quiet ]]; then
     quiet="${override_quiet}"
   elif [[ -z "${quiet}" ]]; then
     quiet="y"
   fi
   [[ ! -v override_gpg_key ]] || \
     gpg_key="${override_gpg_key}"
   [[ ! -v override_gpg_sender ]] || \
     gpg_sender="${override_gpg_sender}"
   [[ ! -v override_gpg_home ]] || \
     gpg_home="${override_gpg_home}"
}

# Show help usage, with an exit status.
# $1: exit status number.
_usage() {
    IFS='' \
      read -r \
           -d '' \
           usage_text << \
             ENDUSAGETEXT || true
usage: $(_get "app" "name")} [options] [pkg(s)]
  options:
     -f <pkg_list>    Whether to inprerpret the argument as a path to a pkglist
		      Default: '$(_get "pkg" "list")'
     -C <file>        pacman configuration file.
		      Default: '$(_get "pacman" "conf")}'
     -D <install_dir> Set an install_dir. All files will by located here.
		      Default: '$(_get "install" "dir")'
                      NOTE: Max 8 characters, use only [a-z0-9]
     -L <repo_name>   Set an alternative repository name
		      Default: '$(_get "repo" "name")'
     -P <publisher>   Set the ISO publisher
		      Default: '$(_get "repo" "publisher")}'
     -c [cert ..]     Provide certificates for codesigning of the HTTP server for
                      the repository.
                      Multiple files are provided as quoted, space delimited list.
                      The first file is considered as the signing certificate,
                      the second as the key.
     -g <gpg_key>     Set the PGP key ID to be used to generate the repository.
                      Passed to gpg as the value for --default-key
     -G <mbox>        Set the PGP signer (must include an email address)
                      Passed to gpg as the value for --sender
     -H <gpg_home>    Set the gpg home directory.
     -h               This message
     -o <out_dir>     Set the output directory
		      Default: '$(_get "out" "dir")'
     -v               Enable verbose output
     -w <work_dir>    Set the working directory (can't be a bind mount).
		      Default: '$(_get "work" "dir")}'

  [package ..]  Package(s) to install.
                Multiple packages are provided as quoted, space delimited list.
ENDUSAGETEXT
    printf '%s' "$(_get "usage" "text")"
    exit "${1}"
}

while getopts 'f:C:L:P:w:g:G:H:vh?' arg; do
    case "${arg}" in
        f) override_pkg_list="${OPTARG}" ;;
        C) override_pacman_conf="${OPTARG}" ;;
        L) override_repo_name="${OPTARG}" ;;
        P) override_repo_publisher="${OPTARG}" ;;
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

(( $# < 1 )) && \
  _msg_error "No package specified" 0 && \
  _usage 1

(( EUID != 0 )) && \
  _msg_error "$(_get "app" "name")} must be run as root." 1

_packages_extra=("${@}")
_set_overrides
_install_pkg ""
