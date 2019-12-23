unit Impl.DeterministicFiniteAutomaton;

interface

uses
  Impl.Transition, Impl.Transitions, Impl.Types, System.SysUtils;

type
  TDeterministicFiniteAutomaton = class sealed
  strict private
    FSymbols: TArray<TSymbol>;
    FStates: TArray<TState>;
    FInitialState: TState;
    FFinalStates: TArray<TState>;
    FTransitions: TTransitions;
  private
    function IsFinalState(const State: TState): Boolean;
  public
    constructor Create;
    destructor Destroy; override;
    function Accept(const Word: TWord): Boolean;
    procedure Clear;
  public
    property Symbols: TArray<TSymbol> read FSymbols write FSymbols;
    property States: TArray<TState> read FStates write FStates;
    property InitialState: TState read FInitialState write FInitialState;
    property FinalStates: TArray<TState> read FFinalStates write FFinalStates;
    property Transitions: TTransitions read FTransitions write FTransitions;
  end;

implementation

constructor TDeterministicFiniteAutomaton.Create;
begin
  FTransitions := TTransitions.Create;
end;

destructor TDeterministicFiniteAutomaton.Destroy;
begin
  FTransitions.Free;
  inherited;
end;

function TDeterministicFiniteAutomaton.IsFinalState(const State: TState): Boolean;
var
  LState: TState;
begin
  for LState in FFinalStates do
  begin
    if LState.Equals(State) then
      Exit(True);
  end;

  Result := False;
end;

function TDeterministicFiniteAutomaton.Accept(const Word: TWord): Boolean;
var
  State: TState;
  Symbol: TSymbol;
  Transition: TTransition;
begin
  State := FInitialState;

  for Symbol in Word do
  begin
    Transition := FTransitions.Transition(State, Symbol);

    if not Assigned(Transition) then
      Exit(False);

    State := Transition.Target;
  end;

  Result := IsFinalState(State);
end;

procedure TDeterministicFiniteAutomaton.Clear;
begin
  FTransitions.Clear;
  FSymbols := nil;
  FStates := nil;
  FFinalStates := nil;
  FInitialState := TState.Empty;
end;

end.

