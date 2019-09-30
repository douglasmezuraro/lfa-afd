unit Impl.AFD;

interface

uses
  Impl.AFD.Types, Impl.List, System.SysUtils;

type
  TAFD = class sealed
  strict private
    FSymbols: TList;
    FStates: TList;
    FInitialState: TState;
    FFinalStates: TList;
    FTransitions: TTransitions;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    function AddSymbols(const Symbols: TArray<TSymbol>): TAFD;
    function AddStates(const States: TArray<TState>): TAFD;
    function AddInitialState(const State: TState): TAFD;
    function AddFinalStates(const States: TArray<TState>): TAFD;
    function AddTransitions(const Transitions: TTransitions): TAFD;
    function Accept(const Word: string): Boolean;
  end;

implementation

{ TAFD }

constructor TAFD.Create;
begin
  FSymbols     := TList.Create;
  FStates      := TList.Create;
  FFinalStates := TList.Create;
end;

destructor TAFD.Destroy;
begin
  FFinalStates.Free;
  FStates.Free;
  FSymbols.Free;
  inherited;
end;

procedure TAFD.Clear;
begin
  FSymbols.Clear;
  FStates.Clear;
  FFinalStates.Clear;
  FInitialState := string.Empty;
end;

function TAFD.Accept(const Word: string): Boolean;
var
  State: TState;
  Symbol: TSymbol;
begin
  State := FInitialState;

  for Symbol in Word.ToCharArray do
  begin
    if FTransitions.HasTransition(State, Symbol) then
      State := FTransitions.Transition(State, Symbol)
    else
      Exit(False);
  end;

  Result := FFinalStates.Contains(State);
end;

function TAFD.AddSymbols(const Symbols: TArray<TSymbol>): TAFD;
var
  Symbol: TSymbol;
begin
  Clear;

  for Symbol in Symbols do
  begin
    if FSymbols.Contains(Symbol.Trim) then
      raise EDuplicated.CreateFmt('The symbol %s is duplicated!', [Symbol.Trim.QuotedString]);

    FSymbols.Add(Symbol.Trim);
  end;

  if FSymbols.IsEmpty then
    raise ENotDefined.Create('The AFD symbols is not defined!');

  Result := Self;
end;

function TAFD.AddStates(const States: TArray<TState>): TAFD;
var
  State: TState;
begin
  for State in States do
  begin
    if FStates.Contains(State.Trim) then
      raise EDuplicated.CreateFmt('The state %s is duplicated!', [State.Trim.QuotedString]);

    FStates.Add(State.Trim);
  end;

  if FStates.IsEmpty then
    raise ENotDefined.Create('The AFD states is not defined!');

  Result := Self;
end;

function TAFD.AddInitialState(const State: TState): TAFD;
begin
  if State.IsEmpty then
    raise ENotDefined.Create('The AFD initial state is not defined!');

  if not FStates.Contains(State.Trim) then
    raise ENotFound.CreateFmt('The state %s is not in states list %s!', [State.Trim, FStates.ToString]);

  FInitialState := State.Trim;
  Result := Self;
end;

function TAFD.AddFinalStates(const States: TArray<TState>): TAFD;
var
  State: TState;
begin
  for State in States do
  begin
    if not FStates.Contains(State.Trim) then
      raise ENotFound.CreateFmt('The state %s is not in states list %s!', [State.Trim, FStates.ToString]);

    if FFinalStates.Contains(State.Trim) then
      raise EDuplicated.CreateFmt('The state %s is duplicated!', [State.Trim.QuotedString]);

    FFinalStates.Add(State.Trim);
  end;

  if FFinalStates.IsEmpty then
    raise ENotDefined.Create('The AFD final states is not defined!');

  Result := Self;
end;

function TAFD.AddTransitions(const Transitions: TTransitions): TAFD;
begin
  FTransitions := Transitions;
  Result := Self;
end;

end.
