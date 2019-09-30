unit Impl.AFD.Types;

interface

uses
  System.SysUtils;

type
  TSymbol = string;
  TState = string;
  TTransition = string;
  TMatrix = TArray<TArray<string>>;

  ENotDefined = class(Exception);
  EDuplicated = class(Exception);
  ENotFound = class(Exception);

  TTransitions = record
  strict private
    FMatrix: TMatrix;
  public
    constructor Create(const Matrix: TMatrix); overload;
    function HasTransition(const State: TState; const Symbol: TSymbol): Boolean;
    function Transition(const State: TState; const Symbol: TSymbol): TTransition;
    function ToMatrix: TMatrix;
  end;

implementation

{ TTransitions }

constructor TTransitions.Create(const Matrix: TMatrix);
begin
  FMatrix := Matrix;
end;

function TTransitions.HasTransition(const State: TState; const Symbol: TSymbol): Boolean;
begin
  Result := not Transition(State, Symbol).Trim.IsEmpty;
end;

function TTransitions.ToMatrix: TMatrix;
begin
  Result := FMatrix;
end;

function TTransitions.Transition(const State: TState; const Symbol: TSymbol): TTransition;
var
  Index, Row, Column: Integer;
begin
  Row := Integer.MinValue;
  Column := Integer.MinValue;

  for Index := 1 to Pred(Length(FMatrix)) do
  begin
    if FMatrix[Index, 0].Equals(State) then
    begin
      Row := Index;
      Break;
    end;
  end;

  for Index := 1 to Pred(Length(FMatrix[0])) do
  begin
    if FMatrix[0, Index].Equals(Symbol) then
    begin
      Column := Index;
      Break;
    end;
  end;

  if (Row = Integer.MinValue) or (Column = Integer.MinValue) then
    Exit(TTransition.Empty);

  Result := FMatrix[Row, Column];
end;

end.
