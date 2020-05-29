set serveroutput on;
declare
  v_line           varchar2(32767);
  c_location       constant varchar2(80) := 'UTL_FILE_TEST';
  c_filename       constant varchar2(80) := '01_varrer_numeros.txt';
  v_handle         Utl_File.File_Type;
  
  v_pares          number(3,0);
  v_contador       number(3,0);


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
    open_mode   => 'w' /* write over any existing file with this name */,
    max_linesize => 32767 );

    Show_Is_Open;
    
    v_pares:=0;
    v_contador:=0;
    loop
        if(mod(v_contador,2)=0) then
            v_pares:=v_pares+1;
            Put_Line('Total de pares: '||v_pares);
            --dbms_output.put_line('Total de pares: '||v_pares);
        end if;
        v_contador:=v_contador+1;
        exit when v_contador>100;
    end loop;
    
    Utl_File.Fclose ( file => v_handle );
    Show_Is_Open;
end;
/