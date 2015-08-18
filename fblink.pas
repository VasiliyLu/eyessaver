unit fblink;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Menus, Registry;

type

  { TfmBlink }

  TfmBlink = class(TForm)
    Label1: TLabel;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    Panel1: TPanel;
    PopupMenu1: TPopupMenu;
    Timer1: TTimer;
    Timer2: TTimer;
    TrayIcon1: TTrayIcon;
    procedure FormCreate(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure TrayIcon1Click(Sender: TObject);
  private
    FHintTime: integer;
    { private declarations }
    //FLast: integer;
    FInterval: integer; //min
    procedure LoadSettings;

    procedure SetHintTime(AValue: integer);
    procedure SetInterval(AValue: integer);
  public
    { public declarations }
    property Interval: integer read FInterval write SetInterval;
    property HintTime: integer read FHintTime write SetHintTime;
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

procedure TfmBlink.FormHide(Sender: TObject);
begin
   Timer2.Enabled:= false;
end;

procedure TfmBlink.FormCreate(Sender: TObject);
begin
  Interval:=30;
  HintTime:=10;
  LoadSettings;
end;

procedure TfmBlink.Timer2Timer(Sender: TObject);
begin
  if  fsVisible in self.FormState then
    Hide;
end;

procedure TfmBlink.TrayIcon1Click(Sender: TObject);
begin
  fmBlink.TrayIcon1.ShowBalloonHint;
end;

procedure TfmBlink.LoadSettings;
var
  r: TRegistry;
begin
  r:= TRegistry.Create;
  try
    r.RootKey:=HKEY_CURRENT_USER;
    r.OpenKeyReadOnly('SOFTWARE\Vasliy\eyesaver');
    try
    Interval := r.ReadInteger('Interval');
    HintTime := r.ReadInteger('HintTime');
    except

    end;
  finally
    r.free;
  end;
end;

procedure TfmBlink.SaveSettings;
var
  r: TRegistry;
begin
  r:= TRegistry.Create;
  try
    r.RootKey:=HKEY_CURRENT_USER;
    r.OpenKey('SOFTWARE\Vasliy\eyesaver',true);
    r.WriteInteger('Interval',Interval);
    r.WriteInteger('HintTime',HintTime);
  finally
    r.free;
  end;
end;

procedure TfmBlink.SetInterval(AValue: integer);
begin
  if FInterval=AValue then Exit;
  FInterval:=AValue;
  self.Timer1.Interval:=AValue *1000*60;
end;

procedure TfmBlink.ShowScreen;
begin
  //показать окно
  Show;
  Timer2.Enabled:=true;
end;

procedure TfmBlink.SetHintTime(AValue: integer);
begin
  if FHintTime=AValue then Exit;
  FHintTime:=AValue;
  Timer2.Interval:=AValue *1000;
end;

end.

