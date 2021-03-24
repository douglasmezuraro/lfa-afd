program DeterministicFiniteAutomaton.Tests;


{$IFNDEF TESTINSIGHT}
{$APPTYPE CONSOLE}
{$ENDIF}{$STRONGLINKTYPES ON}

uses
  MidasLib,
  System.SysUtils,
  {$IFDEF TESTINSIGHT}
  TestInsight.DUnitX,
  {$ENDIF }
  DUnitX.Loggers.Console,
  DUnitX.Loggers.Xml.NUnit,
  DUnitX.TestFramework,
  Fixture.Validator in '..\src\Fixture\Fixture.Validator.pas',
  Fixture.Exercises in '..\src\Fixture\Fixture.Exercises.pas',
  DFA.Automaton in '..\..\DeterministicFiniteAutomaton\src\DFA\DFA.Automaton.pas',
  DFA in '..\..\DeterministicFiniteAutomaton\src\DFA\DFA.pas',
  DFA.Types in '..\..\DeterministicFiniteAutomaton\src\DFA\DFA.Types.pas',
  DFA.Validator in '..\..\DeterministicFiniteAutomaton\src\DFA\DFA.Validator.pas';

procedure Run;
var
  LRunner: ITestRunner;
begin
  TDUnitX.CheckCommandLine;

  LRunner := TDUnitX.CreateRunner;
  LRunner.UseRTTI := True;
  LRunner.FailsOnNoAsserts := True;
  LRunner.AddLogger(TDUnitXConsoleLogger.Create(True));
  LRunner.AddLogger(TDUnitXXMLNUnitFileLogger.Create(TDUnitX.Options.XMLOutputFile));

  if not LRunner.Execute.AllPassed then
  begin
    System.ExitCode := DUnitX.TestFramework.EXIT_ERRORS;
  end;

{$IFNDEF CI}
  if TDUnitX.Options.ExitBehavior = TDUnitXExitBehavior.Pause then
  begin
    System.Write('Done.. press <Enter> key to quit.');
    System.Readln;
  end;
{$ENDIF}
end;

begin
{$IFDEF TESTINSIGHT}
  TestInsight.DUnitX.RunRegisteredTests;
  Exit;
{$ENDIF}
  try
    Run;
  {$WARN SYMBOL_PLATFORM OFF}
    ReportMemoryLeaksOnShutdown := DebugHook.ToBoolean;
  {$WARN SYMBOL_PLATFORM DEFAULT}
  except
    on E: Exception do
    begin
      System.Writeln(E.ClassName, ': ', E.Message);
    end;
  end;
end.

