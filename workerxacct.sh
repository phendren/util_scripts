#        Copy Changes Account Backup/Rsync script by Phil H.
#			Designed specifically for cpanel servers
#			01/04/2014
#         ---------------------------------------------    
#
# Enter full path for LOCA_FILE variable but leave off ending slash
LOCA_FILE="enter absolute path location"
ls -l /var/cpanel/users | awk '{print $9}' | tail -n +3 > $LOCA_FILE/users.txt
BackServ="enter IP or hostname"
NOWT=`date +%Y-%m-%d`

echo "Building log and starting backup-sync for: $NOWT to: $BackServ ..." | tee /tmp/$NOWT-log.txt

while read bkuser
do
rsync -aP --exclude 'virtfs' /home/$bkuser -e ssh root@$BackServ:/backup/homedir/ | tee -a /tmp/$NOWT-log.txt
          echo "$bkuser completed....." | tee -a /tmp/$NOWT-log.txt
        fi
done < $LOCA_FILE/users.txt

# Uncomment for notifications 
# cat /tmp/$NOWT-log.txt | mail -s "Daily Backup Process Log" youremail@domain.com 

rm /tmp/$NOWT-log.txt # removing tmp log

