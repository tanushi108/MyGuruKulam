#!/bin/bash

case "$1" in

# Add Team (Group)
addTeam)

   sudo  groupadd "$2"
    echo "Team '$2' created successfully."
    ;;

# Delete Team
delTeam)

    sudo groupdel "$2"
    echo "Team '$2' deleted successfully."
    ;;

# Add User
addUser)

    user=$2
    team=$3

    # Create user with home directory
    sudo useradd -m -g "$team" "$user"

    # Set password
    sudo passwd "$user"

    # Create shared directories
   sudo  mkdir -p /home/$user/team
   sudo mkdir -p /home/$user/ninja

    # Owner permissions
   sudo  chmod 700 /home/$user

    # Same team members -> Read + Execute
    sudo chgrp "$team" /home/$user
    sudo chmod 750 /home/$user

    # Others -> Execute only
    sudo chmod o=x /home/$user

    # team directory -> full access to team
    sudo chgrp "$team" /home/$user/team
    sudo chmod 770 /home/$user/team

    # ninja directory -> full access to all ninjas
    if ! getent group ninja >/dev/null
    then
       sudo  groupadd ninja
    fi

    sudo usermod -aG ninja "$user"

    sudo chgrp ninja /home/$user/ninja
    sudo chmod 770 /home/$user/ninja

    sudo chown -R "$user:$team" /home/$user/team
    sudo chown "$user:ninja" /home/$user/ninja

    echo "User '$user' added successfully."
    ;;

# Delete User
delUser)

    sudo userdel -r "$2"
    echo "User '$2' deleted successfully."
    ;;

# Change Password
changePasswd)

    sudo passwd "$2"
    ;;

# Change Shell
changeShell)

    sudo usermod -s "$3" "$2"
    echo "Shell changed successfully."
    ;;

# List Users / Teams
ls)

    if [ "$2" = "User" ]
    then
        echo "Users:"
       sudo  cat /etc/passwd

    elif [ "$2" = "Team" ]
    then
        echo "Groups:"
        sudo cat /etc/group

    else
        echo "Usage:"
        echo "./UserManager.sh ls User"
        echo "./UserManager.sh ls Team"
    fi
    ;;

*)

echo "Welcome to UserMangement System"
;;
esac
