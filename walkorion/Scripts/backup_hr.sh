#!/bin/bash

SOURCE="/home/Firma/data/hr_files"
DEST="/home/Firma/data/backups"
DATE=$(date +%F_%H-%M)
FILENAME="hr_backup_$DATE.tar.gz"

#DALI POSTOI SOURCE FOLDER
if [ ! -d "$SOURCE" ]; then
	echo "Greska: Folderot $SOURCE ne postoi!"
	exit 1
fi

#2. PRAVENJE backup i kompresija (tar + gzip)
echo "Zapocnuvam backup na $SOURCE..."
tar -czf $DEST/$FILENAME $SOURCE

#3. Brisenje na stari backups (postari od 7 dena)
echo "Chistenje na stari backups..."
find $DEST -name "hr_backup_*.tar.gz" -mtime +7 -exec rm {} \;

echo "Backup e uspeshno zavrshen: $FILENAME"


