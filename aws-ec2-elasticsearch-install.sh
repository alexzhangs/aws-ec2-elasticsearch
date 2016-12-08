#!/bin/bash -e

[[ $DEBUG -gt 0 ]] && set -x || set +x

BASE_DIR="$(cd "$(dirname "$0")"; pwd)"
PROGNAME=${0##*/}

usage () {
    printf "$PROGNAME\n"
    printf "\t[-f]\n"
    printf "\t[-h]\n"
    printf "\t[VERSION]\n"

    printf "OPTIONS\n"
    printf "\t[-f]\n\n"
    printf "\tUse local installation package instead of installing from official yum repo.\n"
    printf "\tInstalling from official yum repo sometimes is extremely slow(10KB/s) from China.\n\n"

    printf "\t[-h]\n\n"
    printf "\tThis help.\n\n"

    printf "\t[VERSION]\n\n"
    printf "\tElasticsearch Version.\n\n"
    exit 255
}

install_gpg_key () {
    rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
}

install_yum_repo () {
    local url='https://gist.githubusercontent.com/alexzhangs/d0c858520f79de71543393aa45dccf61/raw/4a01fd8eff1274cd2709387b7e5b214e778eb310/elasticsearch.repo'
    wget -c -O /etc/yum.repos.d/elasticsearch.repo "$url"
}


while getopts fh opt; do
    case $opt in
        f)
            from_file=1
            ;;
        h|*)
            usage
            ;;
    esac
done
shift $((OPTIND -1))

VERSION=$1

if [[ $from_file -ne 1 ]]; then
    install_gpg_key
    install_yum_repo
fi

if [[ -n $VERSION ]]; then
    package=elasticsearch-$VERSION
else
    package=elasticsearch
fi

if [[ $from_file -eq 1 ]]; then
    yum install -y "$BASE_DIR/files/$package.rpm"
else
    yum install -y "$package"
fi

exit
