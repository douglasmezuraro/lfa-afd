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
    procedure TestValidateWhenAutomatonHasDuplicatedSymbol;

    [Test]
    procedure TestValidateWhenAutomatonHasDuplicatedState;

    [Test]
    procedure TestValidateWhenAutomatonHasNotStatesAndInitialStateIsNotDefined;

    [Test]
    procedure TestValidateWhenAutomatonHasStatesAndIntitialStatesIsNotDefined;

    [Test]
    procedure TestValidateWhenAutomatonInitialStateIsNotFound;

    [Test]
    procedure TestValidateWhenAutomatonHasNotStatesAndFinalStatesIsNotDefined;

    [Test]
    procedure TestValidateWhenAutomatonHasStatesFinalStatesIsNotDefined;

    [Test]
    procedure TestValidateWhenAutomatonHasDuplicatedFinalStates;

    [Test]
    procedure TestValidateWhenAutomatonHasFinalStatesNotFound;

    [Test]
    procedure TestValidateWhenAutomatonHasNotStatesAndTransitionsIsNotDefined;

    [Test]
    procedure TestValidateWhenAutomatonHasStatesAndTransitionsIsNotDefined;

    [Test]
    procedure TestValidateWhenAutomatonHasTransitionHasSourceNotDefined;

    [Test]
    procedure TestValidateWhenAutomatonHasTransitionHasSourceNotFound;

    [Test]
    procedure TestValidateWhenAutomatonHasTransitionHasSymbolNotDefined;

    [Test]
    procedure TestValidateWhenAutomatonHasTransitionHasSymbolNotFound;

    [Test]
    procedure TestValidateWhenAutomatonHasTransitionHasTargetNotDefined;

    [Test]
    procedure TestValidateWhenAutomatonHasTransitionHasTargetNotFound;

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

procedure TValidatorFixture.TestValidateWhenAutomatonHasDuplicatedSymbol;
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

procedure TValidatorFixture.TestValidateWhenAutomatonHasDuplicatedState;
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

procedure TValidatorFixture.TestValidateWhenAutomatonHasNotStatesAndInitialStateIsNotDefined;
var
  LDTO: TDTO;
begin
  LDTO.States := [];
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

procedure TValidatorFixture.TestValidateWhenAutomatonHasStatesAndIntitialStatesIsNotDefined;
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

procedure TValidatorFixture.TestValidateWhenAutomatonInitialStateIsNotFound;
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

procedure TValidatorFixture.TestValidateWhenAutomatonHasNotStatesAndFinalStatesIsNotDefined;
var
  LDTO: TDTO;
begin
  LDTO.States := [];
  LDTO.Symbols := ['a', 'b', 'c', 'd'];
  LDTO.InitialState := TState.Empty;
  LDTO.FinalStates := [];
  LDTO.Transitions := [];

  Assert.WillRaise(
    procedure
    begin
      Validate(LDTO);
    end);
end;

procedure TValidatorFixture.TestValidateWhenAutomatonHasStatesFinalStatesIsNotDefined;
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

procedure TValidatorFixture.TestValidateWhenAutomatonHasDuplicatedFinalStates;
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

procedure TValidatorFixture.TestValidateWhenAutomatonHasFinalStatesNotFound;
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

procedure TValidatorFixture.TestValidateWhenAutomatonHasNotStatesAndTransitionsIsNotDefined;
var
  LDTO: TDTO;
begin
  LDTO.States := [];
  LDTO.Symbols := [];
  LDTO.InitialState := TState.Empty;
  LDTO.FinalStates := [];
  LDTO.Transitions := [];

  Assert.WillRaise(
    procedure
    begin
      Validate(LDTO);
    end);
end;

procedure TValidatorFixture.TestValidateWhenAutomatonHasStatesAndTransitionsIsNotDefined;
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

procedure TValidatorFixture.TestValidateWhenAutomatonHasTransitionHasSourceNotDefined;
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

procedure TValidatorFixture.TestValidateWhenAutomatonHasTransitionHasSourceNotFound;
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

procedure TValidatorFixture.TestValidateWhenAutomatonHasTransitionHasSymbolNotDefined;
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

procedure TValidatorFixture.TestValidateWhenAutomatonHasTransitionHasSymbolNotFound;
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

procedure TValidatorFixture.TestValidateWhenAutomatonHasTransitionHasTargetNotDefined;
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

procedure TValidatorFixture.TestValidateWhenAutomatonHasTransitionHasTargetNotFound;
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

  Assert.WillNotRaise(
    procedure
    begin
      Validate(LDTO);
    end);
end;

initialization
  TDUnitX.RegisterTestFixture(TValidatorFixture);

end.

