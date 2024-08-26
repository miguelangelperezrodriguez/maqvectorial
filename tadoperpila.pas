unit TADOperPILA;

interface

uses
  Classes, SysUtils,TADPila,tadelem,OperacionesMaquina;

  function  EjecutarAccion (textoaccion : string) : string;
  procedure EjecutarAcciones (textoacciones : TMemoryStream;var salida : TStringList);

// Ampliable a más listas titeres.

var
  pilaoperaciones : pila;


implementation

  procedure descomponerPrincipal (comando : string;var op : char;var dato : integer);
    var
      saux : string;
    begin
      try
        op:=comando[1];

        if (op<>'*') and (op<>'#') then
          exit;

        saux:=(copy(comando,2,Length(comando)-1));
        dato:=StrToInt(saux);
      finally
      end;
    end;

  function EjecutarAccion (textoaccion : string) : string;
  var
    operacion : string;
    texto : string;
    accion  : char;
    valor : integer;
    nrolista : integer;
  begin
    operacion:=textoaccion;

    if operacion='@' then
      begin
       vsuma:=0;
       PilaVacia(pilaoperaciones);
       exit;
      end;
    if operacion='?' then
      begin
        vsuma:=0;

        nrolista:=ObtenerListaActual();

        RecorrerL();

        Str(vsuma,texto);
        EjecutarAccion:=texto;

        exit;
      end;
    if operacion='¿' then
      begin
        vsuma:=0;

        nrolista:=ObtenerListaActual();
        RecorrerL();

        Str(vsuma,texto);
        EjecutarAccion:=texto;

        BorrarL();
        exit;
      end;
      descomponerPrincipal(operacion,accion,valor);
      if accion='*' then
        begin
          PonerTamanyoListas(valor);
          exit;
        end;
      if accion='#' then
        begin
          // Nos ajustamos al cero.
          PonerListaActual(valor-1);
          exit;
        end;

      Apilar(pilaoperaciones,operacion);
    end;

procedure EjecutarAcciones (textoacciones : TMemoryStream;var salida : TStringList);
var
  acciones : TStringList;
  accion   : string;
  i : integer;
  resp : string;
begin
  salida:=TStringList.Create;
  acciones:=TStringList.Create;
  acciones.LoadFromStream(textoacciones);
  for i:=0 to (acciones.Count-1) do
  begin
    accion:=acciones[i];
    resp:=EjecutarAccion(accion);
    if Length(resp)>0 then
       salida.Append(resp);
  end;
end;

begin
  PonerTamanyoListas(3);
  PilaVacia(pilaoperaciones);
end.

