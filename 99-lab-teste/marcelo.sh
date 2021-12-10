#!/bin/bash

terraform init
$(terraform output | grep ssh)