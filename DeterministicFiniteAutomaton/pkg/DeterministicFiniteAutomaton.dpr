program DeterministicFiniteAutomaton;

uses
  FMX.Forms,
  MidasLib,
  System.StartUpCopy,
  Helper.Edit in '..\src\Helper\Helper.Edit.pas',
  Helper.StringGrid in '..\src\Helper\Helper.StringGrid.pas',
  Impl.DeterministicFiniteAutomaton in '..\src\Impl\Impl.DeterministicFiniteAutomaton.pas',
  Impl.Validator in '..\src\Impl\Impl.Validator.pas',
  Impl.Dialogs in '..\src\Impl\Impl.Dialogs.pas',
  Impl.List in '..\src\Impl\Impl.List.pas',
  Impl.Transition in '..\src\Impl\Impl.Transition.pas',
  Impl.Transitions in '..\src\Impl\Impl.Transitions.pas',
  Impl.Types in '..\src\Impl\Impl.Types.pas',
  View.Main in '..\src\View\View.Main.pas' {Main};

{$R *.res}

var
  Main: TMain;

begin
  Application.Initialize;
  Application.CreateForm(TMain, Main);
  Application.Run;

  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown := ByteBool(DebugHook);
  {$WARN SYMBOL_PLATFORM ON}
end.

