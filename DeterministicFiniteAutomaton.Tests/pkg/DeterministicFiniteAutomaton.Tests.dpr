program DeterministicFiniteAutomaton.Tests;

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
  DUnitTestRunner,
  Impl.Validator.Test in '..\src\Impl\Impl.Validator.Test.pas',
  Impl.Transitions in '..\..\DeterministicFiniteAutomaton\src\Impl\Impl.Transitions.pas',
  Impl.Types in '..\..\DeterministicFiniteAutomaton\src\Impl\Impl.Types.pas',
  Impl.List in '..\..\DeterministicFiniteAutomaton\src\Impl\Impl.List.pas',
  Impl.List.Test in '..\src\Impl\Impl.List.Test.pas',
  Helper.TestFramework in '..\src\Helper\Helper.TestFramework.pas',
  Impl.Transition in '..\..\DeterministicFiniteAutomaton\src\Impl\Impl.Transition.pas',
  Impl.Transitions.Test in '..\src\Impl\Impl.Transitions.Test.pas',
  Impl.Exam.Test in '..\src\Impl\Impl.Exam.Test.pas',
  Impl.DeterministicFiniteAutomaton.Test in '..\src\Impl\Impl.DeterministicFiniteAutomaton.Test.pas',
  Impl.DeterministicFiniteAutomaton in '..\..\DeterministicFiniteAutomaton\src\Impl\Impl.DeterministicFiniteAutomaton.pas',
  Impl.Validator in '..\..\DeterministicFiniteAutomaton\src\Impl\Impl.Validator.pas';

{$R *.RES}

begin
  DUnitTestRunner.RunRegisteredTests;
end.

