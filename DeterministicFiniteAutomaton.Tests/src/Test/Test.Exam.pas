unit Test.Exam;

interface

uses
  Impl.DeterministicFiniteAutomaton, Impl.Transition, Impl.Types, TestFramework;

type
  TExamTest = class sealed(TTestCase)
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
    Automaton.States := ['q0', 'q1', 'q2', 'q3', 'q4', 'q5', 'q6', 'q7', 'q8'];
    Automaton.FinalStates := ['q6', 'q8'];
    Automaton.InitialState := 'q0';

    Automaton.Transitions.Add(TTransition.Create('q0', 'a', 'q1'));
    Automaton.Transitions.Add(TTransition.Create('q1', 'a', 'q1'));
    Automaton.Transitions.Add(TTransition.Create('q1', 'c', 'q2'));
    Automaton.Transitions.Add(TTransition.Create('q2', 'a', 'q3'));
    Automaton.Transitions.Add(TTransition.Create('q2', 'b', 'q4'));
    Automaton.Transitions.Add(TTransition.Create('q2', 'c', 'q2'));
    Automaton.Transitions.Add(TTransition.Create('q3', 'b', 'q5'));
    Automaton.Transitions.Add(TTransition.Create('q4', 'a', 'q5'));
    Automaton.Transitions.Add(TTransition.Create('q5', 'c', 'q6'));
    Automaton.Transitions.Add(TTransition.Create('q6', 'a', 'q7'));
    Automaton.Transitions.Add(TTransition.Create('q7', 'a', 'q8'));
    Automaton.Transitions.Add(TTransition.Create('q8', 'a', 'q7'));

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

