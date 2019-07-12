#!/usr/bin/env bash
[[ -n ${SCRIPT_DEBUG} ]] && set -x
set -e

function help() {
	echo "Missing arguments"
    echo "quaybuild repo archive_url tag dockerfile_path subdirectory"
    exit
}

function dobuild() {
    repo=${1}
    archive_url=${2}
    tag=${3}
    dockerfile_path=${4}
    subdirectory=${5:-$(dirname ${dockerfile_path})}

    curl -s -H 'Content-Type: application/json' -X POST -H "Authorization: Bearer ${APP_ROBOT_TOKEN}" \
         https://quay.io/api/v1/repository/${repo}/build/ --data \
         "{\"quay_repo\":\"${repo}\",\"docker_tags\":[\"${tag}\"],\"archive_url\":\"${archive_url}\",\"dockerfile_path\":\"${dockerfile_path}\", \"subdirectory\":\"${subdirectory}\"}" | /usr/libexec/platform-python -mjson.tool
}
[[ -z ${APP_ROBOT_TOKEN} ]] && {
	echo "APP_ROBOT_TOKEN variable need to be defined"
	exit 1
}

[[ -z ${@} ]] && help
dobuild $@
