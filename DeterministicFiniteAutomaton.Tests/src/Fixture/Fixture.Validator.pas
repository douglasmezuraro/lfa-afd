unit Fixture.Validator;

interface

uses
  DUnitX.TestFramework, System.SysUtils, DFA;

type
  [TestFixture]
  TValidatorFixture = class sealed
  private
    procedure Validate(const ADTO: TDTO);
  public
    [Test]
    procedure WhenHasDuplicatedSymbol;

    [Test]
    procedure WhenHasDuplicatedState;

    [Test]
    procedure WhenHasStatesAndIntitialStateIsNotDefined;

    [Test]
    procedure WhenStatesNotContaisTheInitialState;

    [Test]
    procedure WhenHasStatesAndFinalStatesIsNotDefined;

    [Test]
    procedure WhenHasDuplicatedFinalStates;

    [Test]
    procedure WhenStastesNotContainsTheFinalState;

    [Test]
    procedure WhenTransitionsIsNotDefined;

    [Test]
    procedure WhenTransitionSourceIsNotDefined;

    [Test]
    procedure WhenStatesNotContainsTransitionSource;

    [Test]
    procedure WhenTransitionSymbolWasNotDefined;

    [Test]
    procedure WhenSymbolsNotContainsTransitionSymbol;

    [Test]
    procedure WhenTransitionTargetIsNotDefined;

    [Test]
    procedure WhenStatesNotContaisTransitionTarget;

    [Test]
    procedure TestValidateWhenAutomatonIsValid;
  end;

implementation

procedure TValidatorFixture.Validate(const ADTO: TDTO);
var
  LValidator: TValidator;
begin
  LValidator := TValidator.Create(ADTO);
  try
    LValidator.Validate;
  finally
    LValidator.Free;
  end;
end;

procedure TValidatorFixture.WhenHasDuplicatedSymbol;
var
  LDTO: TDTO;
begin
  LDTO.States := ['s0', 's1'];
  LDTO.Symbols := ['a', 'a'];
  LDTO.InitialState := 's0';
  LDTO.FinalStates := ['s1'];
  LDTO.Transitions := [
    TTransition.Create('s0', 'a', 's1'),
    TTransition.Create('s1', 'a', 's1')
  ];

  Assert.WillRaise(
    procedure
    begin
      Validate(LDTO);
    end,
    EDuplicatedSymbol,
    'The symbol "a" is duplicated.');
end;

procedure TValidatorFixture.WhenHasDuplicatedState;
var
  LDTO: TDTO;
begin
  LDTO.States := ['s0', 's1', 's1'];
  LDTO.Symbols := ['a'];
  LDTO.InitialState := 's0';
  LDTO.FinalStates := ['s1'];
  LDTO.Transitions := [
    TTransition.Create('s0', 'a', 's1'),
    TTransition.Create('s1', 'a', 's1')
  ];

  Assert.WillRaise(
    procedure
    begin
      Validate(LDTO);
    end,
    EDuplicatedState,
    'The state "s1" is duplicated.');
end;

procedure TValidatorFixture.WhenHasStatesAndIntitialStateIsNotDefined;
var
  LDTO: TDTO;
begin
  LDTO.States := ['s0', 's1'];
  LDTO.Symbols := ['a'];
  LDTO.InitialState := TState.Empty;
  LDTO.FinalStates := ['s1'];
  LDTO.Transitions := [
    TTransition.Create('s0', 'a', 's1'),
    TTransition.Create('s1', 'a', 's1')
  ];

  Assert.WillRaise(
    procedure
    begin
      Validate(LDTO);
    end,
    EInitialStateNotDefined,
    'The initial state is not defined.');
end;

procedure TValidatorFixture.WhenStatesNotContaisTheInitialState;
var
  LDTO: TDTO;
begin
  LDTO.States := ['s0', 's1'];
  LDTO.Symbols := ['a'];
  LDTO.InitialState := 's2';
  LDTO.FinalStates := ['s1'];
  LDTO.Transitions := [
    TTransition.Create('s0', 'a', 's1'),
    TTransition.Create('s1', 'a', 's1')
  ];

  Assert.WillRaise(
    procedure
    begin
      Validate(LDTO);
    end,
    EStatesNotContaisTheState,
    'The state "s3" is not in states list "[s0, s1]".');
end;

procedure TValidatorFixture.WhenHasStatesAndFinalStatesIsNotDefined;
var
  LDTO: TDTO;
begin
  LDTO.States := ['s0', 's1'];
  LDTO.Symbols := ['a'];
  LDTO.InitialState := 's0';
  LDTO.FinalStates := [];
  LDTO.Transitions := [
    TTransition.Create('s0', 'a', 's1'),
    TTransition.Create('s1', 'a', 's1')
  ];

  Assert.WillRaise(
    procedure
    begin
      Validate(LDTO);
    end,
    EFinalStatesNotDefined,
    'The final states is not defined.');
end;

procedure TValidatorFixture.WhenHasDuplicatedFinalStates;
var
  LDTO: TDTO;
begin
  LDTO.States := ['s0', 's1'];
  LDTO.Symbols := ['a'];
  LDTO.InitialState := 's0';
  LDTO.FinalStates := ['s1', 's1'];
  LDTO.Transitions := [
    TTransition.Create('s0', 'a', 's1'),
    TTransition.Create('s1', 'a', 's1')
  ];

  Assert.WillRaise(
    procedure
    begin
      Validate(LDTO);
    end,
    EDuplicatedState,
    'The state "s1" is duplicated.');
end;

procedure TValidatorFixture.WhenStastesNotContainsTheFinalState;
var
  LDTO: TDTO;
begin
  LDTO.States := ['s0', 's1'];
  LDTO.Symbols := ['a'];
  LDTO.InitialState := 's0';
  LDTO.FinalStates := ['s2'];
  LDTO.Transitions := [
    TTransition.Create('s0', 'a', 's1'),
    TTransition.Create('s1', 'a', 's1')
  ];

  Assert.WillRaise(
    procedure
    begin
      Validate(LDTO);
    end,
    EStatesNotContaisTheState,
    'The final state "s2" is not in states list "[s0, s1]".');
end;

procedure TValidatorFixture.WhenTransitionsIsNotDefined;
var
  LDTO: TDTO;
begin
  LDTO.States := ['s0', 's1'];
  LDTO.Symbols := ['a'];
  LDTO.InitialState := 's0';
  LDTO.FinalStates := ['s1'];
  LDTO.Transitions := [];

  Assert.WillRaise(
    procedure
    begin
      Validate(LDTO);
    end,
    ETransitionsNotDefined,
    'The transitions has been not defined.');
end;

procedure TValidatorFixture.WhenTransitionSourceIsNotDefined;
var
  LDTO: TDTO;
begin
  LDTO.States := ['s0', 's1'];
  LDTO.Symbols := ['a'];
  LDTO.InitialState := 's0';
  LDTO.FinalStates := ['s1'];
  LDTO.Transitions := [
    TTransition.Create('', 'a', 's1'),
    TTransition.Create('s1', 'a', 's1')
  ];

  Assert.WillRaise(
    procedure
    begin
      Validate(LDTO);
    end,
    ESourceStateNotDefined,
    'The transition source state is not defined.');
end;

procedure TValidatorFixture.WhenStatesNotContainsTransitionSource;
var
  LDTO: TDTO;
begin
  LDTO.States := ['s0', 's1'];
  LDTO.Symbols := ['a'];
  LDTO.InitialState := 's0';
  LDTO.FinalStates := ['s1'];
  LDTO.Transitions := [
    TTransition.Create('s2', 'a', 's1'),
    TTransition.Create('s1', 'a', 's1')
  ];

  Assert.WillRaise(
    procedure
    begin
      Validate(LDTO);
    end,
    EStatesNotContaisTheState,
    'The source state "s2" is not in states list "[s0, s1]".');
end;

procedure TValidatorFixture.WhenTransitionSymbolWasNotDefined;
var
  LDTO: TDTO;
begin
  LDTO.States := ['s0', 's1'];
  LDTO.Symbols := ['a'];
  LDTO.InitialState := 's0';
  LDTO.FinalStates := ['s1'];
  LDTO.Transitions := [
    TTransition.Create('s0', '', 's1'),
    TTransition.Create('s1', 'a', 's1')
  ];

  Assert.WillRaise(
    procedure
    begin
      Validate(LDTO);
    end,
    ESymbolNotDefined,
    'The transition symbol is not defined.');
end;

procedure TValidatorFixture.WhenSymbolsNotContainsTransitionSymbol;
var
  LDTO: TDTO;
begin
  LDTO.States := ['s0', 's1'];
  LDTO.Symbols := ['a'];
  LDTO.InitialState := 's0';
  LDTO.FinalStates := ['s1'];
  LDTO.Transitions := [
    TTransition.Create('s0', 'b', 's1'),
    TTransition.Create('s1', 'a', 's1')
  ];

  Assert.WillRaise(
    procedure
    begin
      Validate(LDTO);
    end,
    ESymbolsNotContainsTheSymbol,
    'The symbol "b" is not in symbols list "[a]".');
end;

procedure TValidatorFixture.WhenTransitionTargetIsNotDefined;
var
  LDTO: TDTO;
begin
  LDTO.States := ['s0', 's1'];
  LDTO.Symbols := ['a'];
  LDTO.InitialState := 's0';
  LDTO.FinalStates := ['s1'];
  LDTO.Transitions := [
    TTransition.Create('s0', 'a', ''),
    TTransition.Create('s1', 'a', 's1')
  ];

  Assert.WillRaise(
    procedure
    begin
      Validate(LDTO);
    end,
    ETargetStateNotDefined,
    'The transition target state is not defined');
end;

procedure TValidatorFixture.WhenStatesNotContaisTransitionTarget;
var
  LDTO: TDTO;
begin
  LDTO.States := ['s0', 's1'];
  LDTO.Symbols := ['a'];
  LDTO.InitialState := 's0';
  LDTO.FinalStates := ['s1'];
  LDTO.Transitions := [
    TTransition.Create('s0', 'a', 's2'),
    TTransition.Create('s1', 'a', 's1')
  ];

  Assert.WillRaise(
    procedure
    begin
      Validate(LDTO);
    end,
    EStatesNotContaisTheState,
    'The target state "s2" is not in states list "[s0, s1]".');
end;

procedure TValidatorFixture.TestValidateWhenAutomatonIsValid;
var
  LDTO: TDTO;
begin
  LDTO.States := ['s0', 's1'];
  LDTO.Symbols := ['a'];
  LDTO.InitialState := 's0';
  LDTO.FinalStates := ['s1'];
  LDTO.Transitions := [
    TTransition.Create('s0', 'a', 's1'),
    TTransition.Create('s1', 'a', 's1')
  ];

  Assert.WillNotRaiseAny(
    procedure
    begin
      Validate(LDTO);
    end);
end;

initialization
  TDUnitX.RegisterTestFixture(TValidatorFixture);

end.

