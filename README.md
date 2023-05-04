# Steps in script

Stage 0

Creates a log file under  internet-monitor.log in the directory that the main script is running

Stage 1

1, Will try to ping every 60 seconds to Quad9 DNS service 9.9.9.9

Stage 2

2, If step 1 has failed it will wait another 60 seconds and then ping Cloudflare DNS service 1.1.1.1

2.1, If this ping is successful then it will go back to step 1 in 60 seconds

Stage 3

3, If Step 2 has failed it will wait another 60 seconds and then ping Google DNS service 8.8.8.8

3.1, If this ping is successful then it will go back to step 1 in 60 seconds

Last chance stage

4, If all 3 stages has failed then the script will initiate a shutdown command

4.1, It will ping all 3 ipv4 addresses 10 seconds before the system shutdown and if its successful then go back to step 1 in 60 seconds

# How to use

You can create a service that starts the script at system boot
