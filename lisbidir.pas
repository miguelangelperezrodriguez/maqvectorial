// LISTA ORDENADA Y DOBLEMENTE ENLAZADA

// Posible ampliacion con KEYS Y VALOR.
// Mejorable con CLASES.

unit lisbidir;

  interface
    uses tadelemb;
    type
      puntero=^nodo;
      nodo = record
        info: integer;
        ant,sig : puntero
      end;
      listaB = record
        prim,ulti : puntero
      end;

    procedure inicializar(var L : listaB);
    function vacia (L : listaB) : boolean;
    procedure insertar (var L:listaB;e : elementos);
    //procedure borrar (var L:listaB;c:tclave);
    //procedure buscarymodificar (var L:listaB;c:tclave;p:proceso;
    //                           var encontrado : boolean);
    procedure recorreras (L:listaB; p:proceso); // Ascendente
    procedure recorrerds (L:listaB; p:proceso); // Descendente
    procedure borrarprimero (var L:listaB);

implementation

  procedure borrarprimero (var L:listaB);
  var
    aborrar : puntero;
  begin
    if not vacia(L) then
      begin

        aborrar:=L.prim^.sig;

        L.prim:=L.prim^.sig^.sig;

        dispose(aborrar);

    end;
  end;

  procedure inicializar (var L:listaB);
    begin
      new(L.ulti); new(L.prim);
      with L.ulti^ do
        begin
          info :=maxclave;
          ant:=L.prim; sig:=nil
        end;
      with L.prim^ do
        begin
          ant:=nil; sig:=L.ulti;
          info:=minclave
        end;
    end;

  function vacia (L : listaB) : boolean;
  begin
    vacia:=L.ulti^.ant=L.prim;
  end;

  procedure recorreras (L:listaB; p:proceso); // Ascendente
  var
    actual:puntero;
  begin
    actual:=L.prim^.sig;
    while actual<>L.ulti do
      begin
        p(actual^.info);
        actual:=actual^.sig
      end;
  end;

  procedure recorrerds (L:listaB; p:proceso); // Descendente
  var
    actual:puntero;
  begin
    actual:=L.ulti^.ant;
    while actual<>L.prim do
      begin
        p(actual^.info);
        actual:=actual^.ant
      end;
  end;

{  procedure buscarymodificar (var L:listaB;c:tclave;p:proceso;
                             var encontrado:boolean);
  var
    actual :puntero;
  begin
    actual:=L.prim^.sig;
    while actual^.info < c do actual:=actual^.sig;
    encontrado:=(actual^.info=c) and (actual<>L.ulti);
    if encontrado then p(actual^.info)
  end;
}
  procedure insertar (var L:listaB;e : elementos);
    var nuevo, actual : puntero;
  begin
    actual:=L.ulti^.ant;
    while actual^.info>e do actual:=actual^.ant;
    new(nuevo);
    with nuevo^ do
      begin
        info:=e;
        ant:=actual;
        sig:=actual^.sig
      end;
    actual^.sig:=nuevo;
    nuevo^.sig^.ant:=nuevo;
  end;

  procedure borrar (var L:listaB);
    var
      actual : puntero;
    procedure bor(var L:puntero);
      begin
        L^.ant^.sig:=L^.sig;L^.sig^.ant:=L^.ant;
        dispose(L)
      end;
    begin
      actual:=L.prim^.sig;
      while actual^.info < c do actual:=actual^.sig;
      if actual^.info=c then bor(actual)
    end;
}
end.

