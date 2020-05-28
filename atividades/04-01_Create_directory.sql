--esses comandos devem ser usados pelo usuario SYS com atribuicao SYSDBA

create directory UTL_FILE_TEST as 'D:\Docs\Fatec\Programacao_Avancada_de_Banco_de_Dados\atividades\UTL_FILE_TEST';

grant read, write on directory UTL_FILE_TEST to public;

grant execute on utl_file to public;

--drop directory UTL_FILE_TEST;
