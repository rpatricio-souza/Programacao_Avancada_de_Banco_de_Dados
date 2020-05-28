create directory UTL_FILE_TEST as '/mnt/14F60716F606F82E/Docs/Fatec/Programacao_Avancada_de_Banco_de_Dados/atividades/UTL_FILE_TEST';

grant read, write on directory UTL_FILE_TEST to public;

grant execute on utl_file to public;

drop directory UTL_FILE_TEST;
