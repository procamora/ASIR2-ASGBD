CREATE USER 'user'@'localhost' IDENTIFIED BY 'password'; 

GRANT ALL PRIVILEGES ON *.* TO 'user'; 
GRANT SELECT, INSERT ON *.* TO 'password'@'localhost' IDENTIFIED BY 'password';
