unit Impl.AFD.Validator.Test;

interface

uses
  Impl.AFD, Impl.AFD.Validator, Impl.Transition, Impl.Transitions, Impl.Types, System.SysUtils, TestFramework;

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
  Automaton: TAFD;
begin
  Automaton := TAFD.Create;
  try
    Automaton.Symbols := ['a', 'b'];
    Automaton.States := ['Q0', 'Q1'];
    Automaton.InitialState := 'Q0';
    Automaton.FinalStates := ['Q1'];
    Automaton.Transitions.Add(TTransition.Create('Q0', 'Q1', 'a'));
    Automaton.Transitions.Add(TTransition.Create('Q0', 'Q1', 'b'));
    Automaton.Transitions.Add(TTransition.Create('Q1', 'Q1', 'a'));
    Automaton.Transitions.Add(TTransition.Create('Q1', 'Q1', 'b'));

    CheckTrue(FValidator.Validate(Automaton));
  finally
    Automaton.Free;
  end;
end;

procedure TAFDValidationsTest.TestAcceptWhenDuplicatedFinalStates;
var
  Automaton: TAFD;
begin
  Automaton := TAFD.Create;
  try
  	Automaton.Symbols := ['a', 'b', 'c'];
    Automaton.States := ['S0', 'S1', 'S2', 'S3'];
    Automaton.InitialState := 'S0';
    Automaton.FinalStates := ['S3', 'S3'];

    CheckFalse(FValidator.Validate(Automaton));
  finally
    Automaton.Free;
  end;
end;

procedure TAFDValidationsTest.TestAcceptWhenDuplicatedState;
var
  Automaton: TAFD;
begin
  Automaton := TAFD.Create;
  try
    Automaton.Symbols := ['a', 'b', 'c'];
    Automaton.States := ['S0', 'S0', 'S1', 'S2', 'S3'];
    Automaton.InitialState := TState.Empty;
    Automaton.FinalStates := [];

    CheckFalse(FValidator.Validate(Automaton));
  finally
    Automaton.Free;
  end;
end;

procedure TAFDValidationsTest.TestAcceptWhenDuplicatedSymbol;
var
  Automaton: TAFD;
begin
  Automaton := TAFD.Create;
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
  Automaton: TAFD;
begin
  Automaton := TAFD.Create;
  try
    Automaton.Symbols := ['a', 'b', 'c'];
    Automaton.States := ['S0', 'S1', 'S2', 'S3'];
    Automaton.InitialState := 'S0';
    Automaton.FinalStates := [];

    CheckFalse(FValidator.Validate(Automaton));
  finally
    Automaton.Free;
  end;
end;

procedure TAFDValidationsTest.TestAcceptWhenFinalStatesNotFound;
var
  Automaton: TAFD;
begin
  Automaton := TAFD.Create;
  try
    Automaton.Symbols := ['a', 'b', 'c'];
    Automaton.States := ['S0', 'S1', 'S2', 'S3'];
    Automaton.InitialState := 'S0';
    Automaton.FinalStates := ['S4'];

    CheckFalse(FValidator.Validate(Automaton));
  finally
    Automaton.Free;
  end;
end;

procedure TAFDValidationsTest.TestAcceptWhenInitialStateNotDefined;
var
  Automaton: TAFD;
begin
  Automaton := TAFD.Create;
  try
    Automaton.Symbols := ['a', 'b', 'c'];
    Automaton.States := ['S0', 'S1', 'S2', 'S3'];
    Automaton.InitialState := TState.Empty;
    Automaton.FinalStates := [];

    CheckFalse(FValidator.Validate(Automaton));
  finally
    Automaton.Free;
  end;
end;

procedure TAFDValidationsTest.TestAcceptWhenInitialStateNotFound;
var
  Automaton: TAFD;
begin
  Automaton := TAFD.Create;
  try
    Automaton.Symbols := ['a', 'b', 'c'];
    Automaton.States := ['S0', 'S1', 'S2', 'S3'];
    Automaton.InitialState := 'S4';
    Automaton.FinalStates := [];

    CheckFalse(FValidator.Validate(Automaton));
  finally
    Automaton.Free;
  end;
end;

procedure TAFDValidationsTest.TestAcceptWhenNoStatesDefined;
var
  Automaton: TAFD;
begin
  Automaton := TAFD.Create;
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
  Automaton: TAFD;
begin
  Automaton := TAFD.Create;
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
  Automaton: TAFD;
begin
  Automaton := TAFD.Create;
  try
    Automaton.Symbols := ['a', 'b'];
    Automaton.States := ['Q0', 'Q1'];
    Automaton.InitialState := 'Q0';
    Automaton.FinalStates := ['Q1'];
    Automaton.Transitions.Add(TTransition.Create(TState.Empty, 'Q1', 'a'));
    Automaton.Transitions.Add(TTransition.Create('Q0', 'Q1', 'b'));
    Automaton.Transitions.Add(TTransition.Create('Q1', 'Q1', 'a'));
    Automaton.Transitions.Add(TTransition.Create('Q1', 'Q1', 'b'));

    CheckFalse(FValidator.Validate(Automaton));
  finally
    Automaton.Free;
  end;
end;

procedure TAFDValidationsTest.TestAcceptWhenTransitionHasSourceNotFound;
var
  Automaton: TAFD;
begin
  Automaton := TAFD.Create;
  try
    Automaton.Symbols := ['a', 'b'];
    Automaton.States := ['Q0', 'Q1'];
    Automaton.InitialState := 'Q0';
    Automaton.FinalStates := ['Q1'];
    Automaton.Transitions.Add(TTransition.Create('Q0', 'Q1', 'a'));
    Automaton.Transitions.Add(TTransition.Create('Q2', 'Q1', 'b'));
    Automaton.Transitions.Add(TTransition.Create('Q1', 'Q1', 'a'));
    Automaton.Transitions.Add(TTransition.Create('Q1', 'Q1', 'b'));

    CheckFalse(FValidator.Validate(Automaton));
  finally
    Automaton.Free;
  end;
end;

procedure TAFDValidationsTest.TestAcceptWhenTransitionHasSymbolNotDefined;
var
  Automaton: TAFD;
begin
  Automaton := TAFD.Create;
  try
    Automaton.Symbols := ['a', 'b'];
    Automaton.States := ['Q0', 'Q1'];
    Automaton.InitialState := 'Q0';
    Automaton.FinalStates := ['Q1'];
    Automaton.Transitions.Add(TTransition.Create('Q0', 'Q1', 'a'));
    Automaton.Transitions.Add(TTransition.Create('Q0', 'Q1', 'b'));
    Automaton.Transitions.Add(TTransition.Create('Q1', 'Q1', TSymbol.Empty));
    Automaton.Transitions.Add(TTransition.Create('Q1', 'Q1', 'b'));

    CheckFalse(FValidator.Validate(Automaton));
  finally
    Automaton.Free;
  end;
end;

procedure TAFDValidationsTest.TestAcceptWhenTransitionHasSymbolNotFound;
var
  Automaton: TAFD;
begin
  Automaton := TAFD.Create;
  try
    Automaton.Symbols := ['a', 'b'];
    Automaton.States := ['Q0', 'Q1'];
    Automaton.InitialState := 'Q0';
    Automaton.FinalStates := ['Q1'];
    Automaton.Transitions.Add(TTransition.Create('Q0', 'Q1', 'a'));
    Automaton.Transitions.Add(TTransition.Create('Q0', 'Q1', 'b'));
    Automaton.Transitions.Add(TTransition.Create('Q1', 'Q1', 'a'));
    Automaton.Transitions.Add(TTransition.Create('Q1', 'Q1', 'c'));

    CheckFalse(FValidator.Validate(Automaton));
  finally
    Automaton.Free;
  end;
end;

procedure TAFDValidationsTest.TestAcceptWhenTransitionHasTargetNotDefined;
var
  Automaton: TAFD;
begin
  Automaton := TAFD.Create;
  try
    Automaton.Symbols := ['a', 'b'];
    Automaton.States := ['Q0', 'Q1'];
    Automaton.InitialState := 'Q0';
    Automaton.FinalStates := ['Q1'];
    Automaton.Transitions.Add(TTransition.Create('Q0', TState.Empty, 'a'));
    Automaton.Transitions.Add(TTransition.Create('Q0', 'Q1', 'b'));
    Automaton.Transitions.Add(TTransition.Create('Q1', 'Q1', 'a'));
    Automaton.Transitions.Add(TTransition.Create('Q1', 'Q1', 'c'));

    CheckFalse(FValidator.Validate(Automaton));
  finally
    Automaton.Free;
  end;
end;

procedure TAFDValidationsTest.TestAcceptWhenTransitionHasTargetNotFound;
var
  Automaton: TAFD;
begin
  Automaton := TAFD.Create;
  try
    Automaton.Symbols := ['a', 'b'];
    Automaton.States := ['Q0', 'Q1'];
    Automaton.InitialState := 'Q0';
    Automaton.FinalStates := ['Q1'];
    Automaton.Transitions.Add(TTransition.Create('Q0', 'Q1', 'a'));
    Automaton.Transitions.Add(TTransition.Create('Q0', 'Q1', 'b'));
    Automaton.Transitions.Add(TTransition.Create('Q1', 'Q4', 'a'));
    Automaton.Transitions.Add(TTransition.Create('Q1', 'Q1', 'c'));

    CheckFalse(FValidator.Validate(Automaton));
  finally
    Automaton.Free;
  end;
end;

procedure TAFDValidationsTest.TestAcceptWhenTransitionsNotDefined;
var
  Automaton: TAFD;
begin
  Automaton := TAFD.Create;
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

