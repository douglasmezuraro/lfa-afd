program AFD.Tests;

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
  DUnitTestRunner,
  Impl.AFD.Validator.Test in '..\src\Impl\Impl.AFD.Validator.Test.pas',
  Impl.AFD in '..\..\AFD\src\Impl\Impl.AFD.pas',
  Impl.Transitions in '..\..\AFD\src\Impl\Impl.Transitions.pas',
  Impl.Types in '..\..\AFD\src\Impl\Impl.Types.pas',
  Impl.List in '..\..\AFD\src\Impl\Impl.List.pas',
  Impl.List.Test in '..\src\Impl\Impl.List.Test.pas',
  TestFramework.Helpers in '..\src\TestFramework\TestFramework.Helpers.pas',
  Impl.AFD.Validator in '..\..\AFD\src\Impl\Impl.AFD.Validator.pas',
  Impl.Transition in '..\..\AFD\src\Impl\Impl.Transition.pas',
  Impl.Transitions.Test in '..\src\Impl\Impl.Transitions.Test.pas',
  Impl.Exam.Test in '..\src\Impl\Impl.Exam.Test.pas',
  Impl.AFD.Test in '..\src\Impl\Impl.AFD.Test.pas';

{$R *.RES}

begin
  DUnitTestRunner.RunRegisteredTests;
end.

