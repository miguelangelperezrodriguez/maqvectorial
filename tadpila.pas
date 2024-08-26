// PILA DE OPERACIONES.

unit TADPila;

interface

  uses sysutils,tadelem,tadlistadinamica;

  type
    pila=^nodo;
    nodo=record
      info : string;
      cimanant : pila;
    end;



    procedure PilaVacia (var p : pila);
    function Vacia (p : pila) : boolean;
    procedure Apilar (var p : pila;c : string);
    procedure Desapilar (var p:pila);
    function Cima (p:pila) : string;

    procedure PonerTamanyoListas (t : integer);
    procedure PonerListaActual (la : integer);
    function ObtenerListaActual() : integer;

    procedure RecorrerL ();
    procedure BorrarL ();

// Ampliable a más listas titeres.
var
  listatitere : array of lista;
  listaactual : integer;

implementation

  procedure RecorrerL ();
  begin
    RecorrerLDinamica(listatitere[listaactual]);
  end;

  procedure BorrarL ();
  begin
    ListaVacia(listatitere[listaactual]);
  end;

  procedure PonerTamanyoListas (t : integer);
  begin
    SetLength(listatitere,t);
  end;

  procedure PonerListaActual (la : integer);
  begin
    if (la>0) and (la<Length(listatitere)) then
      listaactual:=la;
  end;

  function ObtenerListaActual() : integer;
  begin
    ObtenerListaActual:=listaactual;
  end;

  procedure PilaVacia (var p : pila);
  begin
    p:=nil;
    ListaVacia(listatitere[listaactual]);
  end;

  function Vacia (p:pila) : boolean;
  begin
    Vacia:=p=nil
  end;

  {procedure ejecutar(comando : string);
  var
    operacion:char;
    operador : elementos;
  begin
     descomponer(comando,operacion,operador);

     case operacion of
       '+' :
         Insertar(operador,listatitere[listaactual]);

     end;
  end;}

  procedure Apilar (var p : pila;c : string);
  var
    aux : pila;
  begin
    new(aux);
    with aux^ do
      begin
        info:=c;
        cimanant:=p;
      end;
    p:=aux;
    Insertar(c,listatitere[listaactual]);
  end;

  procedure Desapilar (var p : pila);
    var
      aborrar : pila;
    begin
      aborrar:=p;p:=p^.cimanant;
      Dispose(aborrar);
    end;

  function Cima (p : pila) : string;
    begin
      Cima:=p^.info;
    end;

end.

