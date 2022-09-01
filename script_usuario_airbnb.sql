/*crear usuario*/
CREATE USER airbnb
IDENTIFIED BY 123456;

/* privilegios del usuario */
GRANT create session, create table,
      create sequence, create view
TO airbnb;


