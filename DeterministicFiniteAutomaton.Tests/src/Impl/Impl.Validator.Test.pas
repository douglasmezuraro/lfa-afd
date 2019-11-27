unit Impl.Validator.Test;

interface

uses
  Impl.DeterministicFiniteAutomaton, Impl.Transition, Impl.Transitions, Impl.Types, Impl.Validator,
  System.SysUtils, TestFramework;

type
  TAFDValidationsTest = class(TTestCase)
  strict private
    FValidator: TValidator;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestAcceptWhenNoSymbolsDefined;
    procedure TestAcceptWhenDuplicatedSymbol;
    procedure TestAcceptWhenNoStatesDefined;
    procedure TestAcceptWhenDuplicatedState;
    procedure TestAcceptWhenInitialStateNotDefined;
    procedure TestAcceptWhenInitialStateNotFound;
    procedure TestAcceptWhenFinalStatesNotDefined;
    procedure TestAcceptWhenDuplicatedFinalStates;
    procedure TestAcceptWhenFinalStatesNotFound;
    procedure TestAcceptWhenTransitionsNotDefined;
    procedure TestAcceptWhenTransitionHasSourceNotDefined;
    procedure TestAcceptWhenTransitionHasSourceNotFound;
    procedure TestAcceptWhenTransitionHasSymbolNotDefined;
    procedure TestAcceptWhenTransitionHasSymbolNotFound;
    procedure TestAcceptWhenTransitionHasTargetNotDefined;
    procedure TestAcceptWhenTransitionHasTargetNotFound;
    procedure TestAcceptWhenAutomatonIsValid;
  end;

implementation

procedure TAFDValidationsTest.SetUp;
begin
  inherited SetUp;
  FValidator := TValidator.Create;
end;

procedure TAFDValidationsTest.TearDown;
begin
  FValidator.Free;
  inherited TearDown;
end;

procedure TAFDValidationsTest.TestAcceptWhenAutomatonIsValid;
var
  Automaton: TDeterministicFiniteAutomaton;
begin
  Automaton := TDeterministicFiniteAutomaton.Create;
  try
    Automaton.Symbols := ['a', 'b'];
    Automaton.States := ['Q0', 'Q1'];
    Automaton.InitialState := 'Q0';
    Automaton.FinalStates := ['Q1'];
    Automaton.Transitions.Add(TTransition.Create('Q0', 'a', 'Q1'));
    Automaton.Transitions.Add(TTransition.Create('Q0', 'b', 'Q1'));
    Automaton.Transitions.Add(TTransition.Create('Q1', 'a', 'Q1'));
    Automaton.Transitions.Add(TTransition.Create('Q1', 'b', 'Q1'));

    CheckTrue(FValidator.Validate(Automaton));
  finally
    Automaton.Free;
  end;
end;

procedure TAFDValidationsTest.TestAcceptWhenDuplicatedFinalStates;
var
  Automaton: TDeterministicFiniteAutomaton;
begin
  Automaton := TDeterministicFiniteAutomaton.Create;
  try
  	Automaton.Symbols := ['a', 'b', 'c'];
    Automaton.States := ['Q0', 'Q1', 'Q2', 'Q3'];
    Automaton.InitialState := 'Q0';
    Automaton.FinalStates := ['Q3', 'Q3'];

    CheckFalse(FValidator.Validate(Automaton));
  finally
    Automaton.Free;
  end;
end;

procedure TAFDValidationsTest.TestAcceptWhenDuplicatedState;
var
  Automaton: TDeterministicFiniteAutomaton;
begin
  Automaton := TDeterministicFiniteAutomaton.Create;
  try
    Automaton.Symbols := ['a', 'b', 'c'];
    Automaton.States := ['Q0', 'Q0', 'Q1', 'Q2', 'Q3'];
    Automaton.InitialState := TState.Empty;
    Automaton.FinalStates := [];

    CheckFalse(FValidator.Validate(Automaton));
  finally
    Automaton.Free;
  end;
end;

procedure TAFDValidationsTest.TestAcceptWhenDuplicatedSymbol;
var
  Automaton: TDeterministicFiniteAutomaton;
begin
  Automaton := TDeterministicFiniteAutomaton.Create;
  try
    Automaton.Symbols := ['a', 'b', 'b', 'c'];
    Automaton.States := [];
    Automaton.InitialState := TState.Empty;
    Automaton.FinalStates := [];

    CheckFalse(FValidator.Validate(Automaton));
  finally
    Automaton.Free;
  end;
end;

procedure TAFDValidationsTest.TestAcceptWhenFinalStatesNotDefined;
var
  Automaton: TDeterministicFiniteAutomaton;
begin
  Automaton := TDeterministicFiniteAutomaton.Create;
  try
    Automaton.Symbols := ['a', 'b', 'c'];
    Automaton.States := ['Q0', 'Q1', 'Q2', 'Q3'];
    Automaton.InitialState := 'Q0';
    Automaton.FinalStates := [];

    CheckFalse(FValidator.Validate(Automaton));
  finally
    Automaton.Free;
  end;
end;

procedure TAFDValidationsTest.TestAcceptWhenFinalStatesNotFound;
var
  Automaton: TDeterministicFiniteAutomaton;
begin
  Automaton := TDeterministicFiniteAutomaton.Create;
  try
    Automaton.Symbols := ['a', 'b', 'c'];
    Automaton.States := ['Q0', 'Q1', 'Q2', 'Q3'];
    Automaton.InitialState := 'Q0';
    Automaton.FinalStates := ['Q4'];

    CheckFalse(FValidator.Validate(Automaton));
  finally
    Automaton.Free;
  end;
end;

procedure TAFDValidationsTest.TestAcceptWhenInitialStateNotDefined;
var
  Automaton: TDeterministicFiniteAutomaton;
begin
  Automaton := TDeterministicFiniteAutomaton.Create;
  try
    Automaton.Symbols := ['a', 'b', 'c'];
    Automaton.States := ['Q0', 'Q1', 'Q2', 'Q3'];
    Automaton.InitialState := TState.Empty;
    Automaton.FinalStates := [];

    CheckFalse(FValidator.Validate(Automaton));
  finally
    Automaton.Free;
  end;
end;

procedure TAFDValidationsTest.TestAcceptWhenInitialStateNotFound;
var
  Automaton: TDeterministicFiniteAutomaton;
begin
  Automaton := TDeterministicFiniteAutomaton.Create;
  try
    Automaton.Symbols := ['a', 'b', 'c'];
    Automaton.States := ['Q0', 'Q1', 'Q2', 'Q3'];
    Automaton.InitialState := 'Q4';
    Automaton.FinalStates := [];

    CheckFalse(FValidator.Validate(Automaton));
  finally
    Automaton.Free;
  end;
end;

procedure TAFDValidationsTest.TestAcceptWhenNoStatesDefined;
var
  Automaton: TDeterministicFiniteAutomaton;
begin
  Automaton := TDeterministicFiniteAutomaton.Create;
  try
    Automaton.Symbols := ['a', 'b', 'c'];
    Automaton.States := [];
    Automaton.InitialState := TState.Empty;
    Automaton.FinalStates := [];

    CheckFalse(FValidator.Validate(Automaton));
  finally
    Automaton.Free;
  end;
end;

procedure TAFDValidationsTest.TestAcceptWhenNoSymbolsDefined;
var
  Automaton: TDeterministicFiniteAutomaton;
begin
  Automaton := TDeterministicFiniteAutomaton.Create;
  try
    Automaton.Symbols := [];
    Automaton.States := [];
    Automaton.InitialState := TState.Empty;
    Automaton.FinalStates := [];

    CheckFalse(FValidator.Validate(Automaton));
  finally
    Automaton.Free;
  end;
end;

procedure TAFDValidationsTest.TestAcceptWhenTransitionHasSourceNotDefined;
var
  Automaton: TDeterministicFiniteAutomaton;
begin
  Automaton := TDeterministicFiniteAutomaton.Create;
  try
    Automaton.Symbols := ['a', 'b'];
    Automaton.States := ['Q0', 'Q1'];
    Automaton.InitialState := 'Q0';
    Automaton.FinalStates := ['Q1'];
    Automaton.Transitions.Add(TTransition.Create(TState.Empty, 'a', 'Q1'));
    Automaton.Transitions.Add(TTransition.Create('Q0', 'b', 'Q1'));
    Automaton.Transitions.Add(TTransition.Create('Q1', 'a', 'Q1'));
    Automaton.Transitions.Add(TTransition.Create('Q1', 'b', 'Q1'));

    CheckFalse(FValidator.Validate(Automaton));
  finally
    Automaton.Free;
  end;
end;

procedure TAFDValidationsTest.TestAcceptWhenTransitionHasSourceNotFound;
var
  Automaton: TDeterministicFiniteAutomaton;
begin
  Automaton := TDeterministicFiniteAutomaton.Create;
  try
    Automaton.Symbols := ['a', 'b'];
    Automaton.States := ['Q0', 'Q1'];
    Automaton.InitialState := 'Q0';
    Automaton.FinalStates := ['Q1'];
    Automaton.Transitions.Add(TTransition.Create('Q0', 'a', 'Q1'));
    Automaton.Transitions.Add(TTransition.Create('Q2', 'b', 'Q1'));
    Automaton.Transitions.Add(TTransition.Create('Q1', 'a', 'Q1'));
    Automaton.Transitions.Add(TTransition.Create('Q1', 'b', 'Q1'));

    CheckFalse(FValidator.Validate(Automaton));
  finally
    Automaton.Free;
  end;
end;

procedure TAFDValidationsTest.TestAcceptWhenTransitionHasSymbolNotDefined;
var
  Automaton: TDeterministicFiniteAutomaton;
begin
  Automaton := TDeterministicFiniteAutomaton.Create;
  try
    Automaton.Symbols := ['a', 'b'];
    Automaton.States := ['Q0', 'Q1'];
    Automaton.InitialState := 'Q0';
    Automaton.FinalStates := ['Q1'];
    Automaton.Transitions.Add(TTransition.Create('Q0', 'a', 'Q1'));
    Automaton.Transitions.Add(TTransition.Create('Q0', 'b', 'Q1'));
    Automaton.Transitions.Add(TTransition.Create('Q1', TSymbol.Empty, 'Q1'));
    Automaton.Transitions.Add(TTransition.Create('Q1', 'b', 'Q1'));

    CheckFalse(FValidator.Validate(Automaton));
  finally
    Automaton.Free;
  end;
end;

procedure TAFDValidationsTest.TestAcceptWhenTransitionHasSymbolNotFound;
var
  Automaton: TDeterministicFiniteAutomaton;
begin
  Automaton := TDeterministicFiniteAutomaton.Create;
  try
    Automaton.Symbols := ['a', 'b'];
    Automaton.States := ['Q0', 'Q1'];
    Automaton.InitialState := 'Q0';
    Automaton.FinalStates := ['Q1'];
    Automaton.Transitions.Add(TTransition.Create('Q0', 'a', 'Q1'));
    Automaton.Transitions.Add(TTransition.Create('Q0', 'b', 'Q1'));
    Automaton.Transitions.Add(TTransition.Create('Q1', 'a', 'Q1'));
    Automaton.Transitions.Add(TTransition.Create('Q1', 'c', 'Q1'));

    CheckFalse(FValidator.Validate(Automaton));
  finally
    Automaton.Free;
  end;
end;

procedure TAFDValidationsTest.TestAcceptWhenTransitionHasTargetNotDefined;
var
  Automaton: TDeterministicFiniteAutomaton;
begin
  Automaton := TDeterministicFiniteAutomaton.Create;
  try
    Automaton.Symbols := ['a', 'b'];
    Automaton.States := ['Q0', 'Q1'];
    Automaton.InitialState := 'Q0';
    Automaton.FinalStates := ['Q1'];
    Automaton.Transitions.Add(TTransition.Create('Q0', 'a', TState.Empty));
    Automaton.Transitions.Add(TTransition.Create('Q0', 'b', 'Q1'));
    Automaton.Transitions.Add(TTransition.Create('Q1', 'a', 'Q1'));
    Automaton.Transitions.Add(TTransition.Create('Q1', 'c', 'Q1'));

    CheckFalse(FValidator.Validate(Automaton));
  finally
    Automaton.Free;
  end;
end;

procedure TAFDValidationsTest.TestAcceptWhenTransitionHasTargetNotFound;
var
  Automaton: TDeterministicFiniteAutomaton;
begin
  Automaton := TDeterministicFiniteAutomaton.Create;
  try
    Automaton.Symbols := ['a', 'b'];
    Automaton.States := ['Q0', 'Q1'];
    Automaton.InitialState := 'Q0';
    Automaton.FinalStates := ['Q1'];
    Automaton.Transitions.Add(TTransition.Create('Q0', 'a', 'Q1'));
    Automaton.Transitions.Add(TTransition.Create('Q0', 'b', 'Q1'));
    Automaton.Transitions.Add(TTransition.Create('Q1', 'a', 'Q4'));
    Automaton.Transitions.Add(TTransition.Create('Q1', 'c', 'Q1'));

    CheckFalse(FValidator.Validate(Automaton));
  finally
    Automaton.Free;
  end;
end;

procedure TAFDValidationsTest.TestAcceptWhenTransitionsNotDefined;
var
  Automaton: TDeterministicFiniteAutomaton;
begin
  Automaton := TDeterministicFiniteAutomaton.Create;
  try
    Automaton.Symbols := ['a', 'b'];
    Automaton.States := ['Q0', 'Q1'];
    Automaton.InitialState := 'Q0';
    Automaton.FinalStates := ['Q1'];

    CheckFalse(FValidator.Validate(Automaton));
  finally
    Automaton.Free;
  end;
end;

initialization
  RegisterTest(TAFDValidationsTest.Suite);

end.

