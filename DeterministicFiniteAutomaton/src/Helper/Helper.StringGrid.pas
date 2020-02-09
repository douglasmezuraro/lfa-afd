unit Helper.StringGrid;

interface

uses
  FMX.Grid, System.SysUtils, System.UITypes, System.Types;

type
  TStringGridHelper = class Helper for TStringGrid
  public const
    FirstRow: Byte = 0;
    FirstColumn: Byte = 0;
  private
    function Eof: Boolean;
    function GetValue(const Column: TColumn): string;
    procedure DefineColumns(const Columns: Byte);
    procedure DefineRows(const Rows: Byte);
    procedure Delete;
    procedure Insert;
    procedure SetValue(const Column: TColumn; const Value: string);
    function GetCoordinate(const A, B: string): TPoint;
  public
    function IsEmpty: Boolean;
    procedure Clear(const RemoveColumns: Boolean = False);
    procedure Draw(const Rows, Columns: Byte);
    procedure ForEach(const Method: TProc);
    procedure Notify(const Key: Word);
    property Value[const Column: TColumn]: string read GetValue write SetValue;
    property Coordinate[const A, B: string]: TPoint read GetCoordinate;
  end;

implementation

procedure TStringGridHelper.Clear(const RemoveColumns: Boolean);
begin
  RowCount := 0;
  if RemoveColumns then
    ClearColumns;
end;

procedure TStringGridHelper.DefineColumns(const Columns: Byte);
begin
  ClearColumns;
  while ColumnCount <> Columns do
    AddObject(TStringColumn.Create(Self));
end;

procedure TStringGridHelper.DefineRows(const Rows: Byte);
begin
  RowCount := Rows;
end;

procedure TStringGridHelper.Draw(const Rows, Columns: Byte);
begin
  DefineRows(Rows);
  DefineColumns(Columns);
end;

procedure TStringGridHelper.Delete;
var
  LColumn, LRow: Integer;
begin
  if IsEmpty then
    Exit;

  if Selected <> RowCount then
  begin
    for LRow := Selected to Pred(RowCount) do
    begin
      for LColumn := FirstColumn to Pred(ColumnCount) do
      begin
        Cells[LColumn, LRow] := Cells[LColumn, Succ(LRow)];
      end;
    end;
  end;

  RowCount := Pred(RowCount);
end;

function TStringGridHelper.Eof: Boolean;
begin
  Result := Row = RowCount;
end;

procedure TStringGridHelper.ForEach(const Method: TProc);
begin
  Row := FirstRow;
  while not Eof do
  begin
    Method;
    Row := Succ(Row);
  end;
end;

function TStringGridHelper.GetCoordinate(const A, B: string): TPoint;

  function X: Integer;
  var
    LColumn: Integer;
  begin
    for LColumn := FirstColumn to Pred(ColumnCount) do
    begin
      if Cells[LColumn, FirstRow].Equals(B) then
      begin
        Exit(LColumn);
      end;
    end;

    Result := TPoint.Zero.X;
  end;

  function Y: Integer;
  var
    LRow: Integer;
  begin
    for LRow := FirstRow to Pred(RowCount) do
    begin
      if Cells[FirstColumn, LRow].Equals(A) then
      begin
        Exit(LRow);
      end;
    end;

    Result := TPoint.Zero.Y;
  end;

begin
  Result.Create(X, Y);
end;

function TStringGridHelper.GetValue(const Column: TColumn): string;
begin
  Result := Cells[Column.Index, Row];
end;

procedure TStringGridHelper.Insert;
begin
  RowCount := Succ(RowCount);
  SelectCell(FirstColumn, Succ(Selected));
  EditorMode := True;
end;

function TStringGridHelper.IsEmpty: Boolean;
begin
  Result := RowCount = 0;
end;

procedure TStringGridHelper.Notify(const Key: Word);
begin
  case Key of
    vkInsert: Insert;
    vkDelete: Delete;
  end;
end;

procedure TStringGridHelper.SetValue(const Column: TColumn; const Value: string);
begin
  Cells[Column.Index, Row] := Value;
end;

end.

