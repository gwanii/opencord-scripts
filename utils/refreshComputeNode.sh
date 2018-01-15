#!/bin/bash
# Execute on head1

cd /opt/cord/build
ansible-playbook --skip-tags "set_compute_node_password,switch_support,reboot,interface_config" -i /etc/maas/ansible/pod-inventory --extra-vars "@/opt/cord_profile/genconfig/config.yml" --private-key ~/.ssh/cord_rsa ./platform-install/compute-node-refresh-playbook.yml
