#!/bin/bash

while true; do
	echo ""
	echo "1) Space use over 80% Check."
	echo "2) CPU loading over 90%."
	echo "3) Memory use over 80%."
	echo "4) Disk Health Check."
	echo "5) Host/Network Service Check."
	echo "6) Abormal Service Detecting."
	echo "7) Exit System."
	echo -n "Choice function："
	read CHOICE
	case $CHOICE in
  	1)
    	 bash ./spaceCheck.sh
	 read -p "press enter go back to menu!..."
    	 ;;
  	2)
    	 bash ./cpuCheck.sh
	 read -p "press enter go back to menu!..."
    	 ;;
  	3)
    	 bash ./memoryCheck.sh
	 read -p "press enter go back to menu!..."
    	 ;;
  	4)
    	 bash ./healthCheck.sh
	 read -p "press enter go back to menu!..."
    	 ;;
  	5)
    	 bash ./networkCheck.sh
	 read -p "press enter go back to menu!..."
    	 ;;
  	6)
    	 bash ./abormalDetecte.sh
	 read -p "press enter go back to menu!..."
    	 ;;
  	7)
    	 echo "Good Bye!!"
    	 break
      	 ;;
  	*)
     echo "無效選擇"
    ;;
	esac
done
