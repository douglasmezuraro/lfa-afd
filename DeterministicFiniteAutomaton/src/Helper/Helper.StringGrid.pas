unit Helper.StringGrid;

interface

uses
  FMX.Grid;

type
  TStringGridHelper = class Helper for TStringGrid
  public const
    FirstRow: Byte = 0;
    FirstColumn: Byte = 0;
  private
    procedure DefineRowCount(const Rows: Byte);
    procedure DefineColumnCount(const Columns: Byte);
  public
    procedure Clear;
    procedure DefineSize(const Rows, Columns: Byte);
  end;

implementation

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

end.

