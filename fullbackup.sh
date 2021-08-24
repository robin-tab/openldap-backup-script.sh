!/bin/bash
# backup script
# ROD 11 May 2016

HOSTNAME=$(hostname -f)
DATE=$(date +%a-%d-%b-%Y)
FILENAME=$HOSTNAME-$DATE.tar.gz
LOCALDIR=/backups
REMOTEDIR=/mnt/backups
LOG=/tmp/backuplog.txt
FILELOG=/tmp/filelog.txt
DAYOFWEEK=$(date +%u)


/bin/mkdir $LOCALDIR > /dev/null 2>&1

/bin/mkdir $REMOTEDIR > /dev/null 2>&1

/bin/mount -t nfs IPADDRESS:/volume1/serverbackups $REMOTEDIR  > /dev/null 2>&1   

/bin/tar -zcvpf $LOCALDIR/$FILENAME --directory=/ --exclude=proc --exclude=*tar --exclude=*gz --exclude=media --exclude=sys --exclude=dev/pts --exclude=backups --exclude=mnt . > $FI
LELOG

/bin/mv $LOCALDIR/$FILENAME $REMOTEDIR

/bin/ls $REMOTEDIR/* |  grep $DATE > $LOG

if [ "$DAYOFWEEK" == 4 ];  then     

NUMBERFILES=$(/usr/bin/wc $LOG | awk '{print $1}')

mail -s "$NUMBERFILES Linux server backups for $DATE" NAME@DOMAIN.COM < $LOG ;

else : ; 

fi

#/bin/umount $REMOTEDIR  > /dev/null 2>&1

exit 0
