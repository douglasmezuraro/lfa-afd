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
  LDTO.States := [];
  LDTO.Symbols := ['a', 'b', 'b', 'c'];
  LDTO.InitialState := TState.Empty;
  LDTO.FinalStates := [];
  LDTO.Transitions := [];

  Assert.WillRaise(
    procedure
    begin
      Validate(LDTO);
    end);
end;

procedure TValidatorFixture.WhenHasDuplicatedState;
var
  LDTO: TDTO;
begin
  LDTO.States := ['q0', 'q0', 'q1', 'q2', 'q3'];
  LDTO.Symbols := ['a', 'b', 'c'];
  LDTO.InitialState := TState.Empty;
  LDTO.FinalStates := [];
  LDTO.Transitions := [];

  Assert.WillRaise(
    procedure
    begin
      Validate(LDTO);
    end);
end;

procedure TValidatorFixture.WhenHasStatesAndIntitialStateIsNotDefined;
var
  LDTO: TDTO;
begin
  LDTO.States := ['q0', 'q1'];
  LDTO.Symbols := ['a', 'b', 'c'];
  LDTO.InitialState := TState.Empty;
  LDTO.FinalStates := ['q1'];
  LDTO.Transitions := [];

  Assert.WillRaise(
    procedure
    begin
      Validate(LDTO);
    end);
end;

procedure TValidatorFixture.WhenStatesNotContaisTheInitialState;
var
  LDTO: TDTO;
begin
  LDTO.States := ['q0', 'q1', 'q2', 'q3'];
  LDTO.Symbols := ['a', 'b', 'c'];
  LDTO.InitialState := 'q4';
  LDTO.FinalStates := [];
  LDTO.Transitions := [];

  Assert.WillRaise(
    procedure
    begin
      Validate(LDTO);
    end);
end;

procedure TValidatorFixture.WhenHasStatesAndFinalStatesIsNotDefined;
var
  LDTO: TDTO;
begin
  LDTO.States := ['q0', 'q1', 'q2', 'q3'];
  LDTO.Symbols := ['a', 'b', 'c'];
  LDTO.InitialState := 'q0';
  LDTO.FinalStates := [];
  LDTO.Transitions := [];

  Assert.WillRaise(
    procedure
    begin
      Validate(LDTO);
    end);
end;

procedure TValidatorFixture.WhenHasDuplicatedFinalStates;
var
  LDTO: TDTO;
begin
  LDTO.States := ['q0', 'q1', 'q2', 'q3'];
  LDTO.Symbols := ['a', 'b', 'c'];
  LDTO.InitialState := 'q0';
  LDTO.FinalStates := ['q3', 'q3'];
  LDTO.Transitions := [];

  Assert.WillRaise(
    procedure
    begin
      Validate(LDTO);
    end);
end;

procedure TValidatorFixture.WhenStastesNotContainsTheFinalState;
var
  LDTO: TDTO;
begin
  LDTO.States := ['q0', 'q1', 'q2', 'q3'];
  LDTO.Symbols := ['a', 'b', 'c'];
  LDTO.InitialState := 'q0';
  LDTO.FinalStates := ['q4'];
  LDTO.Transitions := [];

  Assert.WillRaise(
    procedure
    begin
      Validate(LDTO);
    end);
end;

procedure TValidatorFixture.WhenTransitionsIsNotDefined;
var
  LDTO: TDTO;
begin
  LDTO.States := ['q0', 'q1'];
  LDTO.Symbols := ['a', 'b'];
  LDTO.InitialState := 'q0';
  LDTO.FinalStates := ['q1'];
  LDTO.Transitions := [];

  Assert.WillRaise(
    procedure
    begin
      Validate(LDTO);
    end);
end;

procedure TValidatorFixture.WhenTransitionSourceIsNotDefined;
var
  LDTO: TDTO;
begin
  LDTO.States := ['q0', 'q1'];
  LDTO.Symbols := ['a', 'b'];
  LDTO.InitialState := 'q0';
  LDTO.FinalStates := ['q1'];
  LDTO.Transitions := [
    TTransition.Create('', 'a', 'q1'),
    TTransition.Create('q0', 'b', 'q1'),
    TTransition.Create('q1', 'a', 'q1'),
    TTransition.Create('q1', 'b', 'q1')
  ];

  Assert.WillRaise(
    procedure
    begin
      Validate(LDTO);
    end);
end;

procedure TValidatorFixture.WhenStatesNotContainsTransitionSource;
var
  LDTO: TDTO;
begin
  LDTO.States := ['q0', 'q1'];
  LDTO.Symbols := ['a', 'b'];
  LDTO.InitialState := 'q0';
  LDTO.FinalStates := ['q1'];
  LDTO.Transitions := [
    TTransition.Create('q0', 'a', 'q1'),
    TTransition.Create('q2', 'b', 'q1'),
    TTransition.Create('q1', 'a', 'q1'),
    TTransition.Create('q1', 'b', 'q1')
  ];

  Assert.WillRaise(
    procedure
    begin
      Validate(LDTO);
    end);
end;

procedure TValidatorFixture.WhenTransitionSymbolWasNotDefined;
var
  LDTO: TDTO;
begin
  LDTO.States := ['q0', 'q1'];
  LDTO.Symbols := ['a', 'b'];
  LDTO.InitialState := 'q0';
  LDTO.FinalStates := ['q1'];
  LDTO.Transitions := [
    TTransition.Create('q0', 'a', 'q1'),
    TTransition.Create('q0', 'b', 'q1'),
    TTransition.Create('q1', '', 'q1'),
    TTransition.Create('q1', 'b', 'q1')
  ];

  Assert.WillRaise(
    procedure
    begin
      Validate(LDTO);
    end);
end;

procedure TValidatorFixture.WhenSymbolsNotContainsTransitionSymbol;
var
  LDTO: TDTO;
begin
  LDTO.States := ['q0', 'q1'];
  LDTO.Symbols := ['a', 'b'];
  LDTO.InitialState := 'q0';
  LDTO.FinalStates := ['q1'];
  LDTO.Transitions := [
    TTransition.Create('q0', 'a', 'q1'),
    TTransition.Create('q0', 'b', 'q1'),
    TTransition.Create('q1', 'a', 'q1'),
    TTransition.Create('q1', 'c', 'q1')
  ];

  Assert.WillRaise(
    procedure
    begin
      Validate(LDTO);
    end);
end;

procedure TValidatorFixture.WhenTransitionTargetIsNotDefined;
var
  LDTO: TDTO;
begin
  LDTO.States := ['q0', 'q1'];
  LDTO.Symbols := ['a', 'b'];
  LDTO.InitialState := 'q0';
  LDTO.FinalStates := ['q1'];
  LDTO.Transitions := [
    TTransition.Create('q0', 'a', ''),
    TTransition.Create('q0', 'b', 'q1'),
    TTransition.Create('q1', 'a', 'q1'),
    TTransition.Create('q1', 'c', 'q1')
  ];

  Assert.WillRaise(
    procedure
    begin
      Validate(LDTO);
    end);
end;

procedure TValidatorFixture.WhenStatesNotContaisTransitionTarget;
var
  LDTO: TDTO;
begin
  LDTO.States := ['q0', 'q1'];
  LDTO.Symbols := ['a', 'b'];
  LDTO.InitialState := 'q0';
  LDTO.FinalStates := ['q1'];
  LDTO.Transitions := [
    TTransition.Create('q0', 'a', 'q1'),
    TTransition.Create('q0', 'b', 'q1'),
    TTransition.Create('q1', 'a', 'q4'),
    TTransition.Create('q1', 'c', 'q1')
  ];

  Assert.WillRaise(
    procedure
    begin
      Validate(LDTO);
    end);
end;

procedure TValidatorFixture.TestValidateWhenAutomatonIsValid;
var
  LDTO: TDTO;
begin
  LDTO.States := ['q0', 'q1'];
  LDTO.Symbols := ['a', 'b'];
  LDTO.InitialState := 'q0';
  LDTO.FinalStates := ['q1'];
  LDTO.Transitions := [
    TTransition.Create('q0', 'a', 'q1'),
    TTransition.Create('q0', 'b', 'q1'),
    TTransition.Create('q1', 'a', 'q1'),
    TTransition.Create('q1', 'b', 'q1')
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

