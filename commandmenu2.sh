#-----------------------------------------------------------------------------------
# Description: This script displays a menu to the user, providing options to launch 
#              a command from the available options. 			
#
#   Date           Author            Description
# 2018-09-24     Aditya Patel      Initial creation
#-----------------------------------------------------------------------------------

#!/bin/bash

#assigning a initial variable
x=0

#creating a while loop
while [ $x = 0 ]

do
    clear
    #Creating the menu with the required commands and their description.
    echo "
		
    Select an option from the following to execute the desired command.
    (1) dh-h: Command that gives information about the free space on the storage devices.
    (2) ls -l: Displays a list of content inside a directory .
    (3) ps -A: Displays information about user processes.
    (4) netstat: Gives information about the network and its status to the user.
    (5) ifconfig: Displays information about the Network Interface( IP address, MAC address, etc.).
    (6) echo \$path: Displays the current path.
    (7) hostname: Displays the hostname.
    (8) route: Displays a Routing Table.
    (9) uptime: Displays the latest uptime of the device in use.
    (10)blkid: Gives information about storage or block devices like their file type, name, etc.
    (11)mount: Used to mount different storage devices like USBs, SD cards, etc.

    Press 'q' to quit
    "

    # reading the option selected by the user
    read option

    # assigning the commands according to the menu as required
    case "$option" in
        1)
        df -h
        sleep 2        
        echo "
	Press any key to return to the menu."
        read option
        ;;
        2)
        ls -l
        sleep 2
        echo "
	Press any key to return to the menu."
        read option
        ;;
        3)
        ps -A | less 
        sleep 2
        echo "
	Press any key to return to the menu."
        read option
        ;;
        4)
        netstat | less
        sleep 2
        echo "
	Press any key to return to the menu."
        read option
        ;;
        5)
        ifconfig 
        sleep 2
        echo "
	Press any key to return to the menu."
        read option
        ;;
        6)
        echo $PATH
        sleep 2
        echo "
	Press any key to return to the menu."
        read option
        ;;
        7)
        hostname
        read option
        sleep 2
        echo "
	Press any key to return to the menu."
        ;;
        8)
        route
        sleep 2
        echo "
	Press any key to return to the menu."
        read option
        ;;
        9)
        uptime
        sleep 2
        echo "
	Press any key to return to the menu."
        read option
        ;;	
        10)
        blkid
        sleep 2
        echo "
	Press any key to return to the menu."
        read option
        ;;
        11)
        mount | less
        sleep 2
        echo "
	Press any key to return to the menu."
        read option
        ;;
        q)
        echo "Quiting."
        sleep 2
        clear
        exit
        ;;
        *)
        clear
        echo "
	Option not found, Redirecting to main menu in 2 seconds!"
        sleep 2
        ;;

    # escaping the Case    
    esac
	
#closing the while looop 
done	
