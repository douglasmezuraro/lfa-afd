unit Helper.StringGrid;

interface

uses
  FMX.Grid, System.SysUtils, System.UITypes, System.Types;

type
  TStringGridHelper = class Helper for TStringGrid
  public const
    FirstRow = 0;
    FirstColumn = 0;
  private
    function Eof: Boolean;
    function GetValue(const AColumn: TColumn): string;
    procedure DefineColumns(const AColumns: Integer);
    procedure DefineRows(const ARows: Integer);
    procedure Delete;
    procedure Insert;
    procedure SetValue(const AColumn: TColumn; const Value: string);
    function GetCoordinate(const AX, AY: string): TPoint;
  public
    function IsEmpty: Boolean;
    procedure Clear(const AClearColumns: Boolean = False);
    procedure Draw(const ARows, AColumns: Integer);
    procedure ForEach(const AProc: TProc);
    procedure Notify(const AKey: Word);
    property Value[const AColumn: TColumn]: string read GetValue write SetValue;
    property Coordinate[const AX, AY: string]: TPoint read GetCoordinate;
  end;

implementation

procedure TStringGridHelper.Clear(const AClearColumns: Boolean);
begin
  RowCount := 0;
  if AClearColumns then
  begin
    ClearColumns;
  end;
end;

procedure TStringGridHelper.DefineColumns(const AColumns: Integer);
begin
  ClearColumns;
  while ColumnCount <> AColumns do
  begin
    AddObject(TStringColumn.Create(Self));
  end;
end;

procedure TStringGridHelper.DefineRows(const ARows: Integer);
begin
  RowCount := ARows;
end;

procedure TStringGridHelper.Draw(const ARows, AColumns: Integer);
begin
  DefineRows(ARows);
  DefineColumns(AColumns);
end;

procedure TStringGridHelper.Delete;
var
  LColumn, LRow: Integer;
begin
  if IsEmpty then
  begin
    Exit;
  end;

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

procedure TStringGridHelper.ForEach(const AProc: TProc);
begin
  Row := FirstRow;
  while not Eof do
  begin
    AProc;
    Row := Succ(Row);
  end;
end;

function TStringGridHelper.GetCoordinate(const AX, AY: string): TPoint;

  function X: Integer;
  var
    LColumn: Integer;
  begin
    for LColumn := FirstColumn to Pred(ColumnCount) do
    begin
      if Cells[LColumn, FirstRow].Equals(AY) then
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
      if Cells[FirstColumn, LRow].Equals(AX) then
      begin
        Exit(LRow);
      end;
    end;

    Result := TPoint.Zero.Y;
  end;

begin
  Result.Create(X, Y);
end;

function TStringGridHelper.GetValue(const AColumn: TColumn): string;
begin
  Result := Cells[AColumn.Index, Row];
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

procedure TStringGridHelper.Notify(const AKey: Word);
begin
  case AKey of
    vkInsert:
      begin
        Insert;
      end;
    vkDelete:
      begin
        Delete;
      end;
  end;
end;

procedure TStringGridHelper.SetValue(const AColumn: TColumn; const Value: string);
begin
  Cells[AColumn.Index, Row] := Value;
end;

end.

