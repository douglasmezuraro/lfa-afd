program AFD;

uses
  System.StartUpCopy,
  FMX.Forms,
  View.Main in '..\src\View\View.Main.pas' {Main},
  Impl.AFD in '..\src\Impl\Impl.AFD.pas',
  Impl.AFD.Types in '..\src\Impl\Impl.AFD.Types.pas',
  Helper.FMX in '..\src\Helper\Helper.FMX.pas';

{$R *.res}

var
  Main: TMain;

begin
  Application.Initialize;
  Application.CreateForm(TMain, Main);
  Application.Run;
end.
