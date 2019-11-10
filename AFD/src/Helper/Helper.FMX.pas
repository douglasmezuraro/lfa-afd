unit Helper.FMX;

interface

uses
  System.SysUtils, FMX.Grid, FMX.ListBox;

type
  TStringGridHelper = class Helper for TStringGrid
  public const
    FirstRow: Byte = 0;
    FirstColumn: Byte = 0;
  private
    procedure DefineRowCount(const Rows: Byte);
    procedure DefineColumnCount(const Columns: Byte);
  public
    function ToMatrix: TArray<TArray<string>>;
    procedure Clear;
    procedure DefineSize(const Rows, Columns: Byte);
  end;

  TListBoxItemHelper = class Helper for TListBoxItem
  public
    procedure Check(const Checked: Boolean);
    procedure Restore;
  end;

implementation

{ TStringGridHelper }

procedure TStringGridHelper.Clear;
begin
  RowCount := 0;
  ClearColumns;
end;

procedure TStringGridHelper.DefineColumnCount(const Columns: Byte);
begin
  ClearColumns;
  while ColumnCount <> Columns do
    AddObject(TStringColumn.Create(Self));
end;

procedure TStringGridHelper.DefineRowCount(const Rows: Byte);
begin
  RowCount := Rows;
end;

procedure TStringGridHelper.DefineSize(const Rows, Columns: Byte);
begin
  DefineRowCount(Rows);
  DefineColumnCount(Columns);
end;

function TStringGridHelper.ToMatrix: TArray<TArray<string>>;
var
  LRow, LColumn: Integer;
begin
  SetLength(Result, RowCount, ColumnCount);
  for LRow := FirstRow to Pred(RowCount) do
  begin
    for LColumn := FirstColumn to Pred(ColumnCount) do
    begin
      Result[LRow, LColumn] := Cells[LColumn, LRow];
    end;
  end;
end;

{ TListBoxItemHelper }

procedure TListBoxItemHelper.Check(const Checked: Boolean);
begin
  IsChecked := Checked;
  Tag := Value.ToInteger;
end;

procedure TListBoxItemHelper.Restore;
begin
  IsChecked := Tag.ToBoolean;
end;

end.

