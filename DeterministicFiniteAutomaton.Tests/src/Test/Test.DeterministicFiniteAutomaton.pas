unit Test.DeterministicFiniteAutomaton;

interface

uses
  Helper.TestFramework, Impl.DeterministicFiniteAutomaton, Impl.Transition, Impl.Types,
  System.SysUtils, TestFramework;

type
  TAFDTest = class sealed(TTestCase)
  strict private
    FAutomaton: TDeterministicFiniteAutomaton;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestClear;
    procedure TestAcceptWhenLanguageRecognizesTheWord;
    procedure TestAcceptWhenLanguageNotRecognizesTheWord;
  end;

implementation

procedure TAFDTest.SetUp;
begin
  FAutomaton := TDeterministicFiniteAutomaton.Create;
  FAutomaton.Symbols := ['a', 'b', 'c'];
  FAutomaton.States := ['q0', 'q1', 'q2', 'q3', 'q4', 'q5', 'q6', 'q7', 'q8'];
  FAutomaton.FinalStates := ['q6', 'q8'];
  FAutomaton.InitialState := 'q0';

  FAutomaton.Transitions.Add(TTransition.Create('q0', 'a', 'q1'));
  FAutomaton.Transitions.Add(TTransition.Create('q1', 'a', 'q1'));
  FAutomaton.Transitions.Add(TTransition.Create('q1', 'c', 'q2'));
  FAutomaton.Transitions.Add(TTransition.Create('q2', 'a', 'q3'));
  FAutomaton.Transitions.Add(TTransition.Create('q2', 'b', 'q4'));
  FAutomaton.Transitions.Add(TTransition.Create('q2', 'c', 'q2'));
  FAutomaton.Transitions.Add(TTransition.Create('q3', 'b', 'q5'));
  FAutomaton.Transitions.Add(TTransition.Create('q4', 'a', 'q5'));
  FAutomaton.Transitions.Add(TTransition.Create('q5', 'c', 'q6'));
  FAutomaton.Transitions.Add(TTransition.Create('q6', 'a', 'q7'));
  FAutomaton.Transitions.Add(TTransition.Create('q7', 'a', 'q8'));
  FAutomaton.Transitions.Add(TTransition.Create('q8', 'a', 'q7'));
end;

procedure TAFDTest.TearDown;
begin
  FAutomaton.Free;
end;

procedure TAFDTest.TestAcceptWhenLanguageNotRecognizesTheWord;
begin
  CheckFalse(FAutomaton.Accept('acabca'));
end;

procedure TAFDTest.TestAcceptWhenLanguageRecognizesTheWord;
begin
  CheckTrue(FAutomaton.Accept('acbacaa'));
end;

procedure TAFDTest.TestClear;
begin
  FAutomaton.Clear;

  CheckEquals([], FAutomaton.Symbols);
  CheckEquals([], FAutomaton.States);
  CheckEquals([], FAutomaton.FinalStates);
  CheckEquals(TState.Empty, FAutomaton.InitialState);
  CheckTrue(FAutomaton.Transitions.IsEmpty);
end;

initialization
  RegisterTest(TAFDTest.Suite);

end.

