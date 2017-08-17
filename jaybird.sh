#!/usr/bin/expect -f

set prompt "#"
set address [lindex $argv 0]

spawn bluetoothctl
expect -re $prompt
send "power on\r"
expect "Changing power on succeeded"
expect -re $prompt
send "agent on\r"
expect -re $prompt
send "default-agent\r"
expect "Default agent request successful"
expect -re $prompt
send "connect C0:28:8D:14:7A:9E\r"
expect "Attempting to connect to C0:28:8D:14:7A:9E"
expect -re "Connection successful"
send_user "\n jaybird connected.\n"
sleep 2
send "quit\r"
expect eof