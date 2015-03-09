#!/bin/bash
# Make a list of commands for a new user

username=$1

# Make a new user with an expiring password
useradd $username
    # enter password
passwd $username
    # enter default password: cluster123!
passwd -e $username

# Allow on Sambamba
smbpasswd -a $username
    # enter default password: cluster123!
    # user can change with smbpasswd

# Make a share directory for the user with lab permissions
usermod -a -G lab $username
mkdir /data/shared/homes/$username
chown $username:lab /data/shared/homes/$username

# Collect uid and gid
user_id=`id -u $username`
group_id=`id -g $username`

#########################################
for i in n002 n003 n004 n005 n006 n007 n008 n009 n010 
do
    rsh $i useradd –u $user_id –m $username
    rsh $i groupmod -g $group_id $username
done
##### 
