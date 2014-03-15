#        Worker Cross Server DB Backup script by Phil H.
#			Designed specifically for cpanel servers
#
#         ---------------------------------------------         #
mysql -e "show databases" | tail -n +3 > listnew.txt
#       List databases and strip off first 2 lines
while read dbname
do

        if [[ "$dbname" == *_* ]]
        then
                dirname=$(echo $dbname | cut -f1 -d"_")
                mysqldump $dbname > /home/$dirname/$dbname-wxdb.sql && chown $dirname:$dirname /home/$dirname/$dbname-wxdb.sql
                echo "$dbname is backed up into /home/$dirname";
        fi
done < listnew.txt
~                          
