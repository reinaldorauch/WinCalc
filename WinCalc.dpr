program WinCalc;

uses
  Vcl.Forms,
  PrinCalc in 'PrinCalc.pas' {FormCalc};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormCalc, FormCalc);
  Application.Run;
end.
