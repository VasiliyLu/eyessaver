program eyessaver;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, fblink;

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.ShowMainForm:=false;
  Application.MainFormOnTaskBar:=false;
  Application.CreateForm(TfmBlink, fmBlink);
  fmBlink.TrayIcon1.Visible:=true;
  Application.Run;
end.

