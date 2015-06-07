#!/bin/bash
DB_USER="testreadonly"
DB_PASS="test"
DB_NAME="test"
BACKUP_DIR="./backups/"
BACKUP_FILENAME="$DB_NAME-$(date +'%Y-%m-%d-%H:%M').gz"

declare -A SERVERS=(
	["http://yassine.dev/backup-api.php"]="5bfe0c405c67de32b1de9ea40d093666"
	["http://yassine2.dev/backup-api.php"]="1ce6d3f07a09f1b08ef98497f6003977"
)


BACKUP_FILE=$BACKUP_DIR$BACKUP_FILENAME
echo "Backing up $DB_NAME..."

mysqldump -u$DB_USER -p$DB_PASS  $DB_NAME | gzip -9 > $BACKUP_FILE
if [ -f $BACKUP_FILE ]; then
	for server in "${!SERVERS[@]}"; do
		echo "Uploading to $server..."
		echo -n $(curl -F "key=${SERVERS[$server]}" -F "file=@$BACKUP_FILE" $server)
	done
 fi
