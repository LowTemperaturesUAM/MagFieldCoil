program Coils;

uses
  Forms,
  Magnet in 'Magnet.pas' {Form1},
  xyyGraph in '..\..\..\Programming\xyyGraph\xyyGraph.pas' {xyyGraphForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TxyyGraphForm, xyyGraphForm);
  Application.Run;
end.
