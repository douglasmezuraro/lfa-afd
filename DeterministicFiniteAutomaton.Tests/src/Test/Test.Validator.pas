unit Test.Validator;

interface

uses
  Impl.DeterministicFiniteAutomaton, Impl.Transition, Impl.Transitions, Impl.Types, Impl.Validator,
  System.SysUtils, TestFramework;

type
  TAFDValidationsTest = class sealed(TTestCase)
  strict private
    FValidator: TValidator;
    FAutomaton: TDeterministicFiniteAutomaton;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestValidateWhenAutomatonHasDuplicatedSymbol;
    procedure TestValidateWhenAutomatonHasDuplicatedState;
    procedure TestValidateWhenAutomatonHasNotStatesAndInitialStateIsNotDefined;
    procedure TestValidateWhenAutomatonHasStatesAndIntitialStatesIsNotDefined;
    procedure TestValidateWhenAutomatonInitialStateIsNotFound;
    procedure TestValidateWhenAutomatonHasNotStatesAndFinalStatesIsNotDefined;
    procedure TestValidateWhenAutomatonHasStatesFinalStatesIsNotDefined;
    procedure TestValidateWhenAutomatonHasDuplicatedFinalStates;
    procedure TestValidateWhenAutomatonHasFinalStatesNotFound;
    procedure TestValidateWhenAutomatonHasNotStatesAndTransitionsIsNotDefined;
    procedure TestValidateWhenAutomatonHasStatesAndTransitionsIsNotDefined;
    procedure TestValidateWhenAutomatonHasTransitionHasSourceNotDefined;
    procedure TestValidateWhenAutomatonHasTransitionHasSourceNotFound;
    procedure TestValidateWhenAutomatonHasTransitionHasSymbolNotDefined;
    procedure TestValidateWhenAutomatonHasTransitionHasSymbolNotFound;
    procedure TestValidateWhenAutomatonHasTransitionHasTargetNotDefined;
    procedure TestValidateWhenAutomatonHasTransitionHasTargetNotFound;
    procedure TestValidateWhenAutomatonIsValid;
  end;

implementation

procedure TAFDValidationsTest.SetUp;
begin
  inherited SetUp;
  FValidator := TValidator.Create;
  FAutomaton := TDeterministicFiniteAutomaton.Create;
end;

procedure TAFDValidationsTest.TearDown;
begin
  FAutomaton.Free;
  FValidator.Free;
  inherited TearDown;
end;

procedure TAFDValidationsTest.TestValidateWhenAutomatonIsValid;
begin
  FAutomaton.Symbols := ['a', 'b'];
  FAutomaton.States := ['q0', 'q1'];
  FAutomaton.InitialState := 'q0';
  FAutomaton.FinalStates := ['q1'];

  FAutomaton.Transitions.Add(TTransition.Create('q0', 'a', 'q1'))
                        .Add(TTransition.Create('q0', 'b', 'q1'))
                        .Add(TTransition.Create('q1', 'a', 'q1'))
                        .Add(TTransition.Create('q1', 'b', 'q1'));

  CheckTrue(FValidator.Validate(FAutomaton).Key);
end;

procedure TAFDValidationsTest.TestValidateWhenAutomatonHasDuplicatedFinalStates;
begin
  FAutomaton.Symbols := ['a', 'b', 'c'];
  FAutomaton.States := ['q0', 'q1', 'q2', 'q3'];
  FAutomaton.InitialState := 'q0';
  FAutomaton.FinalStates := ['q3', 'q3'];

  CheckFalse(FValidator.Validate(FAutomaton).Key);
end;

procedure TAFDValidationsTest.TestValidateWhenAutomatonHasDuplicatedState;
begin
  FAutomaton.Symbols := ['a', 'b', 'c'];
  FAutomaton.States := ['q0', 'q0', 'q1', 'q2', 'q3'];
  FAutomaton.InitialState := TState.Empty;
  FAutomaton.FinalStates := [];

  CheckFalse(FValidator.Validate(FAutomaton).Key);
end;

procedure TAFDValidationsTest.TestValidateWhenAutomatonHasDuplicatedSymbol;
begin
  FAutomaton.Symbols := ['a', 'b', 'b', 'c'];
  FAutomaton.States := [];
  FAutomaton.InitialState := TState.Empty;
  FAutomaton.FinalStates := [];

  CheckFalse(FValidator.Validate(FAutomaton).Key);
end;

procedure TAFDValidationsTest.TestValidateWhenAutomatonHasStatesFinalStatesIsNotDefined;
begin
  FAutomaton.Symbols := ['a', 'b', 'c'];
  FAutomaton.States := ['q0', 'q1', 'q2', 'q3'];
  FAutomaton.InitialState := 'q0';
  FAutomaton.FinalStates := [];

  CheckFalse(FValidator.Validate(FAutomaton).Key);
end;

procedure TAFDValidationsTest.TestValidateWhenAutomatonHasFinalStatesNotFound;
begin
  FAutomaton.Symbols := ['a', 'b', 'c'];
  FAutomaton.States := ['q0', 'q1', 'q2', 'q3'];
  FAutomaton.InitialState := 'q0';
  FAutomaton.FinalStates := ['q4'];

  CheckFalse(FValidator.Validate(FAutomaton).Key);
end;

procedure TAFDValidationsTest.TestValidateWhenAutomatonHasNotStatesAndFinalStatesIsNotDefined;
begin
  FAutomaton.Symbols := ['a', 'b', 'c', 'd'];
  FAutomaton.States := [];
  FAutomaton.InitialState := TState.Empty;
  FAutomaton.FinalStates := [];

  CheckTrue(FValidator.Validate(FAutomaton).Key);
end;

procedure TAFDValidationsTest.TestValidateWhenAutomatonHasNotStatesAndInitialStateIsNotDefined;
begin
  FAutomaton.Symbols := ['a', 'b', 'c'];
  FAutomaton.States := [];
  FAutomaton.InitialState := TState.Empty;
  FAutomaton.FinalStates := [];

  CheckTrue(FValidator.Validate(FAutomaton).Key);
end;

procedure TAFDValidationsTest.TestValidateWhenAutomatonHasNotStatesAndTransitionsIsNotDefined;
begin
  FAutomaton.Symbols := [];
  FAutomaton.States := [];
  FAutomaton.InitialState := TState.Empty;
  FAutomaton.FinalStates := [];

  CheckTrue(FValidator.Validate(FAutomaton).Key);
end;

procedure TAFDValidationsTest.TestValidateWhenAutomatonHasStatesAndIntitialStatesIsNotDefined;
begin
  FAutomaton.Symbols := ['a', 'b', 'c'];
  FAutomaton.States := ['q0', 'q1'];
  FAutomaton.InitialState := TState.Empty;
  FAutomaton.FinalStates := ['q1'];

  CheckFalse(FValidator.Validate(FAutomaton).Key);
end;

procedure TAFDValidationsTest.TestValidateWhenAutomatonInitialStateIsNotFound;
begin
  FAutomaton.Symbols := ['a', 'b', 'c'];
  FAutomaton.States := ['q0', 'q1', 'q2', 'q3'];
  FAutomaton.InitialState := 'q4';
  FAutomaton.FinalStates := [];

  CheckFalse(FValidator.Validate(FAutomaton).Key);
end;

procedure TAFDValidationsTest.TestValidateWhenAutomatonHasTransitionHasSourceNotDefined;
begin
  FAutomaton.Symbols := ['a', 'b'];
  FAutomaton.States := ['q0', 'q1'];
  FAutomaton.InitialState := 'q0';
  FAutomaton.FinalStates := ['q1'];

  FAutomaton.Transitions.Add(TTransition.Create(TState.Empty, 'a', 'q1'))
                        .Add(TTransition.Create('q0', 'b', 'q1'))
                        .Add(TTransition.Create('q1', 'a', 'q1'))
                        .Add(TTransition.Create('q1', 'b', 'q1'));

  CheckFalse(FValidator.Validate(FAutomaton).Key);
end;

procedure TAFDValidationsTest.TestValidateWhenAutomatonHasTransitionHasSourceNotFound;
begin
  FAutomaton.Symbols := ['a', 'b'];
  FAutomaton.States := ['q0', 'q1'];
  FAutomaton.InitialState := 'q0';
  FAutomaton.FinalStates := ['q1'];

  FAutomaton.Transitions.Add(TTransition.Create('q0', 'a', 'q1'))
                        .Add(TTransition.Create('q2', 'b', 'q1'))
                        .Add(TTransition.Create('q1', 'a', 'q1'))
                        .Add(TTransition.Create('q1', 'b', 'q1'));

  CheckFalse(FValidator.Validate(FAutomaton).Key);
end;

procedure TAFDValidationsTest.TestValidateWhenAutomatonHasTransitionHasSymbolNotDefined;
begin
  FAutomaton.Symbols := ['a', 'b'];
  FAutomaton.States := ['q0', 'q1'];
  FAutomaton.InitialState := 'q0';
  FAutomaton.FinalStates := ['q1'];

  FAutomaton.Transitions.Add(TTransition.Create('q0', 'a', 'q1'))
                        .Add(TTransition.Create('q0', 'b', 'q1'))
                        .Add(TTransition.Create('q1', TSymbol.Empty, 'q1'))
                        .Add(TTransition.Create('q1', 'b', 'q1'));

  CheckFalse(FValidator.Validate(FAutomaton).Key);
end;

procedure TAFDValidationsTest.TestValidateWhenAutomatonHasTransitionHasSymbolNotFound;
begin
  FAutomaton.Symbols := ['a', 'b'];
  FAutomaton.States := ['q0', 'q1'];
  FAutomaton.InitialState := 'q0';
  FAutomaton.FinalStates := ['q1'];

  FAutomaton.Transitions.Add(TTransition.Create('q0', 'a', 'q1'))
                        .Add(TTransition.Create('q0', 'b', 'q1'))
                        .Add(TTransition.Create('q1', 'a', 'q1'))
                        .Add(TTransition.Create('q1', 'c', 'q1'));

  CheckFalse(FValidator.Validate(FAutomaton).Key);
end;

procedure TAFDValidationsTest.TestValidateWhenAutomatonHasTransitionHasTargetNotDefined;
begin
  FAutomaton.Symbols := ['a', 'b'];
  FAutomaton.States := ['q0', 'q1'];
  FAutomaton.InitialState := 'q0';
  FAutomaton.FinalStates := ['q1'];

  FAutomaton.Transitions.Add(TTransition.Create('q0', 'a', TState.Empty))
                        .Add(TTransition.Create('q0', 'b', 'q1'))
                        .Add(TTransition.Create('q1', 'a', 'q1'))
                        .Add(TTransition.Create('q1', 'c', 'q1'));

  CheckFalse(FValidator.Validate(FAutomaton).Key);
end;

procedure TAFDValidationsTest.TestValidateWhenAutomatonHasTransitionHasTargetNotFound;
begin
  FAutomaton.Symbols := ['a', 'b'];
  FAutomaton.States := ['q0', 'q1'];
  FAutomaton.InitialState := 'q0';
  FAutomaton.FinalStates := ['q1'];

  FAutomaton.Transitions.Add(TTransition.Create('q0', 'a', 'q1'))
                        .Add(TTransition.Create('q0', 'b', 'q1'))
                        .Add(TTransition.Create('q1', 'a', 'q4'))
                        .Add(TTransition.Create('q1', 'c', 'q1'));

  CheckFalse(FValidator.Validate(FAutomaton).Key);
end;

procedure TAFDValidationsTest.TestValidateWhenAutomatonHasStatesAndTransitionsIsNotDefined;
begin
  FAutomaton.Symbols := ['a', 'b'];
  FAutomaton.States := ['q0', 'q1'];
  FAutomaton.InitialState := 'q0';
  FAutomaton.FinalStates := ['q1'];

  CheckFalse(FValidator.Validate(FAutomaton).Key);
end;

initialization
  RegisterTest(TAFDValidationsTest.Suite);

end.

