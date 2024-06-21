echo "-----------------------------------------------------------------------------"
echo "-                            SHIP HEALTH CHECK                              -"
echo "-----------------------------------------------------------------------------"
echo ""
echo ""
echo ""
echo "--------PERFORM TRACEROUTE--------"
echo "Enter FQDN of Unit to trace: "
read FQDN
traceroute -m 20 $FQDN
echo "----------------------------------------------------------------------------"
echo "--------PERFORM DNS QUERY--------"
dig $FQDN any
echo "----------------------------------------------------------------------------"
echo "--------CHECK SMTP--------"
telnet $FQDN 25
echo "----------------------------------------------------------------------------"
echo "--------VERIFYING UNIT IN MAILERTABLE--------"
sudo cat /etc/mail/mailertable | grep $FQDN
echo "--------CHECK EMAIL QUEUES--------"
echo "-----------------------------------------------------------------------------"
MAILBOX=$(grep $FQDN /etc/mail/sendmail.cf | cut -d' ' -f5)
sudo telnet localhost 7257 | grep $MAILBOX | cut -f 1,2 -d ','
