set serveroutput on;


create sequence blob_test_seq
increment by 1;
--drop sequence blob_test_seq;

create table blob_test(
    id number(4) constraint blob_test_pk primary key,
    my_blob blob
);


CREATE OR REPLACE PROCEDURE BLOB_LOAD (pc_file varchar2)
as

    lBlob  BLOB;
    lFile  BFILE := BFILENAME('UTL_FILE_BLOB', pc_file);

begin

    insert into blob_test (id, my_blob)
    values (BLOB_TEST_SEQ.nextval, empty_blob())
    returning my_blob into lBlob;


    DBMS_LOB.OPEN(lFile, DBMS_LOB.LOB_READONLY);

    DBMS_LOB.OPEN(lBlob, DBMS_LOB.LOB_READWRITE);

    DBMS_LOB.LOADFROMFILE(DEST_LOB => lBlob,
                          SRC_LOB  => lFile,
                          AMOUNT   => DBMS_LOB.GETLENGTH(lFile));


    dbms_output.put_line('O tamanho do arquivo inserido é de: ' || DBMS_LOB.GETLENGTH(lFile) || ' bytes');

    DBMS_LOB.CLOSE(lFile);
    DBMS_LOB.CLOSE(lBlob);

    COMMIT;

END;
/

exec blob_load('DB.png');
exec blob_load('fatecSJC.jpg');
exec blob_load('bridge.jpg');

select id "Identificador", dbms_lob.getlength(my_blob) "Tamanho do Arquivo (bytes)"
from blob_test
order by id;
