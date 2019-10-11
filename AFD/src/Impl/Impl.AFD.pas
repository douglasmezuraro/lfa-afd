unit Impl.AFD;

interface

uses
  Impl.Types, Impl.List, Impl.Transitions, System.SysUtils;

type
  TAFD = class sealed
  public const
    EmptySymbol: TSymbol = 'ʎ';
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
    function IsDefined: Boolean;
    function AddSymbols(const Symbols: TArray<TSymbol>): TAFD;
    function AddStates(const States: TArray<TState>): TAFD;
    function AddInitialState(const State: TState): TAFD;
    function AddFinalStates(const States: TArray<TState>): TAFD;
    function AddTransitions(const Transitions: TMatrix): TAFD;
    function Accept(const Word: TWord): Boolean;
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

function TAFD.IsDefined: Boolean;
begin
  Result := False;

  if FSymbols.IsEmpty then
    Exit;

  if FStates.IsEmpty then
    Exit;

  if FInitialState.Trim.IsEmpty then
    Exit;

  if FFinalStates.IsEmpty then
    Exit;

  Result := not FTransitions.IsEmpty;
end;

procedure TAFD.Clear;
begin
  FSymbols.Clear;
  FStates.Clear;
  FFinalStates.Clear;
  FInitialState := string.Empty;
end;

function TAFD.Accept(const Word: TWord): Boolean;
var
  State: TState;
  Symbol: TSymbol;
begin
  if not IsDefined then
    raise ENotDefined.Create('Some properties of AFD is not defined!');

  State := FInitialState;

  for Symbol in Word do
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
    raise ENotFound.CreateFmt('The state %s is not in states list %s!', [State.Trim.QuotedString, FStates.ToString]);

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
      raise ENotFound.CreateFmt('The state %s is not in states list %s!', [State.Trim.QuotedString, FStates.ToString]);

    if FFinalStates.Contains(State.Trim) then
      raise EDuplicated.CreateFmt('The state %s is duplicated!', [State.Trim.QuotedString]);

    FFinalStates.Add(State.Trim);
  end;

  if FFinalStates.IsEmpty then
    raise ENotDefined.Create('The AFD final states is not defined!');

  Result := Self;
end;

function TAFD.AddTransitions(const Transitions: TMatrix): TAFD;
var
  Row, Column: Integer;
  State: TState;
begin
  FTransitions := TTransitions.Create(Transitions);

  for Row := 1 to Pred(FTransitions.Rows) do
  begin
    for Column := 1 to Pred(FTransitions.Columns) do
    begin
      State := FTransitions.ToMatrix[Row, Column];

      if State.Trim.IsEmpty then
        continue;

      if not FStates.Contains(State) then
        raise ENotDefined.CreateFmt('The state %s is not defined in states %s.', [State.QuotedString, FStates.ToString]);
    end;
  end;

  Result := Self;
end;

end.

