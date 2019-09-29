unit Impl.AFD.Types;

interface

uses
  System.SysUtils;

type
  TSymbol = string;
  TState = string;
  TTransition = string;
  TMatrix = TArray<TArray<TTransition>>;

  ENotDefined = class(Exception);
  ESymbolsNotDefined = class(ENotDefined);
  EStatesNotDefined = class(ENotDefined);
  EInitialStateNotDefined = class(ENotDefined);
  EFinalStatesNotDefined = class(ENotDefined);
  ETransitionsNotDefined = class(ENotDefined);

  EStateNotFound = class(Exception);
  EDuplicated = class(Exception);
  ESymbolDuplicated = class(EDuplicated);
  EStateDuplicated = class(EDuplicated);

  TTransitions = record
  public const
    NotFoundIndex = -1;
  strict private
    FMatrix: TMatrix;
    FRows: Integer;
    FColumns: Integer;
  public
    constructor Create(const Rows, Columns: Byte);
    function HasTransition(const State: TState; const Symbol: TSymbol): Boolean;
    function Transition(const State: TState; const Symbol: TSymbol): TTransition;
    function ToMatrix: TMatrix;
  end;

implementation

{ TTransitions }

constructor TTransitions.Create(const Rows, Columns: Byte);
begin
  FRows := Rows;
  FColumns := Columns;
  SetLength(FMatrix, FRows, FColumns);
end;

function TTransitions.HasTransition(const State: TState; const Symbol: TSymbol): Boolean;
var
  Index, Row, Column: Integer;
begin
  Row := NotFoundIndex; Column := NotFoundIndex;

  for Index := 1 to Pred(FRows) do
  begin
    if FMatrix[Index, 0].Equals(State) then
      Row := Index;
  end;

  for Index := 1 to Pred(FColumns) do
  begin
    if FMatrix[Row, Index].Equals(Symbol) then
      Column := Index;
  end;

  Result := not FMatrix[Row, Column].Trim.IsEmpty;
end;

function TTransitions.ToMatrix: TMatrix;
begin
  Result := FMatrix;
end;

function TTransitions.Transition(const State: TState; const Symbol: TSymbol): TTransition;
begin

end;

end.
