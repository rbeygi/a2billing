#!/bin/bash

# Set color variables
red='\033[0;31m'
cyan='\033[0;36m'
clear='\033[0m'

script_usage() {
  echo
  echo "Usage: $0 -a ACTION -p PROJECT_NAME -v PROJECT_VERSION"
  echo
  echo "Switches:"
  echo -e "\t-a\t\tSpecify action to perform (install, upgrade, rollback, delete) - required."
  echo -e "\t\t\t${cyan}Version Project is required just for rollback action for other action is not nessecery.${clear}"
  echo -e "\t-p\t\tSpecify Project Name (a2billing, mysql-phpmyadmin) - required for create action."
  echo
  echo "Examples:"
  echo -e "\t$0 -a install -p mysql-phpmyadmin"
  echo -e "\t$0 -a upgrade -p a2billing"
  echo -e "\t$0 -a rollback -p a2billing -v 3"
  echo -e "\t$0 -a delete -p mysql-phpmyadmin"
  exit 1
}

while [[ $# -gt 0 ]]; do
  case "${1}" in
    -a )
      action="${2}"
      shift
      shift
      ;;
    -p )
      project_name="${2}"
      shift
      shift
      ;;
    -v )
      project_version="${2}"
      shift
      shift
      ;;
    * )
      script_usage
      exit 1
      ;;
  esac
done

execute_helm() {
  case ${action} in
    install )
      if [[ -z ${project_name} || -z ${action} ]] ; then
        echo -e "${red}Action and Project name are required.${clear}"
        script_usage
      fi
        microk8s.helm install ${project_name} ./${project_name}/
      ;;
    upgrade )
      if [[ -z ${project_name} || -z ${action} ]] ; then
        echo -e "${red}Action and Project name are required.${clear}"
        script_usage
      fi
        microk8s.helm upgrade ${project_name} ./${project_name}/
      ;;
    rollback )
      if [[ -z ${project_name} || -z ${action} || -z ${project_version} ]] ; then
        echo -e "${red}Action and Project name and Version are required.${clear}"
        script_usage
      fi
        microk8s.helm rollback ${project_name} ${project_version}
      ;;
    delete )
      if [[ -z ${project_name} || -z ${action} ]] ; then
        echo -e "${red}Action and Project name are required.${clear}"
        script_usage
      fi
        microk8s.helm delete ${project_name} 
      ;;
    * )
      echo -e "${red}Undefined action, exiting.${clear}"
      script_usage
      ;;
  esac
}

if [[ -z ${project_name} || -z ${action} ]]; then
  script_usage
else
  execute_helm
fi

exit 0
