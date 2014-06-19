program TestResultsPrint;

uses
  Forms,
  MainUnit in '..\..\..\Documents\GitHub\Тестирование печать результатов\MainUnit.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
