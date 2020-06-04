create table from_file(
    name varchar2(20),
    age number(3),
    birth date
);

set serveroutput on;

declare
  v_line           varchar2(32767);
  c_location       constant varchar2(80) := 'UTL_FILE_TEST';
  c_filename       constant varchar2(80) := '02_leitura.txt';
  v_handle         Utl_File.File_Type;
  
  linha varchar2(50); --Variavel que pega linha por linha do arquivo
  --Variaveis que serao utilizadas para inserir na tabela criada
  nome varchar2(20);
  idade number(3);
  nasc date;
  

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
    
    if(Utl_File.Is_Open(v_handle)) then
        loop
            begin
                --pega uma linha do arquivo por passada no loop
                utl_file.get_line(v_handle,linha);
                
                nome:=substr(linha,1,instr(linha,';')-1);
                idade:=to_number(substr(linha,instr(linha,';')+1,2));
                nasc:=to_date(substr(linha,instr(linha,';',1,2)+1,10),'dd/mm/yyyy');
                
                insert into from_file values(nome, idade, nasc);
                
                --Encerra a leitura quando nao encontra mais dados no arquivo
                exception
                    when no_data_found then
                        exit;
            end;
        end loop;
    end if;
    
    Utl_File.Fclose ( file => v_handle );
    Show_Is_Open;
end;
/

select * from from_file;