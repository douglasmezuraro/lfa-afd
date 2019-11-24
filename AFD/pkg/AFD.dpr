program AFD;

uses
  System.StartUpCopy,
  FMX.Forms,
  Helper.Edit in '..\src\Helper\Helper.Edit.pas',
  Helper.ListBox in '..\src\Helper\Helper.ListBox.pas',
  Helper.ListBoxItem in '..\src\Helper\Helper.ListBoxItem.pas',
  Helper.StringGrid in '..\src\Helper\Helper.StringGrid.pas',
  Impl.AFD in '..\src\Impl\Impl.AFD.pas',
  Impl.AFD.Validator in '..\src\Impl\Impl.AFD.Validator.pas',
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

