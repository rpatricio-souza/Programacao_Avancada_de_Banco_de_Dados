--usar o sqlplus
--nao usar espaços e acentuação no nome dos objetos e diretórios
connect sys/fatec as sysdba;

--create directory UTL_FILE_TEST as 'c:\temp';
create directory UTL_FILE_TEST as 'D:\Docs\Fatec\Programacao_Avancada_de_Banco_de_Dados\atividades\UTL_FILE_TEST';

grant read, write on directory UTL_FILE_TEST to public;

grant execute on utl_file to public;

alter user hr identified by fatec;

alter user hr account unlock;

--usar o sql developer
--connectar como hr;

set serveroutput on;
declare
  v_line           varchar2(32767);
  c_location       constant varchar2(80) := 'UTL_FILE_TEST';
  c_filename       constant varchar2(80) := 'test.txt';
  v_handle         Utl_File.File_Type;


  procedure Show_Is_Open is begin
    case Utl_File.Is_Open ( file => v_handle )
      when true then Dbms_Output.Put_Line ( 'open' );
      else           Dbms_Output.Put_Line ( 'closed' );
    end case;

  end Show_Is_Open;

  procedure Put_Line is begin
    Utl_File.Put_Line (
      file     => v_handle,
      buffer   => 'Hello world',
     autoflush => false );

  end Put_Line;

begin

  v_handle := Utl_File.Fopen (
    location    => c_location,
    filename    => c_filename,
    open_mode   => 'w' /* write over any existing file with this name */,
    max_linesize => 32767 );

  Show_Is_Open;
  Put_Line;
  Utl_File.Fclose ( file => v_handle );

  Show_Is_Open;

exception
  when
    -- ORA-29287: invalid maximum line size
    Utl_File.Invalid_Maxlinesize
  then
    -- Fclose_All closes all open files for this session.
    -- It is for cleanup use only. File handles will not be cleared
    -- (Is_Open will still indicate they are valid)

    Utl_File.Fclose_All;
    Raise_Application_Error ( -20000, 'Invalid_Maxlinesize trapped' );

  when
    -- ORA-29282: invalid file ID
    Utl_File.Invalid_Filehandle
  then
    Utl_File.Fclose_All;
    Raise_Application_Error ( -20000, 'Invalid_Filehandle trapped' );
end;
/