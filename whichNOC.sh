#!/bin/bash
echo "-------------------------------------------------------------------"
echo "-                    SHIP NOC TERMINATION                         -"
echo "-------------------------------------------------------------------"
echo " "
echo " "
echo "Enter the FQDN of the unit: "
read FQDN
USERID=$(whoami)
SHIPIP=$(dig -n $FQDN | grep $FQDN | awk 'NR==3 i{print $5}' | cut -d ' ' -f2)
echo "UNIT IP: $SHIPIP"
EDGELOGIN="USERID@XXX.XX.XXX.65"
RESULT=$(ssh -q $EDGELOGIN sh ip route $SHIPIP | grep -o 'XXX.XX.XXX.*' | cut -d ' ' -f1 | sed 's/,//g' | sed -n '1p')
echo "$RESULT"
