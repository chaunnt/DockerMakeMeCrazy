# Create Database and user command

## SFTP USER
useradd -d <folder path> -s /bin/bash <username>
passwd <username>

## Postgre
Connect by psql and run commands:

CREATE DATABASE <db-name>;

\connect <db-name>;

CREATE USER <user> WITH PASSWORD '<password>';

ALTER DATABASE <db-name> OWNER TO <user>;

## Mysql

CREATE DATABASE <db-name>;

CREATE USER "<username>" IDENTIFIED BY "<password>";

GRANT USAGE ON *.* TO "<username>"@"%";

=> full permission 

GRANT ALL privileges ON <db-name>.* TO "<username>"@"%";

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
   user: "hodacedev",
   pwd: "hodacedevpass",
   roles: [ { role: "readWrite", db: "hodace_dev" } ]
 }
) 
