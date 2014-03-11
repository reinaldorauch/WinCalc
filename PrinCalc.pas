unit PrinCalc;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons;

type
  TFormCalc = class(TForm)
    LbVisor: TLabel;
    Panel1: TPanel;
    Panel3: TPanel;
    BtnApaga: TSpeedButton;
    BtnSoma: TSpeedButton;
    BtnInverte: TSpeedButton;
    BtnSub: TSpeedButton;
    BtnMult: TSpeedButton;
    MmPapel: TMemo;
    BtnLimpa: TSpeedButton;
    BtnDiv: TSpeedButton;
    BtnIgual: TSpeedButton;
    BtnUm: TSpeedButton;
    BtnDois: TSpeedButton;
    BtnTres: TSpeedButton;
    BtnCinco: TSpeedButton;
    BtnSeis: TSpeedButton;
    BtnQuatro: TSpeedButton;
    BtnOito: TSpeedButton;
    BtnNove: TSpeedButton;
    BtnSete: TSpeedButton;
    BtnPonto: TSpeedButton;
    BtnZero: TSpeedButton;
    procedure BtnNumClick(Sender: TObject);
    procedure BtnOperadorClick(Sender: TObject);
    procedure BtnZeroClick(Sender: TObject);
    procedure BtnApagaClick(Sender: TObject);
    procedure BtnPontoClick(Sender: TObject);
    procedure BtnInverteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnLimpaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCalc: TFormCalc;
  // Valor inicial: false
  OperPress: Boolean;

  // Valor inicial da calculadora padrão
  InitVal: string = '0';

implementation

{$R *.dfm}

procedure TFormCalc.BtnApagaClick(Sender: TObject);
begin
  if((LbVisor.Caption = ('0' + FormatSettings.DecimalSeparator))
    OR ((Length(LbVisor.Caption) = 2) AND (LbVisor.Caption[1] = '-'))
    OR (Length(LbVisor.Caption) = 1)) then
    begin
      LbVisor.Caption := InitVal;
      beep;
    end
  else if(Length(LbVisor.Caption) > 0) then
    LbVisor.Caption := copy(LbVisor.Caption, 1, Length(LbVisor.Caption) - 1)
  else
    beep
end;

procedure TFormCalc.BtnInverteClick(Sender: TObject);
var
  valor: double;
begin
  if((Length(LbVisor.Caption) <= 13) AND (Length(LbVisor.Caption) > 0)) then
    begin
      valor := strToFloat(LbVisor.Caption);

      if (valor <> 0.0) then
        LbVisor.Caption := floatToStr(valor * -1);
    end
  else
    beep
end;

procedure TFormCalc.BtnLimpaClick(Sender: TObject);
begin
  LbVisor.Caption := InitVal;
  OperPress := false;
  MmPapel.Text := '';
end;

procedure TFormCalc.BtnNumClick(Sender: TObject);
begin
    if(NOT OperPress) then
        if (LbVisor.Caption = InitVal) then
            LbVisor.Caption := TSpeedButton(Sender).Caption
        else if(length(LbVisor.Caption) <= 13) then
            LbVisor.Caption := LbVisor.Caption + TSpeedButton(Sender).Caption
        else
            beep
    else
      begin
          LbVisor.Caption := TSpeedButton(Sender).Caption;
          OperPress := false;
      end;
end;

procedure TFormCalc.BtnOperadorClick(Sender: TObject);
begin        
    OperPress := true;

    case TSpeedButton(Sender).Name of
      'BtnSoma': begin  
        {
          Soma
        }
      end;
      'BtnSub': begin
        {
          Subtrai
        }
      end;
      'BtnMult': begin
        {
          Multiplica
        }
      end;
      'BtnDiv': begin
        {
          Divide
        }
      end;
    end;
end;

procedure TFormCalc.BtnPontoClick(Sender: TObject);
begin
  if(Pos(FormatSettings.DecimalSeparator, LbVisor.Caption) <> 0) then
    begin
      beep;
    end
  else
    begin
      if(OperPress OR (LbVisor.Caption = InitVal)) then
        LbVisor.Caption := '0' + FormatSettings.DecimalSeparator
      else if (Length(LbVisor.Caption) <= 13) then
        LbVisor.Caption := LbVisor.Caption + FormatSettings.DecimalSeparator
    end;
end;

procedure TFormCalc.BtnZeroClick(Sender: TObject);
begin
  if(OperPress OR (LbVisor.Caption = InitVal)) then
    begin
      beep;
    end
  else
    begin
      if (Length(LbVisor.Caption) <= 13) then
        LbVisor.Caption := LbVisor.Caption + '0'
      else
        beep;
    end;
end;

procedure TFormCalc.FormCreate(Sender: TObject);
begin
  BtnPonto.Caption := FormatSettings.DecimalSeparator;
  LbVisor.Caption := InitVal;
end;

end.
