#!/usr/bin/bash

# Hugh Brown
# Jan 9, 2014
#
# new_bart_hoemdir.sh: A Small but Useful(tm) utility to create a new
# home directory on Bart.

# Much help with parsing args from:
# http://rsalveti.wordpress.com/2007/04/03/bash-parsing-arguments-with-getopts/

usage() {
    cat << EOF
$0: A Small but Useful(tm) utility to create a new home directory on Bart.

usage: $0 options

OPTIONS:

   -u [arg]     User name
   -v           Verbose.
   -h           This helpful message.
EOF
    exit 1
}

complain_and_die() {
    echo $*
    exit 2
}

T_OPTION=
P_OPTION=
VERBOSE=
while getopts "u:vh" OPTION ; do
     case $OPTION in
         u) U=$OPTARG ;;
         v) set -x ;;
         h) usage ;;
         ?) usage ;;
     esac
done

# Check for mandatory args
if [ -z $U ]; then
     usage
fi

ZFS=/sbin/zfs
CHOWN=/usr/bin/chown
CHGRP=/usr/bin/chgrp

$ZFS create homepool/$U
$CHOWN $U /homepool/$U
$CHGRP pavlab /homepool/$U
$ZFS set quota=50G homepool/$U
