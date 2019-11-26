unit Impl.AFD.Validator;

interface

uses
  Impl.AFD, Impl.List, Impl.Types, Impl.Transition, Impl.Transitions, System.SysUtils;

type
  TValidator = class sealed
  strict private
    FSymbols: TList;
    FStates: TList;
    FInitialState: TState;
    FFinalStates: TList;
    FTransitions: TTransitions;
    FError: string;
  private
    function ValidateInitialState: Boolean;
    function ValidateSymbols: Boolean;
    function ValidateStates: Boolean;
    function ValidateFinalStates: Boolean;
    function ValidateTransitions: Boolean;
    procedure Setup(const Automaton: TAFD);
  public
    constructor Create;
    destructor Destroy; override;
    function Validate(const Automaton: TAFD): Boolean;
    property Error: string read FError;
  end;

implementation

constructor TValidator.Create;
begin
  FSymbols := TList.Create;
  FStates := TList.Create;
  FFinalStates := TList.Create;
  FError := string.Empty;
  FInitialState := TState.Empty;
end;

destructor TValidator.Destroy;
begin
  FSymbols.Free;
  FStates.Free;
  FFinalStates.Free;
  inherited Destroy;
end;

procedure TValidator.Setup(const Automaton: TAFD);
begin
  FSymbols.Add(Automaton.Symbols);
  FStates.Add(Automaton.States);
  FFinalStates.Add(Automaton.FinalStates);
  FInitialState := Automaton.InitialState;
  FTransitions := Automaton.Transitions;
end;

function TValidator.Validate(const Automaton: TAFD): Boolean;
begin
  Setup(Automaton);

  if not ValidateSymbols then
    Exit(False);

  if not ValidateStates then
    Exit(False);

  if not ValidateInitialState then
    Exit(False);

  if not ValidateFinalStates then
    Exit(False);

  Result := ValidateTransitions;
end;

function TValidator.ValidateFinalStates: Boolean;
var
  State: TState;
begin
  Result := False;

  if FStates.IsEmpty then
  begin
    FError := 'The final states is not defined.';
    Exit;
  end;

  if FStates.HasDuplicated(State) then
  begin
    FError := Format('The final state %s is duplicated.', [State.QuotedString]);
    Exit;
  end;

  Result := True;
end;

function TValidator.ValidateInitialState: Boolean;
begin
  Result := False;

  if FInitialState.IsEmpty then
  begin
    FError := 'The initial state is not defined.';
    Exit;
  end;

  if not FStates.Contains(FInitialState) then
  begin
    FError := Format('The state %s is not in states list %s.', [FInitialState.QuotedString, FStates.ToString]);
    Exit;
  end;

  Result := True;
end;

function TValidator.ValidateStates: Boolean;
var
  State: TState;
begin
  Result := False;

  if FStates.IsEmpty then
  begin
    FError := 'The states is not defined.';
    Exit;
  end;

  if FStates.HasDuplicated(State) then
  begin
    FError := Format('The state %s is duplicated.', [State.QuotedString]);
    Exit;
  end;

  Result := True;
end;

function TValidator.ValidateSymbols: Boolean;
var
  Symbol: TSymbol;
begin
  Result := False;

  if FSymbols.IsEmpty then
  begin
    FError := 'The symbols is not defined.';
    Exit;
  end;

  if FSymbols.HasDuplicated(Symbol) then
  begin
    FError := Format('The symbol %s is duplicated.', [Symbol.QuotedString]);
    Exit;
  end;

  Result := True;
end;

function TValidator.ValidateTransitions: Boolean;
var
  Transition: TTransition;
begin
  Result := False;

  if FTransitions.IsEmpty then
  begin
    FError := 'The transitions has been not defined.';
    Exit;
  end;

  for Transition in FTransitions.ToArray do
  begin
    if not FStates.Contains(Transition.Source) then
    begin
      FError := Format('The source state %s is not in states list %s.', [Transition.Source.QuotedString, FStates.ToString]);
      Exit;
    end;

    if not FSymbols.Contains(Transition.Symbol) then
    begin
      FError := Format('The symbol %s is not in symbols list %s.', [Transition.Symbol.QuotedString, FSymbols.ToString]);
      Exit;
    end;

    if not FStates.Contains(Transition.Target) then
    begin
      FError := Format('The target state %s is not in states list %s.', [Transition.Target.QuotedString, FStates.ToString]);
      Exit;
    end;
  end;

  Result := True;
end;

end.

