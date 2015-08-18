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
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    procedure Button1Click(Sender: TObject);
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
  fblink.fmBlink.Interval:= ;
end;

end.

