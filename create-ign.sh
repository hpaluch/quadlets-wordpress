#!/bin/bash
set -xeuo pipefail
butane -d `pwd` -c config.butane
butane -d `pwd` -ps -o example.ign config.butane
exit 0
