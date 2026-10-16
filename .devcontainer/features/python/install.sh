#!/usr/bin/env bash
set -euxo pipefail

# runs as root during build
microdnf update -y
microdnf install -y python3 python3-pip
microdnf clean all
