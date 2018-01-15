#!/bin/bash
make clean-genconfig
make PODCONFIG=mcord-wtf-physical.yml config
scp $manifest/mcord-wtf.yml cord@192.168.105.181:/opt/cord/build/platform-install/profile_manifests/mcord-wtf.yml
scp ../xos_images/vepc.img cord@192.168.105.181:/opt/cord/xos_images/
ssh cord@192.168.105.181 rm /opt/images/image-vmme.qcow2
ssh cord@192.168.105.181 rm /opt/images/image-vsgw.qcow2
ssh cord@192.168.105.181 rm /opt/images/image-vpgw.qcow2
rm milestones/glance-images
make milestones/glance-images
rm milestones/onboard-profile
make milestones/onboard-profile
