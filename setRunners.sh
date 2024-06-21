#!/bin/bash
echo "----------------------------------------------------------------------------------------------"
echo "---                                Change Unit Runners (IMS01)                             ---"
echo "----------------------------------------------------------------------------------------------"
echo ""
echo "Enter the FQDN of the unit:"
read FQDN

MAILGRP=$(cat /etc/mail/sendmail.cf | grep $FQDN | awk '{print $6'})
echo "Unit to change is: $FQDN -- $MAILGRP"
RUNNER=$(cat /etc/mail/sendmail.cf | grep Q$MAILGRP | cut -d',' -f4 | cut -d'=' -f2)
LINENUM=$(cat /etc/mail/sendmail.cf | grep -n Q$MAILGRP | cut -d':' -f1)
echo "Runners are currently set to $RUNNER"
echo "      "
echo "      "
echo "---------------------------------------------------------------------------------------------"
echo "What would you like to set the runners to: "
read newRUNNER
echo " "
sudo sed -i "${LINENUM} s|R=$RUNNER|R=$newRUNNER|" /etc/mail/sendmail.cf

echo "Changed runners to $newRUNNER for $FQDN"
cat /etc/mail/sendmail.cf | grep Q$MAILGRP

echo "---------------------------------------------------------------------------------------------"
USERID=$(whoami)
IMS2LOGIN="$USERID@XXX.XX.XXX.152"
IMS3LOGIN="$USERID@XXX.XX.XXX.153"
sudo sed -i "${LINENUM} s|R=$RUNNER|R=$newRUNNER|" /etc/mail/sendmail.cf
ssh -tt -q $IMS2LOGIN "sudo sed -i '${LINENUM} s|R=${RUNNER}|R=${newRUNNER}|' /etc/mail/sendmail.cf && grep Q$MAILGRP /etc/mail/sendmail.cf"
ssh -tt -q $IMS3LOGIN "sudo sed -i '$LINENUM s|R=$RUNNER|R=$newRUNNER|' /etc/mail/sendmail.cf && grep Q$MAILGRP /etc/mail/sendmail.cf"
