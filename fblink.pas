unit fblink;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls;

type

  { TfmBlink }

  TfmBlink = class(TForm)
    Label1: TLabel;
    Panel1: TPanel;
    Timer1: TTimer;
    Timer2: TTimer;
    TrayIcon1: TTrayIcon;
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
  private
    { private declarations }
    FLast: integer;
    FInterval: integer; //min
    procedure SetInterval(AValue: integer);
  public
    { public declarations }
    property Interval: integer read FInterval write SetInterval;
  end;

var
  fmBlink: TfmBlink;

implementation

{$R *.lfm}

{ TfmBlink }

procedure TfmBlink.Timer1Timer(Sender: TObject);
begin
  //показать окно
  Show;
  Timer2.Enabled:=true;
end;

procedure TfmBlink.Timer2Timer(Sender: TObject);
begin
  if self.Showing then
    Hide;
  Timer2.Enabled:= false;

end;

procedure TfmBlink.SetInterval(AValue: integer);
begin
  if FInterval=AValue then Exit;
  FInterval:=AValue;
  self.Timer1.Interval:=AValue *1000*60;
end;

end.

