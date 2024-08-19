// ARRIERISMO .
// Lista : VI
// Pila : VII
//Las listas son 13,14,15.

// TODO :
// OPERACION # PARA CAMBIAR ENTRE CANALES. (VARIAS LISTASTITERES).

// TODO :
// USAR STREAM PARA LA MAQUINA

unit frmPrincipal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
           TADOperPILA;

type

  { TForm1 }



  TForm1 = class(TForm)
    Button1: TButton;
    Button3: TButton;
    Button4: TButton;
    Edit2: TEdit;
    Label2: TLabel;
    Memo1: TMemo;
    Memo2: TMemo;
    Memo3: TMemo;
  // PARA CONECTAR A GUI POR EVENTOS.
  // ************************************
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

var
  // VARIABLES QUE USA LA TADPILA
  vsuma :     integer;


{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
//var
//  texto : string;
begin
  //Str(vsuma,texto);
  //Edit1.Text:=texto;
end;

// INSTRUCCION

// ESTAS INSTRUCCIONES PODRIAN PONERSE EN UNA UNIDAD QUE CONTROLARA
// LA DE TADPILA.

procedure TForm1.Button3Click(Sender: TObject);
var
  respuesta : string;
begin
  respuesta:=EjecutarAccion(Edit2.Text);
  if Length(respuesta)>0 then
     Memo1.Lines.Add(respuesta);
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  i : integer;
  respuestas : TStringList;
  streamAMaquina : TMemoryStream;
begin
  streamAMaquina:=TMemoryStream.Create;
  Memo3.Lines.SaveToStream(streamAMaquina);
  streamAMaquina.Position:=0;
  EjecutarAcciones(streamAMaquina,respuestas);
  // Mostramos las respuestas
  for i:=0 to respuestas.Count-1 do
      Memo1.Lines.Append(respuestas[i]);
  // Liberamos
  streamAMaquina.Free;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  Memo1.Lines.Clear;
end;

end.


