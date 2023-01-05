CREATE DATABASE nnhshalfcaf;
CREATE USER 'halfcafmysql'@'%' identified by 'halfcafwebappadmins123'; 
GRANT ALL PRIVILEGES on nnhshalfcaf.* to 'halfcafmysql'@'%';
FLUSH PRIVILEGES;
use nnhshalfcaf;

