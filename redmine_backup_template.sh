# !/bin/bash
# データベースのパスワード、転送先ユーザー名、転送先IPについては適宜変更してお使い下さい
# bitnami redmineでのインストール前提です

# database backup
/opt/redmine-3.4.3-1/mysql/bin/mysqldump -u bitnami -pデータベースのパスワード bitnami_redmine > /home/redmine/redmine_backup.sql
# redmine files backup
zip -r /home/redmine/redmine_files.zip /opt/redmine-3.4.3-1/apps/redmine/htdocs/files

# Transfer SQL file to file server
scp -i ~/.ssh/id_rsa -r /home/redmine/redmine_backup.sql 転送先ユーザー名@転送先IP:/home/samba/share/98.backup/redmine/sql/redmine_backup_`date "+%Y%m%d_%H%M%S"`.sql
# Transfer Attachment file to file server
scp -i ~/.ssh/id_rsa -r /home/redmine/redmine_files.zip 転送先ユーザー名@転送先IP:/home/samba/share/98.backup/redmine/files/redmine_files_`date "+%Y%m%d_%H%M%S"`.zip

#delete backup files.
rm /home/redmine/redmine_backup.sql
rm /home/redmine/redmine_files.zip

echo "redmine backup finish!"
