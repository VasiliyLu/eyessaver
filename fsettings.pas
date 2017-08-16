unit fSettings;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls;

type

  { TfmSettings }

  TfmSettings = class(TForm)
    Button1: TButton;
    Button2: TButton;
    edMinInt: TLabeledEdit;
    edSecInt: TLabeledEdit;
    Label1: TLabel;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure edMinIntKeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fmSettings: TfmSettings;

implementation

uses fblink;

{$R *.lfm}

{ TfmSettings }

procedure TfmSettings.Button1Click(Sender: TObject);
begin
  fmBlink.Interval := StrToInt(edMinInt.Text);
  fmBlink.HintTime := StrToInt(edSecInt.Text);
  fmBlink.TextMessage:=Memo1.Lines.Text;
  fmBlink.SaveSettings;
end;

procedure TfmSettings.edMinIntKeyPress(Sender: TObject; var Key: char);
begin
  if not (Key in ['0'..'9',#13,#8]) then Key := #0;
end;

procedure TfmSettings.FormShow(Sender: TObject);
begin
  edMinInt.Text := IntToStr(fmBlink.Interval);
  edSecInt.Text := IntToStr(fmBlink.HintTime);
  Memo1.lines.Text:=fmBlink.TextMessage;
end;

end.
