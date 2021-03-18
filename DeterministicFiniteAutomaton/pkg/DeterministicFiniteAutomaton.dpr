program DeterministicFiniteAutomaton;

uses
  FMX.Forms,
  MidasLib,
  System.SysUtils,
  System.StartUpCopy,
  Helper.Edit in '..\src\Helper\Helper.Edit.pas',
  Helper.StringGrid in '..\src\Helper\Helper.StringGrid.pas',
  DFA.Automaton in '..\src\DFA\DFA.Automaton.pas',
  DFA.Validator in '..\src\DFA\DFA.Validator.pas',
  Impl.Dialogs in '..\src\Impl\Impl.Dialogs.pas',
  View.Main in '..\src\View\View.Main.pas' {Main},
  Helper.Json in '..\src\Helper\Helper.Json.pas',
  DFA in '..\src\DFA\DFA.pas',
  DFA.Types in '..\src\DFA\DFA.Types.pas';

{$R *.res}

var
  Main: TMain;

begin
  Application.Initialize;
  Application.CreateForm(TMain, Main);
  Application.Run;

{$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown := DebugHook.ToBoolean;
{$WARN SYMBOL_PLATFORM ON}
end.

