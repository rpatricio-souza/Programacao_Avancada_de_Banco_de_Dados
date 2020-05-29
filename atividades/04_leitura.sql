set serveroutput on;
declare
  v_line           varchar2(32767);
  c_location       constant varchar2(80) := 'UTL_FILE_TEST';
  c_filename       constant varchar2(80) := '02_leitura.txt';
  v_handle         Utl_File.File_Type;
  

  procedure Show_Is_Open is begin
    case Utl_File.Is_Open ( file => v_handle )
      when true then Dbms_Output.Put_Line ( 'open' );
      else           Dbms_Output.Put_Line ( 'closed' );
    end case;

  end Show_Is_Open;

  procedure Put_Line(str varchar2) is begin
    Utl_File.Put_Line (
      file     => v_handle,
      buffer   => str,
     autoflush => false );

  end Put_Line;

begin

    v_handle := Utl_File.Fopen (
    location    => c_location,
    filename    => c_filename,
    open_mode   => 'r' /* write over any existing file with this name */,
    max_linesize => 32767 );

    Show_Is_Open;
    
    
    
    Utl_File.Fclose ( file => v_handle );
    Show_Is_Open;
end;
/