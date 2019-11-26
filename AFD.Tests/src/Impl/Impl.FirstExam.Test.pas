unit Impl.FirstExam.Test;

interface

uses
  TestFramework, Impl.AFD, Impl.Transition, Impl.Types;

type
  TFirstExam = class(TTestCase)
  published
    procedure ExerciseOne;
  end;

implementation

procedure TFirstExam.ExerciseOne;
const
  MustAccept: TArray<TWord> = ['acabc', 'acbac', 'acabcaa', 'acbacaa', 'aaccabc', 'aaccbac', 'aaccabcaaaa', 'aaccbacaaaa', 'aaccabcaaaaaa', 'aaccbacaaaa'];
  MustNotAccept: TArray<TWord> = ['', 'a', 'b', 'c', 'ac', 'aca', 'acb', 'acab', 'acba', 'acabca', 'acbaca', 'acabcaaa', 'acbacaaa', 'acabcaaaaa', 'acbacaaaaa'];
var
  Word: TWord;
  Automaton: TAFD;
begin
  Automaton := TAFD.Create;
  try
    Automaton.Symbols      := ['a', 'b', 'c'];
    Automaton.States       := ['S0', 'S1', 'S2', 'S3', 'S4', 'S5', 'S6', 'S7', 'S8'];
    Automaton.FinalStates  := ['S6', 'S8'];
    Automaton.InitialState := 'S0';

    Automaton.Transitions.Add(TTransition.Create('S0', 'a', 'S1'));
    Automaton.Transitions.Add(TTransition.Create('S1', 'a', 'S1'));
    Automaton.Transitions.Add(TTransition.Create('S1', 'c', 'S2'));
    Automaton.Transitions.Add(TTransition.Create('S2', 'a', 'S3'));
    Automaton.Transitions.Add(TTransition.Create('S2', 'b', 'S4'));
    Automaton.Transitions.Add(TTransition.Create('S2', 'c', 'S2'));
    Automaton.Transitions.Add(TTransition.Create('S3', 'b', 'S5'));
    Automaton.Transitions.Add(TTransition.Create('S4', 'a', 'S5'));
    Automaton.Transitions.Add(TTransition.Create('S5', 'c', 'S6'));
    Automaton.Transitions.Add(TTransition.Create('S6', 'a', 'S7'));
    Automaton.Transitions.Add(TTransition.Create('S7', 'a', 'S8'));
    Automaton.Transitions.Add(TTransition.Create('S8', 'a', 'S7'));

    for Word in MustAccept do
      CheckTrue(Automaton.Accept(Word));

    for Word in MustNotAccept do
      CheckFalse(Automaton.Accept(Word));
  finally
    Automaton.Free;
  end;
end;

initialization
  RegisterTest(TFirstExam.Suite);

end.
