// LISTA CONTIGUA. ARRAY
unit tadlistadinamica;
  interface
    uses tadelem,OperacionesMaquina;
    type
      lista = ^nodo;
      nodo = record
        info : elementos;
        pResto : lista;
      end;
    procedure ListaVacia(var L:Lista);
    function Vacia(L:Lista):boolean;
    procedure Primero(L:Lista;var x:elementos);
    procedure Insertar(x:elementos;var L:Lista);
    procedure Resto(var L:Lista);
    procedure Modificar(x:elementos;var L:Lista);
    // Recorrer añadido
    procedure RecorrerLDinamica (L:lista);

  implementation
    var
      pUltimo : ^nodo;
    procedure ListaVacia(var L:Lista);
    begin
      L:=nil;
      pUltimo:=nil;
    end;
    function Vacia(L:Lista):boolean;
    begin
      Vacia:=L=nil;

    end;
    procedure Primero(L:Lista;var x:elementos);
    begin
      if not Vacia(L) then x:=L^.info
    end;
    procedure Insertar(x: elementos;var L:Lista);
      var
        aux:lista;
      begin
        new(aux);
        with aux^ do
          info:=x;
        if Vacia(L) then
        begin
          aux^.pResto:=nil;
          pUltimo:=aux;
          L:=aux;
        end
        else
        begin
          pUltimo^.pResto:=aux;
          pUltimo:=aux;
        end;
      end;
      // Devuelve la lista sin el primer elemento.
      procedure Resto (var L:Lista);
        var
          aux:lista;
        begin
          aux:=L; L:=L^.pResto;
          dispose(aux);
        end;

      procedure Modificar (x:elementos;var L:Lista);
        begin
          if not Vacia(L) then
            L^.info:=x;
        end;

      procedure RecorrerLDinamica (L:lista);
      var
        aux : lista;
        saccion : string;
        op : string;
        dato : elementos;
        nro : integer;
      begin
        if Vacia(L) then exit;
        aux:=L;
        saccion:=aux^.info;

        descomponer(saccion,op,dato);
        nro := nroFuncion(op);

        ejecutarOpMaquina (nro,dato);

        aux:=aux^.pResto;
        while aux<>nil do
        begin
           aux:=aux^.pResto;
           saccion:=aux^.info;
           descomponer(saccion,op,dato);
           nro:=nroFuncion(op);
           ejecutarOpMaquina(nro,dato);
        end;
      end;

end.

