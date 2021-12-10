#!/bin/bash
terraform init
$(terraform apply -auto-approve | grep "ssh -i") 