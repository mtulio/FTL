#!/usr/bin/env bash

# 
# wrapper script for grading playbook for lab
#
#

VIRTUALENV=/opt/virtualenvs/venv-grading
FTL_REPO_HOME=/opt/ftl-repo-clone/
COURSE_NAME=ansible_engine_foundations
LAB_NUMBER=03_01

#
# Setup Ansible 
# 

# Make sure ansible finds the correct roles if it loads a new ansible.cfg

export ANSIBLE_ROLES_PATH=${FTL_REPO_HOME}/roles
export FILE=${FTL_REPO_HOME}/courses/${COURSE_NAME}/ansible.cfg

if [ -f $FILE ]; then
   export ANSIBLE_CONFIG=${FILE}
fi

echo ${ANSIBLE_CONFIG}

source ${VIRTUALENV}/bin/activate
ansible --version
ansible-playbook grade_course.yml     \
  -e course_name=${COURSE_NAME}       \
  -e lab_number=${LAB_NUMBER}
