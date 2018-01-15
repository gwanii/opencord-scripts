#!/bin/bash
make xos-teardown
make clean-openstack
make clean-profile
make -j4 build
make compute-node-refresh
