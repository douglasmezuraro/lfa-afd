unit Fixture.Exercises;

interface

uses
  DUnitX.TestFramework, System.SysUtils, DFA;

type
  [TestFixture]
  TExercisesFixture = class sealed
  private
    function Check(const ADTO: TDTO; const AWord: TWord): Boolean;
  public
    [Test]
    [Category('L1 = {W ε {}}')]
    [TestCase('Check if the "" word belongs to the L1 language', '' + ',' + 'False')]
    //[TestCase('Check if the "ʎ" word belongs to the L1 language', 'ʎ' + ',' + 'False')]
    [TestCase('Check if the "a" word belongs to the L1 language', 'a' + ',' + 'False')]
    [TestCase('Check if the "b" word belongs to the L1 language', 'b' + ',' + 'False')]
    [TestCase('Check if the "c" word belongs to the L1 language', 'c' + ',' + 'False')]
    [TestCase('Check if the "x" word belongs to the L1 language', 'x' + ',' + 'False')]
    [TestCase('Check if the "y" word belongs to the L1 language', 'y' + ',' + 'False')]
    [TestCase('Check if the "z" word belongs to the L1 language', 'z' + ',' + 'False')]
    [TestCase('Check if the "0" word belongs to the L1 language', '0' + ',' + 'False')]
    [TestCase('Check if the "1" word belongs to the L1 language', '1' + ',' + 'False')]
    [TestCase('Check if the "2" word belongs to the L1 language', '2' + ',' + 'False')]
    [TestCase('Check if the "7" word belongs to the L1 language', '7' + ',' + 'False')]
    [TestCase('Check if the "8" word belongs to the L1 language', '8' + ',' + 'False')]
    [TestCase('Check if the "9" word belongs to the L1 language', '9' + ',' + 'False')]
    procedure ExerciseOne(const AWord: string; const AExpected: Boolean);

    [Test]
    [Category('L2 = {W ε {ʎ}}')]
    //[TestCase('Check if the "ʎ" word belongs to the L2 language', 'ʎ' + ',' + 'True')]
    [TestCase('Check if the "" word belongs to the L2 language', '' + ',' + 'True')]
    [TestCase('Check if the "a" word belongs to the L2 language', 'a' + ',' + 'False')]
    [TestCase('Check if the "b" word belongs to the L2 language', 'b' + ',' + 'False')]
    [TestCase('Check if the "c" word belongs to the L2 language', 'c' + ',' + 'False')]
    [TestCase('Check if the "x" word belongs to the L2 language', 'x' + ',' + 'False')]
    [TestCase('Check if the "y" word belongs to the L2 language', 'y' + ',' + 'False')]
    [TestCase('Check if the "z" word belongs to the L2 language', 'z' + ',' + 'False')]
    [TestCase('Check if the "0" word belongs to the L2 language', '0' + ',' + 'False')]
    [TestCase('Check if the "1" word belongs to the L2 language', '1' + ',' + 'False')]
    [TestCase('Check if the "2" word belongs to the L2 language', '2' + ',' + 'False')]
    [TestCase('Check if the "7" word belongs to the L2 language', '7' + ',' + 'False')]
    [TestCase('Check if the "8" word belongs to the L2 language', '8' + ',' + 'False')]
    [TestCase('Check if the "9" word belongs to the L2 language', '9' + ',' + 'False')]
    procedure ExerciseTwo(const AWord: string; const AExpected: Boolean);

    [Test]
    [Category('L3 = {W ε {0}}')]
    [TestCase('Check if the "0" word belongs to the L3 language', '0' + ',' + 'True')]
    [TestCase('Check if the "" word belongs to the L3 language', '' + ',' + 'False')]
    //[TestCase('Check if the "ʎ" word belongs to the L3 language', 'ʎ' + ',' + 'False')]
    [TestCase('Check if the "a" word belongs to the L3 language', 'a' + ',' + 'False')]
    [TestCase('Check if the "b" word belongs to the L3 language', 'b' + ',' + 'False')]
    [TestCase('Check if the "c" word belongs to the L3 language', 'c' + ',' + 'False')]
    [TestCase('Check if the "x" word belongs to the L3 language', 'x' + ',' + 'False')]
    [TestCase('Check if the "y" word belongs to the L3 language', 'y' + ',' + 'False')]
    [TestCase('Check if the "z" word belongs to the L3 language', 'z' + ',' + 'False')]
    [TestCase('Check if the "1" word belongs to the L3 language', '1' + ',' + 'False')]
    [TestCase('Check if the "2" word belongs to the L3 language', '2' + ',' + 'False')]
    [TestCase('Check if the "7" word belongs to the L3 language', '7' + ',' + 'False')]
    [TestCase('Check if the "8" word belongs to the L3 language', '8' + ',' + 'False')]
    [TestCase('Check if the "9" word belongs to the L3 language', '9' + ',' + 'False')]
    procedure ExerciseTree(const AWord: string; const AExpected: Boolean);

    [Test]
    [Category('L4 = {W ε {ʎ, 0}}')]
    [TestCase('Check if the "" word belongs to the L4 language', '' + ',' + 'True')]
    [TestCase('Check if the "0" word belongs to the L4 language', '0' + ',' + 'True')]
    //[TestCase('Check if the "ʎ" word belongs to the L4 language', 'ʎ' + ',' + 'False')]
    [TestCase('Check if the "a" word belongs to the L4 language', 'a' + ',' + 'False')]
    [TestCase('Check if the "b" word belongs to the L4 language', 'b' + ',' + 'False')]
    [TestCase('Check if the "c" word belongs to the L4 language', 'c' + ',' + 'False')]
    [TestCase('Check if the "x" word belongs to the L4 language', 'x' + ',' + 'False')]
    [TestCase('Check if the "y" word belongs to the L4 language', 'y' + ',' + 'False')]
    [TestCase('Check if the "z" word belongs to the L4 language', 'z' + ',' + 'False')]
    [TestCase('Check if the "1" word belongs to the L4 language', '1' + ',' + 'False')]
    [TestCase('Check if the "2" word belongs to the L4 language', '2' + ',' + 'False')]
    [TestCase('Check if the "7" word belongs to the L4 language', '7' + ',' + 'False')]
    [TestCase('Check if the "8" word belongs to the L4 language', '8' + ',' + 'False')]
    [TestCase('Check if the "9" word belongs to the L4 language', '9' + ',' + 'False')]
    procedure ExerciseFour(const AWord: string; const AExpected: Boolean);

    [Test]
    [Category('L5 = {aⁿ | n > 0}')]
    [TestCase('Check if the "" word belongs to the L5 language', '' + ',' + 'False')]
    //[TestCase('Check if the "ʎ" word belongs to the L5 language', 'ʎ' + ',' + 'False')]
    [TestCase('Check if the "aa" word belongs to the L5 language', 'aa' + ',' + 'True')]
    [TestCase('Check if the "aaa" word belongs to the L5 language', 'aaa' + ',' + 'True')]
    [TestCase('Check if the "aaaa" word belongs to the L5 language', 'aaaa' + ',' + 'True')]
    [TestCase('Check if the "aaaaa" word belongs to the L5 language', 'aaaaa' + ',' + 'True')]
    [TestCase('Check if the "aaaaaa" word belongs to the L5 language', 'aaaaaa' + ',' + 'True')]
    [TestCase('Check if the "aaaaaaa" word belongs to the L5 language', 'aaaaaaa' + ',' + 'True')]
    [TestCase('Check if the "aaaaaaaaa" word belongs to the L5 language', 'aaaaaaaaa' + ',' + 'True')]
    [TestCase('Check if the "b" word belongs to the L5 language', 'b' + ',' + 'False')]
    [TestCase('Check if the "c" word belongs to the L5 language', 'c' + ',' + 'False')]
    [TestCase('Check if the "d" word belongs to the L5 language', 'd' + ',' + 'False')]
    [TestCase('Check if the "ab" word belongs to the L5 language', 'ab' + ',' + 'False')]
    [TestCase('Check if the "aba" word belongs to the L5 language', 'aba' + ',' + 'False')]
    [TestCase('Check if the "ba" word belongs to the L5 language', 'ba' + ',' + 'False')]
    [TestCase('Check if the "ac" word belongs to the L5 language', 'ac' + ',' + 'False')]
    [TestCase('Check if the "aca" word belongs to the L5 language', 'aca' + ',' + 'False')]
    [TestCase('Check if the "ca" word belongs to the L5 language', 'ca' + ',' + 'False')]
    procedure ExerciseFive(const AWord: string; const AExpected: Boolean);

    [Test]
    [Category('L6 = {aⁿ | n > 0; n is odd}')]
    [TestCase('Check if the "a" word belongs to the L6 language', 'a' + ',' + 'True')]
    [TestCase('Check if the "aaa" word belongs to the L6 language', 'aaa' + ',' + 'True')]
    [TestCase('Check if the "aaaaa" word belongs to the L6 language', 'aaaaa' + ',' + 'True')]
    [TestCase('Check if the "aaaaaaa" word belongs to the L6 language', 'aaaaaaa' + ',' + 'True')]
    [TestCase('Check if the "aaaaaaaaa" word belongs to the L6 language', 'aaaaaaaaa' + ',' + 'True')]
    [TestCase('Check if the "aaaaaaaaaaa" word belongs to the L6 language', 'aaaaaaaaaaa' + ',' + 'True')]
    [TestCase('Check if the "" word belongs to the L6 language', '' + ',' + 'False')]
    //[TestCase('Check if the "ʎ" word belongs to the L6 language', 'ʎ' + ',' + 'False')]
    [TestCase('Check if the "aa" word belongs to the L6 language', 'aa' + ',' + 'False')]
    [TestCase('Check if the "aaaa" word belongs to the L6 language', 'aaaa' + ',' + 'False')]
    [TestCase('Check if the "aaaaaa" word belongs to the L6 language', 'aaaaaa' + ',' + 'False')]
    [TestCase('Check if the "aaaaaaaa" word belongs to the L6 language', 'aaaaaaaa' + ',' + 'False')]
    [TestCase('Check if the "aaaaaaaaaa" word belongs to the L6 language', 'aaaaaaaaaa' + ',' + 'False')]
    procedure ExerciseSix(const AWord: string; const AExpected: Boolean);

    [Test]
    [Category('L7 = {a(bⁿ)a | n >= 0, n is even}')]
    [TestCase('Check if the "aa word belongs to the L7 language" ', 'aa' + ',' + 'True')]
    [TestCase('Check if the "abba word belongs to the L7 language" ', 'abba' + ',' + 'True')]
    [TestCase('Check if the "abbbba word belongs to the L7 language" ', 'abbbba' + ',' + 'True')]
    [TestCase('Check if the "abbbbbba word belongs to the L7 language" ', 'abbbbbba' + ',' + 'True')]
    [TestCase('Check if the "abbbbbbbba word belongs to the L7 language" ', 'abbbbbbbba' + ',' + 'True')]
    [TestCase('Check if the "abbbbbbbbbba word belongs to the L7 language" ', 'abbbbbbbbbba' + ',' + 'True')]
    [TestCase('Check if the "" word belongs to the L7 language', '' + ',' + 'False')]
    //[TestCase('Check if the "ʎ" word belongs to the L7 language', 'ʎ' + ',' + 'False')]
    [TestCase('Check if the "aba" word belongs to the L7 language', 'aba' + ',' + 'False')]
    [TestCase('Check if the "abbba" word belongs to the L7 language', 'abbba' + ',' + 'False')]
    [TestCase('Check if the "abbbbba" word belongs to the L7 language', 'abbbbba' + ',' + 'False')]
    [TestCase('Check if the "abbbbbbba" word belongs to the L7 language', 'abbbbbbba' + ',' + 'False')]
    [TestCase('Check if the "abbbbbbbbba" word belongs to the L7 language', 'abbbbbbbbba' + ',' + 'False')]
    procedure ExerciseSeven (const AWord: string; const AExpected: Boolean);

    [Test]
    [Category('L8 = {a((bc)ⁿ) | n > 0}')]
    [TestCase('Check if the "abca" word belongs to the L8 language', 'abca' + ',' + 'True')]
    [TestCase('Check if the "abcbca" word belongs to the L8 language', 'abcbca' + ',' + 'True')]
    [TestCase('Check if the "abcbcbca" word belongs to the L8 language', 'abcbcbca' + ',' + 'True')]
    [TestCase('Check if the "abcbcbcbca" word belongs to the L8 language', 'abcbcbcbca' + ',' + 'True')]
    [TestCase('Check if the "abcbcbcbcbca" word belongs to the L8 language', 'abcbcbcbcbca' + ',' + 'True')]
    [TestCase('Check if the "" word belongs to the L8 language', '' + ',' + 'False')]
    //[TestCase('Check if the "ʎ" word belongs to the L8 language', 'ʎ' + ',' + 'False')]
    [TestCase('Check if the "a" word belongs to the L8 language', 'a' + ',' + 'False')]
    [TestCase('Check if the "b" word belongs to the L8 language', 'b' + ',' + 'False')]
    [TestCase('Check if the "c" word belongs to the L8 language', 'c' + ',' + 'False')]
    [TestCase('Check if the "aa" word belongs to the L8 language', 'aa' + ',' + 'False')]
    [TestCase('Check if the "ab" word belongs to the L8 language', 'ab' + ',' + 'False')]
    [TestCase('Check if the "ac" word belongs to the L8 language', 'ac' + ',' + 'False')]
    [TestCase('Check if the "bc" word belongs to the L8 language', 'bc' + ',' + 'False')]
    [TestCase('Check if the "aba" word belongs to the L8 language', 'aba' + ',' + 'False')]
    [TestCase('Check if the "aca" word belongs to the L8 language', 'aca' + ',' + 'False')]
    procedure ExerciseEight(const AWord: string; const AExpected: Boolean);

    [Test]
    [Category('L9 = {(aⁿ)(bᵐ)(cᵖ) | n > 0; m >= 0; p >= 0}')]
    [TestCase('Check if the "a" word belongs to the L9 language', 'a' + ',' + 'True')]
    [TestCase('Check if the "aa" word belongs to the L9 language', 'aa' + ',' + 'True')]
    [TestCase('Check if the "aaa" word belongs to the L9 language', 'aaa' + ',' + 'True')]
    [TestCase('Check if the "ab" word belongs to the L9 language', 'ab' + ',' + 'True')]
    [TestCase('Check if the "ac" word belongs to the L9 language', 'ac' + ',' + 'True')]
    [TestCase('Check if the "abc" word belongs to the L9 language', 'abc' + ',' + 'True')]
    [TestCase('Check if the "aabbcc" word belongs to the L9 language', 'aabbcc' + ',' + 'True')]
    [TestCase('Check if the "aaaaabbbbbcccccccc" word belongs to the L9 language', 'aaaaabbbbbcccccccc' + ',' + 'True')]
    //[TestCase('Teste if the "" word belongs to the L9 language', '' + ',' + 'False')]
    [TestCase('Teste if the "ʎ" word belongs to the L9 language', 'ʎ' + ',' + 'False')]
    [TestCase('Teste if the "b" word belongs to the L9 language', 'b' + ',' + 'False')]
    [TestCase('Teste if the "c" word belongs to the L9 language', 'c' + ',' + 'False')]
    [TestCase('Teste if the "bc" word belongs to the L9 language', 'bc' + ',' + 'False')]
    [TestCase('Teste if the "cb" word belongs to the L9 language', 'cb' + ',' + 'False')]
    [TestCase('Teste if the "ca" word belongs to the L9 language', 'ca' + ',' + 'False')]
    [TestCase('Teste if the "ba" word belongs to the L9 language', 'ba' + ',' + 'False')]
    [TestCase('Teste if the "bbcc" word belongs to the L9 language', 'bbcc' + ',' + 'False')]
    [TestCase('Teste if the "cba" word belongs to the L9 language', 'cba' + ',' + 'False')]
    procedure ExerciseNine(const AWord: string; const AExpected: Boolean);

    [Test]
    [Category('L10 = {(aⁿ)bb(aᵐ) | n >= 0; m> = 0; n is even; m is even}')]
    [TestCase('Check if the "bb" word belongs to the L10 language', 'bb' + ',' + 'True')]
    [TestCase('Check if the "aabb" word belongs to the L10 language', 'aabb' + ',' + 'True')]
    [TestCase('Check if the "bbaa" word belongs to the L10 language', 'bbaa' + ',' + 'True')]
    [TestCase('Check if the "aabbaa" word belongs to the L10 language', 'aabbaa' + ',' + 'True')]
    [TestCase('Check if the "aaaabb" word belongs to the L10 language', 'aaaabb' + ',' + 'True')]
    [TestCase('Check if the "aaaabbaa" word belongs to the L10 language', 'aaaabbaa' + ',' + 'True')]
    [TestCase('Check if the "aaaabbaaaa" word belongs to the L10 language', 'aaaabbaaaa' + ',' + 'True')]
    [TestCase('Check if the "" word belongs to the L10 language', '' + ',' + 'False')]
    //[TestCase('Check if the "ʎ" word belongs to the L10 language', 'ʎ' + ',' + 'False')]
    [TestCase('Check if the "a" word belongs to the L10 language', 'a' + ',' + 'False')]
    [TestCase('Check if the "b" word belongs to the L10 language', 'b' + ',' + 'False')]
    [TestCase('Check if the "aa" word belongs to the L10 language', 'aa' + ',' + 'False')]
    [TestCase('Check if the "abb" word belongs to the L10 language', 'abb' + ',' + 'False')]
    [TestCase('Check if the "bba" word belongs to the L10 language', 'bba' + ',' + 'False')]
    [TestCase('Check if the "abba" word belongs to the L10 language', 'abba' + ',' + 'False')]
    [TestCase('Check if the "aaabba" word belongs to the L10 language', 'aaabba' + ',' + 'False')]
    [TestCase('Check if the "aabaaa" word belongs to the L10 language', 'aabaaa' + ',' + 'False')]
    procedure ExerciseTen(const AWord: string; const AExpected: Boolean);
  end;

implementation

function TExercisesFixture.Check(const ADTO: TDTO; const AWord: TWord): Boolean;
var
  LAutomaton: TDeterministicFiniteAutomaton;
begin
  LAutomaton := TDeterministicFiniteAutomaton.Create(ADTO);
  try
    Result := LAutomaton.Check(AWord);
  finally
    LAutomaton.Free;
  end;
end;

procedure TExercisesFixture.ExerciseOne(const AWord: string; const AExpected: Boolean);
var
	LDTO: TDTO;
	LActual: Boolean;
begin
  LDTO.States := [];
  LDTO.Symbols := [];
  LDTO.InitialState := TState.Empty;
  LDTO.FinalStates := [];
  LDTO.Transitions := [];

  LActual := Check(LDTO, AWord);
  Assert.AreEqual(LActual, AExpected);
end;

procedure TExercisesFixture.ExerciseTwo(const AWord: string; const AExpected: Boolean);
var
	LDTO: TDTO;
	LActual: Boolean;
begin
  LDTO.States := ['s0'];
  LDTO.Symbols := [];
  LDTO.InitialState := 's0';
  LDTO.FinalStates := ['s0'];
  LDTO.Transitions := [];

  LActual := Check(LDTO, AWord);
  Assert.AreEqual(LActual, AExpected);
end;

procedure TExercisesFixture.ExerciseTree(const AWord: string; const AExpected: Boolean);
var
	LDTO: TDTO;
	LActual: Boolean;
begin
  LDTO.States := ['s0', 's1'];
  LDTO.Symbols := ['0'];
  LDTO.InitialState := 's0';
  LDTO.FinalStates := ['s1'];
  LDTO.Transitions := [
    TTransition.Create('s0', '0', 's1')
  ];

  LActual := Check(LDTO, AWord);
  Assert.AreEqual(LActual, AExpected);
end;

procedure TExercisesFixture.ExerciseFour(const AWord: string; const AExpected: Boolean);
var
	LDTO: TDTO;
	LActual: Boolean;
begin
  LDTO.States := ['s0', 's1'];
  LDTO.Symbols := ['0'];
  LDTO.InitialState := 's0';
  LDTO.FinalStates := ['s0', 's1'];
  LDTO.Transitions := [
    TTransition.Create('s0', '0', 's1')
  ];

  LActual := Check(LDTO, AWord);
  Assert.AreEqual(LActual, AExpected);
end;

procedure TExercisesFixture.ExerciseFive(const AWord: string; const AExpected: Boolean);
var
	LDTO: TDTO;
	LActual: Boolean;
begin
  LDTO.States := ['s0', 's1'];
  LDTO.Symbols := ['a'];
  LDTO.InitialState := 's0';
  LDTO.FinalStates := ['s1'];
  LDTO.Transitions := [
    TTransition.Create('s0', 'a', 's1'),
    TTransition.Create('s1', 'a', 's1')
  ];

  LActual := Check(LDTO, AWord);
  Assert.AreEqual(LActual, AExpected);
end;

procedure TExercisesFixture.ExerciseSix(const AWord: string; const AExpected: Boolean);
var
	LDTO: TDTO;
	LActual: Boolean;
begin
  LDTO.States := ['s0', 's1'];
  LDTO.Symbols := ['a'];
  LDTO.InitialState := 's0';
  LDTO.FinalStates := ['s1'];
  LDTO.Transitions := [
    TTransition.Create('s0', 'a', 's1'),
    TTransition.Create('s1', 'a', 's0')
  ];

  LActual := Check(LDTO, AWord);
  Assert.AreEqual(LActual, AExpected);
end;

procedure TExercisesFixture.ExerciseSeven(const AWord: string; const AExpected: Boolean);
var
	LDTO: TDTO;
	LActual: Boolean;
begin
  LDTO.States := ['s0', 's1', 's2', 's3'];
  LDTO.Symbols := ['a', 'b'];
  LDTO.InitialState := 's0';
  LDTO.FinalStates := ['s3'];
  LDTO.Transitions := [
    TTransition.Create('s0', 'a', 's1'),
    TTransition.Create('s1', 'a', 's3'),
    TTransition.Create('s1', 'b', 's2'),
    TTransition.Create('s2', 'b', 's1')
  ];

  LActual := Check(LDTO, AWord);
  Assert.AreEqual(LActual, AExpected);
end;

procedure TExercisesFixture.ExerciseEight(const AWord: string; const AExpected: Boolean);
var
	LDTO: TDTO;
	LActual: Boolean;
begin
  LDTO.States := ['s0', 's1', 's2', 's3', 's4'];
  LDTO.Symbols := ['a', 'b', 'c'];
  LDTO.InitialState := 's0';
  LDTO.FinalStates := ['s4'];
  LDTO.Transitions := [
    TTransition.Create('s0', 'a', 's1'),
    TTransition.Create('s1', 'b', 's2'),
    TTransition.Create('s2', 'c', 's3'),
    TTransition.Create('s3', 'a', 's4'),
    TTransition.Create('s3', 'b', 's2')
  ];

  LActual := Check(LDTO, AWord);
  Assert.AreEqual(LActual, AExpected);
end;

procedure TExercisesFixture.ExerciseNine(const AWord: string; const AExpected: Boolean);
var
	LDTO: TDTO;
	LActual: Boolean;
begin
  LDTO.States := ['s0', 's1', 's2', 's3'];
  LDTO.Symbols := ['a', 'b', 'c'];
  LDTO.InitialState := 's0';
  LDTO.FinalStates := ['s1', 's2', 's3'];
  LDTO.Transitions := [
    TTransition.Create('s0', 'a', 's1'),
    TTransition.Create('s1', 'a', 's1'),
    TTransition.Create('s1', 'b', 's2'),
    TTransition.Create('s1', 'c', 's3'),
    TTransition.Create('s2', 'b', 's2'),
    TTransition.Create('s2', 'c', 's3'),
    TTransition.Create('s3', 'c', 's3')
  ];

  LActual := Check(LDTO, AWord);
  Assert.AreEqual(LActual, AExpected);
end;

procedure TExercisesFixture.ExerciseTen(const AWord: string; const AExpected: Boolean);
var
	LDTO: TDTO;
	LActual: Boolean;
begin
  LDTO.States := ['s0', 's1', 's2', 's3', 's4', 's5'];
  LDTO.Symbols := ['a', 'b'];
  LDTO.InitialState := 's0';
  LDTO.FinalStates := ['s2'];
  LDTO.Transitions := [
    TTransition.Create('s0', 'a', 's3'),
    TTransition.Create('s0', 'b', 's1'),
    TTransition.Create('s1', 'b', 's2'),
    TTransition.Create('s2', 'a', 's5'),
    TTransition.Create('s3', 'a', 's4'),
    TTransition.Create('s4', 'a', 's3'),
    TTransition.Create('s4', 'b', 's1'),
    TTransition.Create('s5', 'a', 's2')
  ];

  LActual := Check(LDTO, AWord);
  Assert.AreEqual(LActual, AExpected);
end;

initialization
  TDUnitX.RegisterTestFixture(TExercisesFixture);

end.

