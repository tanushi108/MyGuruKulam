#!/bin/bash

DB="$HOME/.otssh.db"

touch "$DB"

usage() {
cat << EOF

Usage:

  Add Connection                 otssh -a -n <name> -h <host> -u <user> [-p port] [-i key]
  Update Connection    		 otssh -U -n <name> -h <host> -u <user> [-p port] [-i key]
  List Connections         	 otssh ls
  List Connections (Detailed)    otssh ls -d
  Delete Connection              otssh rm <name>
  Connect to Server              otssh <name>

Options:

  -a        Add new SSH connection
  -U        Update existing SSH connection
  -n        Connection name
  -h        Hostname or IP address
  -u        SSH username
  -p        Port (Default: 22)
  -i        Identity (Private Key)

Examples:

  otssh -a -n server1 -h 192.168.21.30 -u kirti
  otssh -a -n server2 -h 192.168.42.34 -u kirti -p 2022
  otssh -a -n server3 -h 192.168.46.34 -u ubuntu \
        -p 2022 -i ~/.ssh/server3.pem
  otssh ls
  otssh ls -d
  otssh -U -n server1 -h server1 -u user1
  otssh rm server1
  otssh server3

EOF
exit 1
}

########################################
# LIST
########################################

if [ "$1" = "ls" ]; then

    if [ "$2" = "-d" ]; then

        while IFS="|" read -r name host user port key
        do
            [ -z "$name" ] && continue

            cmd="ssh"

            [ -n "$key" ] && cmd="$cmd -i $key"
            [ "$port" != "22" ] && cmd="$cmd -p $port"
            cmd="$cmd $user@$host"

            echo "$name: $cmd"
        done < "$DB"
    else
        cut -d'|' -f1 "$DB"
    fi

    exit
fi

########################################
# DELETE
########################################

if [ "$1" = "rm" ]; then

    grep -v "^$2|" "$DB" > /tmp/otssh.tmp
    mv /tmp/otssh.tmp "$DB"

    echo "$2 deleted."

    exit
fi

########################################
# CONNECT
########################################

if [[ "$1" != -* && "$1" != "ls" && "$1" != "rm" ]]; then

    line=$(grep "^$1|" "$DB")

    if [ -z "$line" ]; then
        echo "[ERROR]: Server information is not available, please add server first"
        exit 1
    fi

    IFS="|" read name host user port key <<< "$line"
    
   echo "Connecting to $name"
echo "Host : $host"
echo "User : $user"
echo "Port : $port"
echo "Key :$key"
echo

echo
  cmd="ssh"

[ -n "$key" ] && cmd="$cmd -i $key"
[ "$port"!=22 ] && cmd="$cmd -p $port" 
echo "Command Running......"
echo $cmd $user@$host
echo
echo "..............Connecting............."
$cmd $user@$host
   eval "$cmd"

    exit
fi

########################################
# ADD / UPDATE
########################################

ACTION=""

while getopts ":aUn:h:u:p:i:" opt
do
    case $opt in
        a)
            ACTION="ADD"
            ;;
        U)
            ACTION="UPDATE"
            ;;
        n)
            NAME=$OPTARG
            ;;
        h)
            HOST=$OPTARG
            ;;
        u)
            USERNAME=$OPTARG
            ;;
        p)
            PORT=$OPTARG
            ;;
        i)
            KEY=$OPTARG
            ;;
        *)
            usage
            ;;
    esac
done

PORT=${PORT:-22}

[ -z "$ACTION" ] && usage
[ -z "$NAME" ] && usage
[ -z "$HOST" ] && usage
[ -z "$USERNAME" ] && usage

########################################
# ADD
########################################

if [ "$ACTION" = "ADD" ]; then

    if grep -q "^$NAME|" "$DB"
    then
        echo "Server already exists."
         exit 1
    fi

    echo "$NAME|$HOST|$USERNAME|$PORT|$KEY" >> "$DB"

    echo "Server added successfully."

    exit
fi

########################################
# UPDATE
########################################

if [ "$ACTION" = "UPDATE" ]; then

    grep -v "^$NAME|" "$DB" > /tmp/otssh.tmp

    echo "$NAME|$HOST|$USERNAME|$PORT|$KEY" >> /tmp/otssh.tmp

    mv /tmp/otssh.tmp "$DB"

    echo "Server updated successfully."
 exit
fi
