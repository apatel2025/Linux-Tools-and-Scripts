#!/bin/bash
#
# Bash script that flushes the rules from the chains 


#iptables -A INPUT -p tcp --syn -m tcp --dport 22 -m conntrack --ctstate NEW -m limit --limit 3/minute -j REJECT

iptables -F #flushing

iptables -P INPUT DROP #set input policy to drop

iptables -P FORWARD DROP #the same for forward

iptables -P OUTPUT DROP #output chain policy set to ACCEPT

iptables -A INPUT -p tcp --syn -m tcp --dport 22 -m recent --set 
iptables -A INPUT -p tcp --syn -m tcp --dport 22 -m recent --update --hitcount 2 -j DROP

iptables -A INPUT -i eth0 -p tcp -m tcp --dport 21:22 -j ACCEPT # to allow SSH and Telnet traffic 

iptables -A OUTPUT -o eth0 -p tcp -m tcp --sport 21:22 -j ACCEPT

iptables -A OUTPUT -p tcp -m tcp --dport 21 -m connbytes --connbytes 500 --connbytes-dir reply --connbytes-mode bytes -j DROP

iptables -A INPUT -j LOG --log-prefix "FTPPackets-Dropped: "
