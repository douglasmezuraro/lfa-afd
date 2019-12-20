program DeterministicFiniteAutomaton.Tests;

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
  DUnitTestRunner,
  Test.Validator in '..\src\Test\Test.Validator.pas',
  Impl.Transitions in '..\..\DeterministicFiniteAutomaton\src\Impl\Impl.Transitions.pas',
  Impl.Types in '..\..\DeterministicFiniteAutomaton\src\Impl\Impl.Types.pas',
  Impl.List in '..\..\DeterministicFiniteAutomaton\src\Impl\Impl.List.pas',
  Test.List in '..\src\Test\Test.List.pas',
  Helper.TestFramework in '..\src\Helper\Helper.TestFramework.pas',
  Impl.Transition in '..\..\DeterministicFiniteAutomaton\src\Impl\Impl.Transition.pas',
  Test.Transitions in '..\src\Test\Test.Transitions.pas',
  Test.Exam in '..\src\Test\Test.Exam.pas',
  Test.DeterministicFiniteAutomaton in '..\src\Test\Test.DeterministicFiniteAutomaton.pas',
  Impl.DeterministicFiniteAutomaton in '..\..\DeterministicFiniteAutomaton\src\Impl\Impl.DeterministicFiniteAutomaton.pas',
  Impl.Validator in '..\..\DeterministicFiniteAutomaton\src\Impl\Impl.Validator.pas',
  Test.Exercises in '..\src\Test\Test.Exercises.pas';

{$R *.RES}

begin
  DUnitTestRunner.RunRegisteredTests;
end.

