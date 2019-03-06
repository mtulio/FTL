#!/usr/bin/env bash

# 
# wrapper script for grading playbook for lab
#

VIRTUALENV=/opt/virtualenvs/venv-grading
FTL_REPO_HOME=/opt/ftl-repo-clone/
#COURSE_NAME=ansible_engine_foundations
#LAB_NUMBER=03_01

if [ -f /tmp/error_report.txt ]; 
then
  cp /tmp/error_report.txt /tmp/error_report.txt-previous
fi

#
# Setup Ansible 
# 

# Make sure ansible finds the correct roles if it loads a new ansible.cfg

export ANSIBLE_ROLES_PATH=${FTL_REPO_HOME}/roles:${FTL_REPO_HOME}/roles-ftl-runtime
export FILE=${FTL_REPO_HOME}/courses/${COURSE_NAME}/ansible.cfg

if [ -f $FILE ]; then
   export ANSIBLE_CONFIG=${FILE}
fi

source ${VIRTUALENV}/bin/activate

ansible-playbook grade_lab.yml        \
  -e @vars/global_vars.yml            \
  -e @test-data/sample-vars.yml $@   # > /tmp/opentlc_grader_log 2>&1
#  -e course_name=${COURSE_NAME}       \
#  -e lab_number=${LAB_NUMBER} -vv   # > /tmp/opentlc_grader_log 2>&1

# Output the error report

cat /tmp/error_report.txt
