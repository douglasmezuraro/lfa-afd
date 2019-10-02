unit Impl.Transitions;

interface

uses
  Impl.Types, System.SysUtils;

type
  TTransitions = record
  strict private
    FMatrix: TMatrix;
    FRows: Byte;
    FColumns: Byte;
  public
    constructor Create(const Matrix: TMatrix); overload;
    function IsEmpty: Boolean;
    function HasTransition(const State: TState; const Symbol: TSymbol): Boolean;
    function Transition(const State: TState; const Symbol: TSymbol): TTransition;
    function ToMatrix: TMatrix;
    property Rows: Byte read FRows;
    property Columns: Byte read FColumns;
  end;

implementation

{ TTransitions }

constructor TTransitions.Create(const Matrix: TMatrix);
begin
  FMatrix := Matrix;
  FRows := Length(FMatrix);
  FColumns := Length(FMatrix[Low(FMatrix)]);
end;

function TTransitions.HasTransition(const State: TState; const Symbol: TSymbol): Boolean;
begin
  Result := not Transition(State, Symbol).Trim.IsEmpty;
end;

function TTransitions.IsEmpty: Boolean;
begin
  Result := (FRows < 1) or (FColumns < 1);
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

  for Index := 1 to Pred(FRows) do
  begin
    if FMatrix[Index, 0].Equals(State) then
    begin
      Row := Index;
      Break;
    end;
  end;

  for Index := 1 to Pred(FColumns) do
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
