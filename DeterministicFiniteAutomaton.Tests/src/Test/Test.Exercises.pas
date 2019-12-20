unit Test.Exercises;

interface

uses
  TestFramework, Impl.DeterministicFiniteAutomaton, Impl.Transition, Impl.Types;

type
  TExercisesTest = class sealed(TTestCase)
  strict private
    FAutomaton: TDeterministicFiniteAutomaton;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    /// <summary>
    ///   L5 = {a^n/n>0}
    /// </summary>
    procedure ExerciseFive;

    /// <summary>
    ///   L6 = {a^n/n>0,n é ímpar}
    /// </summary>
    procedure ExerciseSix;

    /// <summary>
    ///   L7 = {a(b^n)a/n>=0,n é par}
    /// </summary>
    procedure ExerciseSeven;
  end;

implementation

procedure TExercisesTest.SetUp;
begin
  FAutomaton := TDeterministicFiniteAutomaton.Create;
end;

procedure TExercisesTest.TearDown;
begin
  FAutomaton.Free;
end;

procedure TExercisesTest.ExerciseFive;
const
  MustAccept: TArray<TWord> = ['a', 'aa', 'aaa', 'aaaa', 'aaaaa', 'aaaaaa', 'aaaaaaa', 'aaaaaaaaa'];
  MustReject: TArray<TWord> = ['', 'ʎ', 'b', 'c', 'd', 'ab', 'aba', 'ba', 'ac', 'aca', 'ca'];
var
  Word: TWord;
begin
  FAutomaton.Symbols := ['a'];
  FAutomaton.States := ['q0', 'q1'];
  FAutomaton.InitialState := 'q0';
  FAutomaton.FinalStates := ['q1'];

  FAutomaton.Transitions.Add(TTransition.Create('q0', 'a', 'q1'));
  FAutomaton.Transitions.Add(TTransition.Create('q1', 'a', 'q1'));

  for Word in MustAccept do
    CheckTrue(FAutomaton.Accept(Word));

  for Word in MustReject do
    CheckFalse(FAutomaton.Accept(Word));
end;

procedure TExercisesTest.ExerciseSix;
const
  MustAccept: TArray<TWord> = ['a', 'aaa', 'aaaaa', 'aaaaaaa', 'aaaaaaaaa', 'aaaaaaaaaaa'];
  MustReject: TArray<TWord> = ['', 'ʎ', 'aa', 'aaaa', 'aaaaaa', 'aaaaaaaa', 'aaaaaaaaaa'];
var
  Word: TWord;
begin
  FAutomaton.Symbols := ['a'];
  FAutomaton.States := ['q0', 'q1'];
  FAutomaton.InitialState := 'q0';
  FAutomaton.FinalStates := ['q1'];

  FAutomaton.Transitions.Add(TTransition.Create('q0', 'a', 'q1'));
  FAutomaton.Transitions.Add(TTransition.Create('q1', 'a', 'q0'));

  for Word in MustAccept do
    CheckTrue(FAutomaton.Accept(Word));

  for Word in MustReject do
    CheckFalse(FAutomaton.Accept(Word));
end;

procedure TExercisesTest.ExerciseSeven;
const
  MustAccept: TArray<TWord> = ['aa', 'abba', 'abbbba', 'abbbbbba', 'abbbbbbbba', 'abbbbbbbbbba'];
  MustReject: TArray<TWord> = ['', 'ʎ', 'aba', 'abbba', 'abbbbba', 'abbbbbbba', 'abbbbbbbbba'];
var
  Word: TWord;
begin
  FAutomaton.Symbols := ['a', 'b'];
  FAutomaton.States := ['q0', 'q1', 'q2', 'q3'];
  FAutomaton.InitialState := 'q0';
  FAutomaton.FinalStates := ['q3'];

  FAutomaton.Transitions.Add(TTransition.Create('q0', 'a', 'q1'));
  FAutomaton.Transitions.Add(TTransition.Create('q1', 'a', 'q3'));
  FAutomaton.Transitions.Add(TTransition.Create('q1', 'b', 'q2'));
  FAutomaton.Transitions.Add(TTransition.Create('q2', 'b', 'q1'));

  for Word in MustAccept do
    CheckTrue(FAutomaton.Accept(Word));

  for Word in MustReject do
    CheckFalse(FAutomaton.Accept(Word));
end;

initialization
  RegisterTest(TExercisesTest.Suite);

end.
