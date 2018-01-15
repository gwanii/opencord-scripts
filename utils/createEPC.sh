#!/bin/bash
# Execute on head1

user=xosadmin@opencord.org
pass=$(cat /opt/credentials/$user)
xos_api=10.1.0.1:9101
curl -u $user:$pass -X GET http://$xos_api/xosapi/v1/vepc/vepcserviceinstances -H "Content-Type: application/json"
#curl -u $user:$pass -X DELETE http://$xos_api/xosapi/v1/vepc/vepcserviceinstances/15 -H "Content-Type: application/json"
#curl -u $user:$pass -X POST http://$xos_api/xosapi/v1/vepc/vepcserviceinstances -H "Content-Type: application/json" -d '{"blueprint":"build", "site_id": 1}'
