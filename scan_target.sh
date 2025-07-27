#!/bin/bash
#password for sudo
sudo su
#target ip
ip=""
#reading the ip
read -p "Give the ip: " ip
#executing nmap scan
nmap -sV -sC -T4 -v --traceroute "$ip"
web=""
#reading the answer,if the ip is running a web server, ports 80,443,8080
read -p "Does it has a web application [y/n]: " web
if ["$web" = "y" ]; then
    gobuster dir -u http://"$ip"/ -w /usr/share/wordlists/dirb/dig.txt
    better_mapping=""
    read -p "Better mapping? [y/n]" better_mapping
    if ["$better_mapping" = "y"]; then
        echo "Starting extention fuzzing"
        port=""
        read -p "Give the port of the server: " port
        #default_path
        #index fuzzing
        ffuf -w /usr/share/wordlists/dirb/extensions_common.txt:FUZZ -u http://"$ip":"$port"/indexFUZZ
        #recursive fuzzing with depth 1
        ffuf -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt:FUZZ -u http://"$ip":"$port"/FUZZ -recursion -recursion-depth 1 -e .php -v
    else
        echo "so no more mapping. Let's continue"
    fi
elif ["$web" = "n" ]; then
    ssh=""
    read -p "Does it run ssh? [y/n]" ssh
    if ["$ssh" == "y" ]; then
        username=""
        read -p "if you know the username type it,else type the letter n" username
        password=""
        read -p "if you know the password type it,else type the letter n" password
        if ["$username" = "n"] && [$password  = "n"]; then
            #hydra without knowing any of the the credentials,it's going to take a lot
            answer=""
            read -p "Default wordlists? [y/n]" answer
            if ["$answer" = "y" ]; then
                hydra -L /usr/share/wordlists/rockyou.txt -P /usr/share/wordlists/rockyou.txt ssh://"$ip"
            elif ["$answer" = "n" ]; then
                #path to usernames
                wordlist1=""
                #path to passwords
                wordlist2=""
                read -p "Username wordlist path: " wordlist1
                read -p "Password wordlist path: " wordlist2
                hydra -L "$wordlist1" -P "$wordlist2" ssh://"$ip"
            else
                echo "wrong answer buddy"
            fi
        elif ["$username" != "n"] && [$password  == "n"]; then
            answer=""
            read -p "Default wordlist? [y/n]" answer
            if ["$answer" = "y" ]; then
            #using 4 threads and verbose mode,if you want it to stop in the first success,then use -f in the end
                hydra -l "$username" -P /usr/share/wordlists/rockyou.txt ssh://"$ip" -V -t 4
            elif ["$answer" = "n" ]; then
                #path to passwords
                wordlist2=""
                read -p "Password wordlist path: " wordlist2
                hydra -l "$username" -P "$wordlist2" ssh://"$ip" -V -t 4
            else
                echo "wrong answer buddy"
            fi
        elif ["$username" == "n"] && [$password  != "n"]; then
            answer=""
            read -p "Default wordlist? [y/n]" answer
            if ["$answer" = "y" ]; then
                hydra -L /usr/share/wordlists/rockyou.txt -p "$password" ssh://"$ip" -V -t 4
            elif ["$answer" = "n" ]; then
                                #path to passwords
                wordlist1=""
                read -p "Password wordlist path: " wordlist1
                hydra -l "$username" -P "$wordlist1" ssh://"$ip" -V -t 4
            else
                echo "wrong answer buddy"
            fi
        else
            echo "You already know them or you misstyped"
        fi
    fi
else
    echo "exiting ..."
fi