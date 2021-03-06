#!/bin/bash

#By Hud Seidu Daannaa MSc, CEH
#   Information Security

#Just like using wireshark, Tcpdump can also be used to analysis Pcap file, using the terminal (bash)
#increases speed and efficiency as well, also one is able to bend the work operation to his/ her desired way
#Below, i used Bash (grep) and regex to fish out and analyse patterns

#sort -u|sort -nr|uniq -c|head -n1|tail -n1|

#Kill a process
sudo kill $(ps -aux | grep -i 'tcpdump' | awk '{print $2}' | head -n1) -9

#install libpcap
sudo apt-get install libpcap-dev

#Install tcpdump
sudo apt-get install tcpdump

#Check exit status
echo $?

#Command to fish out IP addressess..
tcpdump -r $cap  -nn  | awk '{print $3}' | cut -d '.' -f 1-4 | sort -u | head -n2

#Command to fish out Port..
tcpdump -r $cap  -nn 'tcp[13] = 2' | cut -f 5  -d " " | cut -d '.' -f 5 | sort | uniq -c | sort -nr | head -n2

#To display IP information
whois $(tcpdump -r $cap -nn  | awk '{print $3}' | cut -d '.' -f 1-4 | sort -u | head -n2)

#View PCAP strings | Plain text
tcpdump -r $cap -Ann 'dst port = 139' | head -n50 | grep -i ''
tcpdump -r $cap -Ann 'src port = 139' | head -n50 |grep -i ''
tcpdump -r $cap -Ann 'tcp or udp' | head -n50 |grep -i ''

#Investigation of anomalous traffic
tcpdump -r $cap -nn 'port = 139 or port = 21' | head -n50 | grep -i ''
tcpdump -r $cap -nn 'port = 21' | head -n50 | grep -i ''

#High layer domains
tcpdump -r $cap -nn 'port = 139' | head -n50 | grep -i ''
tcpdump -r $cap -nn 'port = 139' | grep -Ev '(com|net|org|gov|mil|arpa|au|uk|co)' | cut -f 9 -d " "| head -n50
tcpdump -r $cap -nn 'port = 139' | grep -Ev '(com|net|org|gov|mil|arpa|au|uk|co)' | cut -f 9 -d " "| grep -E '[a-z]'
tcpdump -r $cap -nn 'port = 139' | grep -Ev '[a-z][a-z][a-z])' | cut -f 9 -d " "| grep -E '[a-z]'

#HTTP METHODS
tcpdump -r $cap -Ann 'dst port = 80' | head -n50

#Remove GET and HEAD methods
tcpdump -r $cap -Ann 'dst port = 80' | grep 'HTTP' | grep -Ev '(GET|HEAD)' | head -n50
tcpdump -r $cap -Ann 'port = 80' | grep -i 'referer' | head -n50

#User-Agent field
tcpdump -r $cap -Ann 'port = 80' | grep -Ei 'user-agent' | sort | uniq -c | sort -nr |head -n50
tcpdump -r $cap -Ann 'port = 80' | sed -n '/GBXHTTP/,$p' |head -n50
tcpdump -r $cap -Ann 'port = 80' | grep -Ei '/GBXHTTP/,$p' --context=5 |head -n50

#Host
host $cap

#Creating a PCAP repository
sudo -b tcpdump -nn eth0 -w capture.pcap -C 1 -W 5
sudo -b tcpdump -nn eth0 -w capture.pcap -G 600 -W 5




