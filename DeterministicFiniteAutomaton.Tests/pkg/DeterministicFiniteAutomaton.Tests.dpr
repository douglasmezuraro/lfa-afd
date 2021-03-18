program DeterministicFiniteAutomaton.Tests;

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
  DUnitTestRunner,
  MidasLib,
  Test.Validator in '..\src\Test\Test.Validator.pas',
  Impl.Transitions in '..\..\DeterministicFiniteAutomaton\src\Impl\Impl.Transitions.pas',
  Impl.Types in '..\..\DeterministicFiniteAutomaton\src\Impl\Impl.Types.pas',
  Impl.List in '..\..\DeterministicFiniteAutomaton\src\Impl\Impl.List.pas',
  Test.List in '..\src\Test\Test.List.pas',
  Helper.TestFramework in '..\src\Helper\Helper.TestFramework.pas',
  DFA.Transition in '..\..\DeterministicFiniteAutomaton\src\DFA\DFA.Transition.pas',
  Test.Transitions in '..\src\Test\Test.Transitions.pas',
  Test.DeterministicFiniteAutomaton in '..\src\Test\Test.DeterministicFiniteAutomaton.pas',
  DFA.Automaton in '..\..\DeterministicFiniteAutomaton\src\DFA\DFA.Automaton.pas',
  DFA.Validator in '..\..\DeterministicFiniteAutomaton\src\DFA\DFA.Validator.pas',
  Test.Exercises in '..\src\Test\Test.Exercises.pas';

{$R *.RES}

begin
  DUnitTestRunner.RunRegisteredTests;
end.

