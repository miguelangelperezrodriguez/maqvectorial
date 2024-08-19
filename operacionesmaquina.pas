unit OperacionesMaquina;

interface

uses tadelem,SysUtils;

const Noperaciones = 3;

type
  tdescoperacion = record
                     optexto : string;
                     accion : proc;
  end;

  tlistaoperaciones = array [1..Noperaciones] of tdescoperacion;

var
  // Valores de salida de las operaciones
  vsuma : integer;
  listaoperaciones : tlistaoperaciones;

procedure mostrar (var e:elementos);

procedure suma (var e:elementos);
procedure suma1 (var e:elementos);
procedure suma2 (var e:elementos);

procedure descomponer (comando : string;var op : string;var dato : elementos);
function nroFuncion (op : string) : integer;
procedure ejecutarOpMaquina (nro : integer; dato : elementos);

implementation



// OPERACIONES DE LA MAQUINA

procedure mostrar (var e:elementos);
begin
  Writeln(e:5);
end;

procedure suma (var e:elementos);
begin
  vsuma:=vsuma+StrToInt(e);
end;

procedure suma1 (var e:elementos);
begin
  vsuma:=vsuma+2;
end;

procedure suma2 (var e:elementos);
begin
  vsuma:=vsuma+3;
end;

function OperacionValida(oper : string) : boolean;
  var
    i : integer;
    opvalida:  boolean;
  begin
    opvalida:=false;
    for i:=1 to Noperaciones do
      if (oper=listaoperaciones[i].optexto) then
      begin
        opvalida:=true;
        break;
      end;
    OperacionValida:=opvalida;
  end;

  procedure descomponer (comando : string;var op : string;var dato : elementos);
  var
    saux : TStringArray;
    bok  : boolean;
  begin
    saux:=comando.Split(' ');
    if OperacionValida(saux[0]) then
    begin
      op:=saux[0];
      dato:=saux[1];
    end;
  end;

 function nroFuncion (op : string) : integer;
 var
   i :integer;
 begin
  for i:=1 to 3 do
    if op=listaoperaciones[i].optexto then
      Result:=i;
 end;

 procedure ejecutarOpMaquina (nro : integer; dato : elementos);
 var
   accion : proc;
 begin
   accion:=listaoperaciones[nro].accion;
   accion(dato);
 end;

begin
  listaoperaciones[1].optexto:='+';
  listaoperaciones[1].accion:=@suma;
  listaoperaciones[2].optexto:='++';
  listaoperaciones[2].accion:=@suma1;
  listaoperaciones[3].optexto:='+++';
  listaoperaciones[3].accion:=@suma2;

end.

