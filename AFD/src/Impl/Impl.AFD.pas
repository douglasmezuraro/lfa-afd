unit Impl.AFD;

interface

uses
  Impl.AFD.Types, System.SysUtils, System.Generics.Collections;

type
  TAFD = class sealed
  private
    FSymbols: TList<TSymbol>;
    FStates: TList<TState>;
    FInitialState: TState;
    FFinalStates: TList<TState>;
    FTransitions: TMatrix;
  private
    function ListToString(const List: TList<string>): string;
  public
    constructor Create;
    destructor Destroy; override;
    function Clear: TAFD;
    function AddSymbols(const Symbols: TArray<TSymbol>): TAFD;
    function AddStates(const States: TArray<TState>): TAFD;
    function AddInitialState(const State: TState): TAFD;
    function AddFinalStates(const States: TArray<TState>): TAFD;
    function AddTransitions(const Transitions: TMatrix): TAFD;
  end;

implementation

{ TAFD }

function TAFD.Clear: TAFD;
begin
  FSymbols.Clear;
  FStates.Clear;
  FFinalStates.Clear;
  FInitialState := string.Empty;
  SetLength(FTransitions, 0, 0);

  Result := Self;
end;

constructor TAFD.Create;
begin
  FSymbols     := TList<TSymbol>.Create;
  FStates      := TList<TState>.Create;
  FFinalStates := TList<TState>.Create;
end;

destructor TAFD.Destroy;
begin
  FFinalStates.Free;
  FStates.Free;
  FSymbols.Free;
  inherited;
end;

function TAFD.ListToString(const List: TList<string>): string;
var
  Item: string;
begin
  if (not Assigned(List)) or (List.Count = 0) then
    Exit('[]');

  for Item in List do
  begin
    if Result.Trim.IsEmpty then
      Result := '[' + Item
    else
      Result := Result + ', ' + Item;
  end;

  Result := Result + ']';
end;

function TAFD.AddSymbols(const Symbols: TArray<TSymbol>): TAFD;
var
  Symbol: TSymbol;
begin
  for Symbol in Symbols do
  begin
    if FSymbols.Contains(Symbol) then
      raise ESymbolDuplicated.CreateFmt('The symbol %s is duplicated!', [Symbol.QuotedString]);

    FSymbols.Add(Symbol);
  end;

  if FSymbols.Count = 0 then
    raise ESymbolsNotDefined.Create('The AFD symbols is not defined!');

  Result := Self;
end;

function TAFD.AddStates(const States: TArray<TState>): TAFD;
var
  State: TState;
begin
  for State in States do
  begin
    if FStates.Contains(State) then
      raise EStateDuplicated.CreateFmt('The state %s is duplicated!', [State.QuotedString]);

    FStates.Add(State);
  end;

  if FStates.Count = 0 then
    raise EStatesNotDefined.Create('The AFD states is not defined!');

  Result := Self;
end;

function TAFD.AddInitialState(const State: TState): TAFD;
begin
  if State.IsEmpty then
    raise EInitialStateNotDefined.Create('The AFD initial state is not defined!');

  if not FStates.Contains(State) then
    raise EStateNotFound.CreateFmt('The state %s is not in states list %s!', [State, ListToString(FStates)]);

  FInitialState := State;
  Result := Self;
end;

function TAFD.AddFinalStates(const States: TArray<TState>): TAFD;
var
  State: TState;
begin
  for State in States do
  begin
    if not FStates.Contains(State) then
      raise EStateNotFound.CreateFmt('The state %s is not in states list %s!', [State, ListToString(FStates)]);

    if FFinalStates.Contains(State) then
      raise EStateDuplicated.CreateFmt('The state %s is duplicated!', [State.QuotedString]);

    FFinalStates.Add(State);
  end;

  if FFinalStates.Count = 0 then
    raise EStatesNotDefined.Create('The AFD states is not defined!');

  FFinalStates.AddRange(States);
  Result := Self;
end;

function TAFD.AddTransitions(const Transitions: TMatrix): TAFD;
begin
  FTransitions := Transitions;
  Result := Self;
end;

end.
