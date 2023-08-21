#!/usr/bin/env bash

unset mode

_retrieve_pkgbuild_repo() {
    local _pkgname="${1}" \
	  _source="${2}" \
          _user="${3}"
    if [[ "${_source}" == "" ]] || \
       [[ "${_source}" == "aur" ]] ; then
        _url="https://aur.archlinux.org"
    elif [ "${_source}" == "archlinux" ]; then
        _url="https://gitlab.archlinux.org/${_user}/${_pkgname}-aur"
    fi
    git clone "${_url}/${_pkgname}"
}

_makepkg() {
    local _pkgname="${1}" \
          _source="${2}" \
          _user="${3}"
    local _key \
	  _awk_pgpkeys_cmd='/validpgpkeys=/{flag=1;next}/\)/{flag=0}flag' \
          _validpgpkeys
    _retrieve_pkgbuild_repo "${_pkgname}"
                            "${_source}" \
	                    "${_user}"
    cd "${_pkgname}" || exit
    source 'PKGBUILD'
    gpg --recv-keys \
	"${validpgpkeys[@]}"
    makepkg
    mv "${_pkgname}"*".pkg.tar."* "${_server}"
}

_build_pkg() {
    local _pkgname="${1}" \
          _mode="${2}"  \
	  _server="${3}"
          _pwd
    _pwd="$(pwd)"
    echo "building ${_pkgname}"
    if [ "${_mode}" = "src" ]; then
        _makepkg "${_pkgname}"
    elif [ "${_mode}" = "fakepkg" ]; then
        cd "${_server}" || exit
        fakepkg "${_pkgname}"
    fi

    cd "${_server}" || exit
    repo-add "${_profile}.db.tar.gz" "${_pkgname}"*".pkg.tar."*
    cd "${_pwd}" || exit
}

_build_repo() {
    local _mode="${1}"
    local _packages="${2}"
    local _server="${3}"
    local _profile
    local _pwd
    _pwd=$(pwd)
    _profile=$(basename "$(pwd)")
    # shellcheck source=./packages.extra
    # shellcheck disable=SC1091
    source "${_pwd}/${_packages}"
    [[ "${_server}" == "" ]] && \
      _server="/tmp/ur/${_profile}"
    rm -rf repo "${_server}"
    mkdir -p repo "${_server}"
    chown "$(id -u):$(id -g)" "${_server}"
    chmod 700 "${_server}" 
    cd repo || exit
    # shellcheck disable=SC2154
    echo "building ${_packages[*]}"
    for _pkg in "${_packages[@]}"; do
        _build_pkg "${_pkg}" \
		   "${_mode}" \
		   "${_server}"
    done
    cd ..
    rm -rf repo
}

mode="${1}"
packages_file="${2}"
server="${3}"

_build_repo "${mode}" \
	    "${packages_file}" \
	    "${server}"
