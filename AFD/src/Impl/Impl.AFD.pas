unit Impl.AFD;

interface

uses
  Impl.AFD.Types, System.SysUtils;

type
  TAFD = class sealed
  private
    FSymbols: TArray<TSymbol>;
    FStates: TArray<TState>;
    FInitialState: TState;
    FFinalStates: TArray<TState>;
    FTransitions: TMatrix;
  public
    function AddSymbols(const Symbols: TArray<TSymbol>): TAFD;
    function AddStates(const States: TArray<TState>): TAFD;
    function AddInitialState(const State: TState): TAFD;
    function AddFinalStates(const States: TArray<TState>): TAFD;
    function AddTransitions(const Transitions: TMatrix): TAFD;
  end;

implementation

{ TAFD }

function TAFD.AddSymbols(const Symbols: TArray<TSymbol>): TAFD;
begin
  if Length(Symbols) = 0 then
    raise ESymbolsNotDefined.Create('The AFD symbols is not defined!');
  
  FSymbols := Symbols;
  Result := Self;
end;

function TAFD.AddStates(const States: TArray<TState>): TAFD;
begin
  if Length(States) = 0 then
    raise EStatesNotDefined.Create('The AFD states is not defined!');

  FStates := States;
  Result := Self;
end;

function TAFD.AddInitialState(const State: TState): TAFD;
begin
  if State.Trim.IsEmpty then
    raise EInitialStateNotDefined.Create('The AFD initial state is not defined!');

  FInitialState := State;
  Result := Self;
end;

function TAFD.AddFinalStates(const States: TArray<TState>): TAFD;
begin
  if Length(States) = 0 then
    raise EFinalStatesNotDefined.Create('The AFD final states is not defined!');

  FFinalStates := States;
  Result := Self;
end;

function TAFD.AddTransitions(const Transitions: TMatrix): TAFD;
begin
  FTransitions := Transitions;
  Result := Self;
end;

end.
