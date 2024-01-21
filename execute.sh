#!/bin/bash -e
# https://github.com/tradichel/SecurityMetricsAutomation
# execute/execute.sh
# author: @teriradichel @2ndsightlab
# Description: Generic deployment script to deploy a stack
# based on the values in an SSM Parameter
##############################################################
source resources/ssm/parameter/parameter_functions.sh
source execute/shared/functions.sh
source execute/shared/validate.sh

s="execute/execute.sh"

job_param="$1"

echo "Executing job: $job_param"

profile=$(echo $job_param | cut -d '/' -f4)
resource=$(echo $job_param | cut -d '/' -f5)
resource_category=$(echo $resource | cut -d '-' -f1)
resource_type=$(echo $resource | cut -d '-' -f2)
resource_name=$(echo $resource | cut -d '-' -f3-)

validate_set $s "profile" $profile
validate_set $s "resource_category" $resource_category
validate_set $s "resource_type" $resource_type
validate_set $s "resource_name" $resource_name

echo "Profile: $profile"
echo "Resource Category: $resource_category"
echo "Resource Type: $resource_type"
echo "Resource Name: $resource_name"

job_config=$(get_ssm_parameter_job_config $job_param)
echo $job_config
exit

#to implement:
#get_arg_from_job_ssm_parameter
profile=$(get_arg_from_job_ssm_parameter $ssm_parameter_value "profile")
region=$(get_arg_from_job_ssm_parameter $ssm_parameter "region")
resource_type=$(get_arg_from_job_ssm_parameter $ssm_parameter "resource_type")
resource_category=$(get_arg_from_job_ssm_parameter $ssm_parameter "resource_category") 

#to implement:
#get_parameters
parameters=$(get_parameters $ssm_parameter_value)

validate_set $ssm_parameter_name "profile" $profile
validate_set $ssm_parameter_name "region" $region
validate_set $ssm_parameter_name "resource_type" $resource_type
validate_set  $ssm_parameter_name "resource_category" $resource_category

deploy_stack ....
