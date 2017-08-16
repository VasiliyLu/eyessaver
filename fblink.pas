unit fblink;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Menus, ComCtrls, Registry;

type

  { TfmBlink }

  TfmBlink = class(TForm)
    Label1: TLabel;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    Panel1: TPanel;
    PopupMenu1: TPopupMenu;
    ProgressBar1: TProgressBar;
    Timer1: TTimer;
    tmrHintTime: TTimer;
    TrayIcon1: TTrayIcon;
    procedure FormCreate(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure tmrHintTimeTimer(Sender: TObject);
    procedure TrayIcon1Click(Sender: TObject);
  private
    FHintTime: integer; //sec
    FHintTimeAcc: integer;
    { private declarations }
    //FLast: integer;
    FInterval: integer; //min
    FTextMessage: string;
    procedure LoadSettings;

    procedure SetHintTime(AValue: integer);
    procedure SetInterval(AValue: integer);
    procedure SetTextMessage(AValue: string);
  public
    { public declarations }
    property Interval: integer read FInterval write SetInterval;
    property HintTime: integer read FHintTime write SetHintTime;
    property TextMessage: string read FTextMessage write SetTextMessage;
    procedure SaveSettings;
    procedure ShowScreen;
  end;

var
  fmBlink: TfmBlink;

implementation

uses
  fsettings;

{$R *.lfm}

{ TfmBlink }

procedure TfmBlink.Timer1Timer(Sender: TObject);
begin
  self.ShowScreen;
end;

procedure TfmBlink.MenuItem1Click(Sender: TObject);
var
  f: TForm;
begin
  f := TfmSettings.Create(nil);
  f.ShowModal;
  f.Free;
end;

procedure TfmBlink.MenuItem2Click(Sender: TObject);
begin
  Close;
end;

procedure TfmBlink.MenuItem3Click(Sender: TObject);
begin
  ShowScreen;
end;

procedure TfmBlink.Label1Click(Sender: TObject);
begin
  Hide;
end;

procedure TfmBlink.FormCreate(Sender: TObject);
begin
  Interval := 30;
  HintTime := 10;
  TextMessage := 'Посмотри по сторонам :)';
  LoadSettings;
end;

procedure TfmBlink.tmrHintTimeTimer(Sender: TObject);
begin

  Inc(FHintTimeAcc);
  if (FHintTimeAcc = FHintTime) then
  begin
    tmrHintTime.Enabled := False;
    FHintTimeAcc := 0;
    if fsVisible in self.FormState then
      Hide;
  end;
  ProgressBar1.Position := trunc(FHintTimeAcc / FHintTime * 100);
end;

procedure TfmBlink.TrayIcon1Click(Sender: TObject);
begin
  fmBlink.TrayIcon1.ShowBalloonHint;
end;

procedure TfmBlink.LoadSettings;
var
  r: TRegistry;
begin
  r := TRegistry.Create;
  try
    r.RootKey := HKEY_CURRENT_USER;
    r.OpenKeyReadOnly('SOFTWARE\Vasliy\eyesaver');
    if r.ValueExists('Interval') then
      Interval := r.ReadInteger('Interval');
    if r.ValueExists('HintTime') then
      HintTime := r.ReadInteger('HintTime');
    if r.ValueExists('TextMessage') then
      TextMessage := r.ReadString('TextMessage');

  finally
    r.Free;
  end;
end;

procedure TfmBlink.SaveSettings;
var
  r: TRegistry;
begin
  r := TRegistry.Create;
  try
    r.RootKey := HKEY_CURRENT_USER;
    r.OpenKey('SOFTWARE\Vasliy\eyesaver', True);
    r.WriteInteger('Interval', Interval);
    r.WriteInteger('HintTime', HintTime);
    r.WriteString('TextMessage', TextMessage);
  finally
    r.Free;
  end;
end;

procedure TfmBlink.SetInterval(AValue: integer);
begin
  if FInterval = AValue then
    Exit;
  FInterval := AValue;
  self.Timer1.Interval := AValue * 1000 * 60;
end;

procedure TfmBlink.SetTextMessage(AValue: string);
begin
  if FTextMessage = AValue then
    Exit;

  FTextMessage := AValue;
  Label1.Caption := AValue;
end;

procedure TfmBlink.ShowScreen;
begin
  ProgressBar1.Position := 0;
  FHintTimeAcc := 0;
  tmrHintTime.Enabled := True;
  //показать окно
  Show;
end;

procedure TfmBlink.SetHintTime(AValue: integer);
begin
  if FHintTime = AValue then
    Exit;
  FHintTime := AValue;
  //tmrHintTime.Interval:=AValue *1000;
end;

end.
