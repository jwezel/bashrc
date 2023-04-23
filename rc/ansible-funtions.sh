#!/bin/bash
# Function for working with Ansible

ansible-error-parse() {
    sed '1c{' | python -c 'import json,sys;print json.load(sys.stdin)["msg"]'
}
