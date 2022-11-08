#!/bin/bash -x

# Set color variables
red='\033[0;31m'
cyan='\033[0;36m'
clear='\033[0m'

tag_name=dev

script_usage() {
  echo
  echo "Usage: $0 -p PROJECT_NAME"
  echo
  echo "Switches:"
  echo -e "\t-p\t\tSpecify Project Name (admin, customer, asterisk) - required for build."
  echo
  echo "Examples:"
  echo -e "\t$0 -p admin"
  echo -e "\t$0 -p customer"
  echo -e "\t$0 -p asterisk"
  exit 1
}

while [[ $# -gt 0 ]]; do
  case "${1}" in
    -t )
      tag_name="${2}"
      shift
      shift
      ;;
    -p )
      project_name="${2}"
      shift
      shift
      ;;
    * )
      script_usage
      exit 1
      ;;
  esac
done

execute_docker_build() {
  case ${project_name} in
    admin )
      if [[ -z ${project_name} || -z ${tag_name} ]] ; then
        echo -e "${red}Tag Name and Project name are required.${clear}"
        script_usage
      fi
        cd build/${project_name}/
        docker build -t ${project_name}:${tag_name} .
      ;;
    customer )
      if [[ -z ${project_name} || -z ${tag_name} ]] ; then
        echo -e "${red}Tag Name and Project name are required.${clear}"
        script_usage
      fi
        cd build/${project_name}/
        docker build -t ${project_name}:${tag_name} .
      ;;
    asterisk )
      if [[ -z ${project_name} || -z ${tag_name} ]] ; then
        echo -e "${red}Tag Name and Project name are required.${clear}"
        script_usage
      fi
        cd build/${project_name}/
        docker build -t ${project_name}:${tag_name} .
      ;;
    * )
      echo -e "${red}Undefined action, exiting.${clear}"
      script_usage
      ;;
  esac
}

if [[ -z ${project_name} || -z ${tag_name} ]]; then
  script_usage
else
  execute_docker_build
fi

exit 0