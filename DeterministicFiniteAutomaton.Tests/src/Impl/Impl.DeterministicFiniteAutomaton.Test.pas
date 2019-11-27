unit Impl.DeterministicFiniteAutomaton.Test;

interface

uses
  Helper.TestFramework, Impl.DeterministicFiniteAutomaton, Impl.Transition, Impl.Types,
  System.SysUtils, TestFramework;

type
  TAFDTest = class(TTestCase)
  strict private
    FAutomaton: TDeterministicFiniteAutomaton;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestClear;
    procedure TestAcceptWhenAutomatonIsNotValid;
    procedure TestAcceptWhenLanguageRecognizesTheWord;
    procedure TestAcceptWhenLanguageNotRecognizesTheWord;
  end;

implementation

procedure TAFDTest.SetUp;
begin
  FAutomaton := TDeterministicFiniteAutomaton.Create;
  FAutomaton.Symbols := ['a', 'b', 'c'];
  FAutomaton.States := ['Q0', 'Q1', 'Q2', 'Q3', 'Q4', 'Q5', 'Q6', 'Q7', 'Q8'];
  FAutomaton.FinalStates := ['Q6', 'Q8'];
  FAutomaton.InitialState := 'Q0';

  FAutomaton.Transitions.Add(TTransition.Create('Q0', 'a', 'Q1'));
  FAutomaton.Transitions.Add(TTransition.Create('Q1', 'a', 'Q1'));
  FAutomaton.Transitions.Add(TTransition.Create('Q1', 'c', 'Q2'));
  FAutomaton.Transitions.Add(TTransition.Create('Q2', 'a', 'Q3'));
  FAutomaton.Transitions.Add(TTransition.Create('Q2', 'b', 'Q4'));
  FAutomaton.Transitions.Add(TTransition.Create('Q2', 'c', 'Q2'));
  FAutomaton.Transitions.Add(TTransition.Create('Q3', 'b', 'Q5'));
  FAutomaton.Transitions.Add(TTransition.Create('Q4', 'a', 'Q5'));
  FAutomaton.Transitions.Add(TTransition.Create('Q5', 'c', 'Q6'));
  FAutomaton.Transitions.Add(TTransition.Create('Q6', 'a', 'Q7'));
  FAutomaton.Transitions.Add(TTransition.Create('Q7', 'a', 'Q8'));
  FAutomaton.Transitions.Add(TTransition.Create('Q8', 'a', 'Q7'));
end;

procedure TAFDTest.TearDown;
begin
  FAutomaton.Free;
end;

procedure TAFDTest.TestAcceptWhenAutomatonIsNotValid;
begin
  FAutomaton.Transitions.Clear;

  CheckEquals(
    procedure
    begin
      FAutomaton.Accept('acbacaa');
    end,
    EArgumentException);
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

