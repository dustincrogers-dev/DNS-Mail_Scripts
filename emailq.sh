#!/bin/bash
echo "--------CHECK EMAIL QUEUES--------"
echo "Enter the FQDN of the unit (hullnumber.navy.mil): "
read FQDN
MAILBOX=$(grep $FQDN /etc/mail/sendmail.cf | awk '{print $6}')
USERID=$(whoami)
IMS2LOGIN="$USERID@XXX.XX.XXX.152"
IMS1=$(sudo telnet localhost 7257 | grep $MAILBOX | awk 'NR==1{print $1}' | cut -d',' -f2)
IMS2LOGIN="$USERID@XXX.XX.XXX.152"
IMS3LOGIN="$USERID@XXX.XX.XXX.153"
TNCMD="sudo telnet localhost 7257 | grep $MAILBOX | cut -d',' -f2"
IMS2=$(ssh -tt -q $IMS2LOGIN "$TNCMDsudo telnet localhost 7257 | grep $MAILBOX | cut -d',' -f2")
IMS3=$(ssh -tt -q $IMS3LOGIN "sudo telnet localhost 7257 | grep $MAILBOX | cut -d',' -f2 | cut -d't' -f1")
T1=$(echo $IMS1)
T2=$(echo $IMS2 | grep -Po "\\d+")
T3=$(echo $IMS2 | grep -Po "\\d+")
TOTAL=$(($T1+$T2+$T3))
echo "Total Email Queue for $FQDN: $TOTAL"
