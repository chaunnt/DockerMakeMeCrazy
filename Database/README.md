# Create Database and user command

## SFTP USER
useradd -d <folder path> -s /bin/bash <username>
passwd <username>
chmod ugo+rwx -R <folder path>

## Postgre
Connect by psql and run commands:

CREATE DATABASE <db-name>;

\connect <db-name>;

CREATE USER <user> WITH PASSWORD '<password>';

ALTER DATABASE <db-name> OWNER TO <user>;

## Mysql

CREATE DATABASE <db-name>;

CREATE USER "username" IDENTIFIED BY "password";

GRANT ALL privileges ON <db-name>.* TO "username"@"%";

⇒ read/write permission only

GRANT ALL privileges ON <db-name>.* TO "<username>"@"%";
==> all permission

GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,ALTER ON <db-name>.* TO "<username>"@"%";
==> 1 vài quyền

GRANT SELECT,INSERT,UPDATE,DELETE,CREATE ON <db-name>.* TO "<username>"@"%";

ALTER USER "<username>" IDENTIFIED WITH mysql_native_password BY "<password>";

FLUSH PRIVILEGES; 

## MongoDB

$ mongo --host 192.168.45.6:27017 -u root -p

use <database-name>

db.createUser(
 {
   user: "hodaceread",
   pwd: "hodacereadpass",
   roles: [ { role: "read", db: "admin" } ]
 }
) 

db.createUser(
 {
   user: "vaylongbinhuser",
   pwd: "vaylongbinhuserpass",
   roles: [ { role: "readWrite", db: "vaylongbinh" } ]
 }
) 

db.updateUser(
   "hodacedev",
   {
     roles: [ { role: "readWrite", db: "hodace_dev" } ]
   }
)

db.dropUser("hodacedev", {w: "majority", wtimeout: 5000})


