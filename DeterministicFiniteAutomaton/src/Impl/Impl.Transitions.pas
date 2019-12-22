unit Impl.Transitions;

interface

uses
  Impl.Transition, Impl.Types, System.SysUtils;

type
  TTransitions = class sealed
  strict private
    FTransitions: TArray<TTransition>;
  public
    destructor Destroy; override;
    function Count: Integer;
    function IsEmpty: Boolean;
    function ToArray: TArray<TTransition>;
    function Transition(const State: TState; const Symbol: TSymbol): TTransition;
    function Add(const Transition: TTransition): TTransitions; overload;
    procedure Add(const Transitions: TArray<TTransition>); overload;
    procedure Clear;
  end;

implementation

destructor TTransitions.Destroy;
begin
  Clear;
  inherited Destroy;
end;

procedure TTransitions.Add(const Transitions: TArray<TTransition>);
var
  Transition: TTransition;
begin
  for Transition in Transitions do
    Add(Transition);
end;

function TTransitions.Add(const Transition: TTransition): TTransitions;
begin
  SetLength(FTransitions, Length(FTransitions) + 1);
  FTransitions[High(FTransitions)] := Transition;

  Result := Self;
end;

procedure TTransitions.Clear;
var
  Transition: TTransition;
begin
  for Transition in FTransitions do
    Transition.Free;

  FTransitions := nil;
end;

function TTransitions.Count: Integer;
begin
  Result := Length(FTransitions);
end;

function TTransitions.ToArray: TArray<TTransition>;
begin
  Result := FTransitions;
end;

function TTransitions.Transition(const State: TState; const Symbol: TSymbol): TTransition;
var
  Transition: TTransition;
begin
  Result := nil;
  for Transition in FTransitions do
  begin
    if not Transition.Source.Equals(State) then
      Continue;

    if not Transition.Symbol.Equals(Symbol) then
      Continue;

    Exit(Transition);
  end;
end;

function TTransitions.IsEmpty: Boolean;
begin
  Result := FTransitions = nil;
end;

end.

