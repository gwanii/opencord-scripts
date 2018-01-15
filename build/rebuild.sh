#!/bin/bash
make xos-teardown
make clean-openstack
make clean-profile
make clean-genconfig
make PODCONFIG=mcord-wtf-physical.yml config
make -j4 build
make compute-node-refresh
