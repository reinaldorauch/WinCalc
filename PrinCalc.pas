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
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BtnIgualClick(Sender: TObject);
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
  InitVal: string = '';

  // Operador anterioo
  OpAnt: char = ' ';

  // Subtotal
  SubTotal: Extended = 0;

  // Se o igual foi pressionado
  OperIgual: Boolean = false;

implementation

{$R *.dfm}

procedure TFormCalc.BtnApagaClick(Sender: TObject);
begin
  if(
    // Caso  '0,'
    (LbVisor.Caption = ('0' + FormatSettings.DecimalSeparator))
    // Caso '-N'
    OR ((Length(LbVisor.Caption) = 2) AND (LbVisor.Caption[1] = '-'))
    // Caso '-0,'
    OR ((Length(LbVisor.Caption) = 3) AND (LbVisor.Caption[1] = '-')
      AND (LbVisor.Caption[2] = '0'))
    // É o último caractere do visor
    OR (Length(LbVisor.Caption) = 1)
  ) then
    begin
      LbVisor.Caption := InitVal;
      beep;
    end
  // Se o vizor não estiver vazio
  else if((LbVisor.Caption) <> '') then
    LbVisor.Caption := copy(LbVisor.Caption, 1, Length(LbVisor.Caption) - 1)
  else
    beep
end;

procedure TFormCalc.BtnIgualClick(Sender: TObject);
begin

  BtnOperadorClick(Sender);

  OpAnt := ' ';

  OperPress := false;

  MmPapel.Lines.Append('-----------------------');
  MmPapel.Lines.Append(LbVisor.Caption);

  OperIgual := true;

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
  SubTotal := 0;
  MmPapel.Lines.Clear();
  OpAnt := ' ';
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

    if(OperPress OR (LbVisor.Caption = '')) then
      beep
    else
      begin

        if(OperIgual) then
          begin
            SubTotal := 0;
            MmPapel.Lines.Append('');
            OperIgual := false;
          end;

        MmPapel.Lines.Add(LbVisor.Caption + ' ' + OpAnt);

        case OpAnt of
          '+',' ': SubTotal := SubTotal + strToFloat(LbVisor.Caption);
          '-': SubTotal := SubTotal - strToFloat(LbVisor.Caption);
          '*': SubTotal := SubTotal * strToFloat(LbVisor.Caption);
          '/': SubTotal := SubTotal / strToFloat(LbVisor.Caption);
          else 
            beep
        end;

        LbVisor.Caption := floatToStr(SubTotal);

        OpAnt := TSpeedButton(Sender).Caption[1];

        OperPress := true;

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

procedure TFormCalc.FormKeyPress(Sender: TObject; var Key: Char);
begin

  case Key of
    '0': BtnZeroClick(BtnZero);
    '1': BtnNumClick(BtnUm);
    '2': BtnNumClick(BtnDois);
    '3': BtnNumClick(BtnTres);
    '4': BtnNumClick(BtnQuatro);
    '5': BtnNumClick(BtnCinco);
    '6': BtnNumClick(BtnSeis);
    '7': BtnNumClick(BtnSete);
    '9': BtnNumClick(BtnNove);
    '+': BtnOperadorClick(BtnSoma);
    '-': BtnOperadorClick(BtnSub);
    '*': BtnOperadorClick(BtnMult);
    '/': BtnOperadorClick(BtnDiv);
    #9 : BtnApagaClick(BtnApaga);
    #13,'=': BtnOperadorClick(BtnIgual);
    'c','C': BtnLimpaClick(BtnLimpa);
    'i', 'I': BtnInverteClick(BtnInverte);
    '.': BtnPontoClick(BtnPonto);
  end;

end;

end.
