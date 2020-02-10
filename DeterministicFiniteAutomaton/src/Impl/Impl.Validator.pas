unit Impl.Validator;

interface

uses
  Impl.DeterministicFiniteAutomaton, Impl.List, Impl.Transition, Impl.Transitions, Impl.Types,
  System.SysUtils;

type
  TValidator = class sealed
  strict private
    FSymbols: TList<TSymbol>;
    FStates: TList<TState>;
    FInitialState: TState;
    FFinalStates: TList<TState>;
    FTransitions: TTransitions;
    FMessage: TMessage;
  private
    function ValidateInitialState: Boolean;
    function ValidateSymbols: Boolean;
    function ValidateStates: Boolean;
    function ValidateFinalStates: Boolean;
    function ValidateTransitions: Boolean;
    procedure Setup(const Automaton: TDeterministicFiniteAutomaton);
  public
    constructor Create;
    destructor Destroy; override;
  public
    function Validate(const Automaton: TDeterministicFiniteAutomaton): TValidationResult;
  end;

implementation

constructor TValidator.Create;
begin
  FSymbols := TList<TSymbol>.Create;
  FStates := TList<TState>.Create;
  FFinalStates := TList<TState>.Create;
  FMessage := TMessage.Empty;
  FInitialState := TState.Empty;
end;

destructor TValidator.Destroy;
begin
  FSymbols.Free;
  FStates.Free;
  FFinalStates.Free;
  inherited Destroy;
end;

procedure TValidator.Setup(const Automaton: TDeterministicFiniteAutomaton);
begin
  FSymbols.AddRange(Automaton.Symbols);
  FStates.AddRange(Automaton.States);
  FFinalStates.AddRange(Automaton.FinalStates);
  FInitialState := Automaton.InitialState;
  FTransitions := Automaton.Transitions;
end;

function TValidator.Validate(const Automaton: TDeterministicFiniteAutomaton): TValidationResult;
begin
  Setup(Automaton);

  if not ValidateSymbols then
    Exit(TValidationResult.Create(False, FMessage));

  if not ValidateStates then
    Exit(TValidationResult.Create(False, FMessage));

  if not ValidateInitialState then
    Exit(TValidationResult.Create(False, FMessage));

  if not ValidateFinalStates then
    Exit(TValidationResult.Create(False, FMessage));

  if not ValidateTransitions then
    Exit(TValidationResult.Create(False, FMessage));

  Result := TValidationResult.Create(True, TMessage.Empty);
end;

function TValidator.ValidateFinalStates: Boolean;
var
  State: TState;
  Duplicated: TList<TState>;
begin
  Result := False;

  if (not FStates.IsEmpty) and (FFinalStates.IsEmpty) then
  begin
    FMessage := 'The final states is not defined.';
    Exit;
  end;

  for State in FFinalStates.ToArray do
  begin
    if not FStates.Contains(State) then
    begin
      FMessage := Format('The final state %s is not in states list %s.', [State.QuotedString, FStates.ToString]);
      Exit;
    end;
  end;

  Duplicated := FFinalStates.Duplicated;
  try
    if not Duplicated.IsEmpty then
    begin
      FMessage := Format('The final state %s is duplicated.', [Duplicated.ToString]);
      Exit;
    end;
  finally
    Duplicated.Free;
  end;

  Result := True;
end;

function TValidator.ValidateInitialState: Boolean;
begin
  Result := False;

  if (not FStates.IsEmpty) and (FInitialState.IsEmpty) then
  begin
    FMessage := 'The initial state is not defined.';
    Exit;
  end;

  if (not FStates.IsEmpty) and (not FStates.Contains(FInitialState)) then
  begin
    FMessage := Format('The state %s is not in states list %s.', [FInitialState.QuotedString, FStates.ToString]);
    Exit;
  end;

  Result := True;
end;

function TValidator.ValidateStates: Boolean;
var
  Duplicated: TList<TState>;
begin
  Duplicated := FStates.Duplicated;
  try
    Result := True;
    if not Duplicated.IsEmpty then
    begin
      FMessage := Format('The state %s is duplicated.', [Duplicated.ToString]);
      Exit(False);
    end;
  finally
    Duplicated.Free;
  end;
end;

function TValidator.ValidateSymbols: Boolean;
var
  Duplicated: TList<TSymbol>;
begin
  Duplicated := FSymbols.Duplicated;
  try
    Result := True;
    if not Duplicated.IsEmpty then
    begin
      FMessage := Format('The symbol %s is duplicated.', [Duplicated.ToString]);
      Exit(False);
    end;
  finally
    Duplicated.Free;
  end;
end;

function TValidator.ValidateTransitions: Boolean;
var
  Transition: TTransition;
begin
  Result := False;

  if (not FSymbols.IsEmpty) and (not FStates.IsEmpty) and (FTransitions.IsEmpty) then
  begin
    FMessage := 'The transitions has been not defined.';
    Exit;
  end;

  for Transition in FTransitions.ToArray do
  begin
    if not FStates.Contains(Transition.Source) then
    begin
      FMessage := Format('The source state %s is not in states list %s.', [Transition.Source.QuotedString, FStates.ToString]);
      Exit;
    end;

    if not FSymbols.Contains(Transition.Symbol) then
    begin
      FMessage := Format('The symbol %s is not in symbols list %s.', [Transition.Symbol.QuotedString, FSymbols.ToString]);
      Exit;
    end;

    if not FStates.Contains(Transition.Target) then
    begin
      FMessage := Format('The target state %s is not in states list %s.', [Transition.Target.QuotedString, FStates.ToString]);
      Exit;
    end;
  end;

  Result := True;
end;

end.

