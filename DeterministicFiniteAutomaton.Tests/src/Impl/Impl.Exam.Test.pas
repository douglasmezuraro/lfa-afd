unit Impl.Exam.Test;

interface

uses
  Impl.DeterministicFiniteAutomaton, Impl.Transition, Impl.Types, TestFramework;

type
  TExamTest = class(TTestCase)
  published
    procedure ExerciseOne;
  end;

implementation

procedure TExamTest.ExerciseOne;
const
  MustAccept: TArray<TWord> = ['acabc', 'acbac', 'acabcaa', 'acbacaa', 'aaccabc', 'aaccbac', 'aaccabcaaaa', 'aaccbacaaaa', 'aaccabcaaaaaa', 'aaccbacaaaa'];
  MustNotAccept: TArray<TWord> = ['', 'a', 'b', 'c', 'ac', 'aca', 'acb', 'acab', 'acba', 'acabca', 'acbaca', 'acabcaaa', 'acbacaaa', 'acabcaaaaa', 'acbacaaaaa'];
var
  Word: TWord;
  Automaton: TDeterministicFiniteAutomaton;
begin
  Automaton := TDeterministicFiniteAutomaton.Create;
  try
    Automaton.Symbols := ['a', 'b', 'c'];
    Automaton.States := ['Q0', 'Q1', 'Q2', 'Q3', 'Q4', 'Q5', 'Q6', 'Q7', 'Q8'];
    Automaton.FinalStates := ['Q6', 'Q8'];
    Automaton.InitialState := 'Q0';

    Automaton.Transitions.Add(TTransition.Create('Q0', 'a', 'Q1'));
    Automaton.Transitions.Add(TTransition.Create('Q1', 'a', 'Q1'));
    Automaton.Transitions.Add(TTransition.Create('Q1', 'c', 'Q2'));
    Automaton.Transitions.Add(TTransition.Create('Q2', 'a', 'Q3'));
    Automaton.Transitions.Add(TTransition.Create('Q2', 'b', 'Q4'));
    Automaton.Transitions.Add(TTransition.Create('Q2', 'c', 'Q2'));
    Automaton.Transitions.Add(TTransition.Create('Q3', 'b', 'Q5'));
    Automaton.Transitions.Add(TTransition.Create('Q4', 'a', 'Q5'));
    Automaton.Transitions.Add(TTransition.Create('Q5', 'c', 'Q6'));
    Automaton.Transitions.Add(TTransition.Create('Q6', 'a', 'Q7'));
    Automaton.Transitions.Add(TTransition.Create('Q7', 'a', 'Q8'));
    Automaton.Transitions.Add(TTransition.Create('Q8', 'a', 'Q7'));

    for Word in MustAccept do
      CheckTrue(Automaton.Accept(Word));

    for Word in MustNotAccept do
      CheckFalse(Automaton.Accept(Word));
  finally
    Automaton.Free;
  end;
end;

initialization
  RegisterTest(TExamTest.Suite);

end.

