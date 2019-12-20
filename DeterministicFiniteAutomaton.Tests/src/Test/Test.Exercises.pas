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
    ///   L1 = {}
    /// </summary>
    procedure ExerciseOne;

    /// <summary>
    ///   L2 = {ʎ}
    /// </summary>
    procedure ExerciseTwo;

    /// <summary>
    ///   L3 = {0}
    /// </summary>
    procedure ExerciseTree;

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

    /// <summary>
    ///   L8 = {a((bc)^n)/n>0}
    /// </summary>
    procedure ExerciseEight;

    /// <summary>
    ///   L9 = {(a^n)(b^m)(c^p)/n>0,m>=0,p>=0}
    /// </summary>
    procedure ExerciseNine;
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

procedure TExercisesTest.ExerciseOne;
const
  MustAccept: TArray<TWord> = [];
  MustReject: set of AnsiChar = ['a'..'z', '0'..'9'];
var
  CWord: AnsiChar;
  SWord: TWord;
begin
  FAutomaton.Symbols := [];
  FAutomaton.States := [];
  FAutomaton.InitialState := '';
  FAutomaton.FinalStates := [];

  for SWord in MustAccept do
    CheckTrue(FAutomaton.Accept(SWord));

  for CWord in MustReject do
    CheckFalse(FAutomaton.Accept(TWord(CWord)));
end;

procedure TExercisesTest.ExerciseTwo;
const
  MustAccept: TArray<TWord> = [''];
  MustReject: set of AnsiChar = ['a'..'z', '0'..'9'];
var
  CWord: AnsiChar;
  SWord: TWord;
begin
  FAutomaton.Symbols := [];
  FAutomaton.States := ['q0'];
  FAutomaton.InitialState := 'q0';
  FAutomaton.FinalStates := ['q0'];

  for SWord in MustAccept do
    CheckTrue(FAutomaton.Accept(SWord));

  for CWord in MustReject do
    CheckFalse(FAutomaton.Accept(TWord(CWord)));
end;

procedure TExercisesTest.ExerciseTree;
const
  MustAccept: TArray<TWord> = ['0'];
  MustReject: set of AnsiChar = ['a'..'z', '1'..'9'];
var
  CWord: AnsiChar;
  SWord: TWord;
begin
  FAutomaton.Symbols := ['0'];
  FAutomaton.States := ['q0', 'q1'];
  FAutomaton.InitialState := 'q0';
  FAutomaton.FinalStates := ['q1'];

  FAutomaton.Transitions.Add(TTransition.Create('q0', '0', 'q1'));

  for SWord in MustAccept do
    CheckTrue(FAutomaton.Accept(SWord));

  for CWord in MustReject do
    CheckFalse(FAutomaton.Accept(TWord(CWord)));
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

procedure TExercisesTest.ExerciseEight;
const
  MustAccept: TArray<TWord> = ['abca', 'abcbca', 'abcbcbca', 'abcbcbcbca', 'abcbcbcbcbca'];
  MustReject: TArray<TWord> = ['', 'ʎ', 'a', 'b', 'c', 'aa', 'ab', 'ac', 'bc', 'aba', 'aca'];
var
  Word: TWord;
begin
  FAutomaton.Symbols := ['a', 'b', 'c'];
  FAutomaton.States := ['q0', 'q1', 'q2', 'q3', 'q4'];
  FAutomaton.InitialState := 'q0';
  FAutomaton.FinalStates := ['q4'];

  FAutomaton.Transitions.Add(TTransition.Create('q0', 'a', 'q1'));
  FAutomaton.Transitions.Add(TTransition.Create('q1', 'b', 'q2'));
  FAutomaton.Transitions.Add(TTransition.Create('q2', 'c', 'q3'));
  FAutomaton.Transitions.Add(TTransition.Create('q3', 'a', 'q4'));
  FAutomaton.Transitions.Add(TTransition.Create('q3', 'b', 'q2'));

  for Word in MustAccept do
    CheckTrue(FAutomaton.Accept(Word));

  for Word in MustReject do
    CheckFalse(FAutomaton.Accept(Word));
end;

procedure TExercisesTest.ExerciseNine;
const
  MustAccept: TArray<TWord> = ['a', 'aa', 'aaa', 'ab', 'ac', 'abc', 'aabbcc', 'aaaaabbbbbcccccccc'];
  MustReject: TArray<TWord> = ['', 'ʎ', 'b', 'c', 'bc', 'cb', 'ca', 'ba', 'bbcc', 'cba'];
var
  Word: TWord;
begin
  FAutomaton.Symbols := ['a', 'b', 'c'];
  FAutomaton.States := ['q0', 'q1', 'q2', 'q3'];
  FAutomaton.InitialState := 'q0';
  FAutomaton.FinalStates := ['q1', 'q2', 'q3'];

  FAutomaton.Transitions.Add(TTransition.Create('q0', 'a', 'q1'));
  FAutomaton.Transitions.Add(TTransition.Create('q1', 'a', 'q1'));
  FAutomaton.Transitions.Add(TTransition.Create('q1', 'b', 'q2'));
  FAutomaton.Transitions.Add(TTransition.Create('q1', 'c', 'q3'));
  FAutomaton.Transitions.Add(TTransition.Create('q2', 'b', 'q2'));
  FAutomaton.Transitions.Add(TTransition.Create('q2', 'c', 'q3'));
  FAutomaton.Transitions.Add(TTransition.Create('q3', 'c', 'q3'));

  for Word in MustAccept do
    CheckTrue(FAutomaton.Accept(Word));

  for Word in MustReject do
    CheckFalse(FAutomaton.Accept(Word));
end;

initialization
  RegisterTest(TExercisesTest.Suite);

end.
