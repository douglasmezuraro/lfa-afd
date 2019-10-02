program AFD;

uses
  System.StartUpCopy,
  FMX.Forms,
  View.Main in '..\src\View\View.Main.pas' {Main},
  Helper.FMX in '..\src\Helper\Helper.FMX.pas',
  Impl.Dialogs in '..\src\Impl\Impl.Dialogs.pas',
  Impl.List in '..\src\Impl\Impl.List.pas',
  Impl.Transitions in '..\src\Impl\Impl.Transitions.pas',
  Impl.AFD in '..\src\Impl\Impl.AFD.pas',
  Impl.Types in '..\src\Impl\Impl.Types.pas';

{$R *.res}

var
  Main: TMain;

begin
  Application.Initialize;
  Application.CreateForm(TMain, Main);
  Application.Run;
end.
