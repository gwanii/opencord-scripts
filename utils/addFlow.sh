#!/bin/bash
# Execute on head1

# HowTo: connect physical enb to vm in CiaB
# You can connect eNodeB’s eth0 interface directly to CiaB server’s eth1.
# Give eNodeB eth0 same network subnet in epc_network, and attach CiaB’s eth1 onto underlay ovs.
# So now network flow can go into overlay ovs, the last thing you need to do is adding a flow in overlay ONOS, this flow will let packet go back to eNB.

#set -ex
EnbIP=192.168.11.1
EnbMAC=aa:62:e8:0e:87:4d

ONOSHost=onos-cord
ONOSPort=8182
ONOS=http://$ONOSHost:$ONOSPort
User=onos
Pass=rocks
Auth=$User:$Pass
DeviceID=$(curl -s -u $Auth -X GET -H 'Accept: application/json' "${ONOS}/onos/v1/devices"|jq -r '.devices[0].id')
echo "br-int ID: $DeviceID"

Req=$(cat <<EOF
{ 
    "priority": 5000,
    "timeout": 0,
    "isPermanent": true,
    "deviceId": "$DeviceID",
    "treatment": {
      "instructions": [
        {
          "type":"L2MODIFICATION",
          "subtype":"ETH_DST",
          "mac": "$EnbMAC"
        },
        {
          "type": "OUTPUT",
          "port": "2"
        }
      ]
    },
    "selector": {
      "criteria": [
        {
          "type": "ETH_TYPE",
          "ethType": "0x0800"
        },
        {
          "type": "IPV4_DST",
          "ip": "$EnbIP/32"
        }
      ]
    }
}
EOF
)

add_flow() {
    # Add Flow
    echo "Add flow" && curl -s -u $Auth -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' "$ONOS/onos/v1/flows/$DeviceID" -d "$Req"
}

del_flow() {
    # Delete Flow
    FlowID=$((0x$(sshpass -p $Pass ssh $ONOSHost 'flows' |grep $EnbIP|xargs -n 1|grep id|cut -d= -f2|cut -d, -f1)))
    [[ "x$FlowID" == "x0" ]] && echo "Flow not exists." && exit 1
    echo "Delete flow: $FlowID" && curl -s -u $Auth -X DELETE -H 'Accept: application/json' "$ONOS/onos/v1/flows/$DeviceID/$FlowID"
}

add_flow
#del_flow
