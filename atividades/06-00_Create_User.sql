---------------------
-- CRIA TABLESPACE --
---------------------

CREATE TABLESPACE  TS_BLOB
DATAFILE  'D:\Docs\Fatec\Programacao_Avancada_de_Banco_de_Dados\atividades\TS_BLOB.dbf' SIZE 1M
AUTOEXTEND ON;

------------------
-- CRIA USUÁRIO --
------------------

CREATE USER USER_BLOB
IDENTIFIED BY aluno
DEFAULT TABLESPACE TS_BLOB
TEMPORARY TABLESPACE TEMP
QUOTA UNLIMITED ON TS_BLOB;

-----------------
-- PRIVILÉGIOS --
-----------------

GRANT DBA TO USER_BLOB WITH ADMIN OPTION;