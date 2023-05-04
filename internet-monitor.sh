#!/bin/bash

#Log file location
LOG_FILE=internet-monitor.log

if ! test -e $LOG_FILE; then
  touch $LOG_FILE
fi

while true; do

#---First-stage-ping---
  ping -c 3 9.9.9.9
  if [ $? -eq 0 ]; then
    #sleep x amount before pinging again
    sleep 60
    continue

  else
    echo "First stage has failed on $(date)" | tee -a $LOG_FILE
    #sleep x amount before attempting to ping again
    sleep 60

#---Second-stage-ping---
    ping -c 3 1.1.1.1
    if [ $? -eq 0 ]; then
        #sleep x amount before pinging again
        sleep 60
        continue

    else
        echo "Second stage has failed on $(date)" | tee -a $LOG_FILE
        #sleep x amount before attempting to ping again
        sleep 60

#---Third-stage-ping---
        ping -c 3 8.8.8.8
        if [ $? -eq 0 ]; then
            #sleep x amount before pinging again
            sleep 60
            continue

        #If the third stage fails then the script will shutdown system
        else
        echo "Third stage has failed on $(date)" | tee -a $LOG_FILE
        shutdown
        sleep 50

#---Last-chance-ping---
            ping -c 3 9.9.9.9 && ping -c 3 8.8.8.8 && ping -c 3 1.1.1.1
            if [ $? -eq 0 ]; then
            echo "ping was successfull 10 seconds before system shutdown, Continueing the script on $(date)" | tee -a $LOG_FILE
            shutdown -c
            #sleep x amount before pinging again
            sleep 60
            continue

            #If the last resort ping fails then system will continue the shutdown
            else
            echo "Last chance ping before shutdown has failed. Shutingdown in 10 seconds." | tee -a $LOG_FILE
            exit

            fi
            continue

        fi
        continue
  
    fi
    continue

  fi
  continue
  
done
