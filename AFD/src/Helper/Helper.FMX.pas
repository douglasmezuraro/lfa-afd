unit Helper.FMX;

interface

uses
  System.SysUtils, FMX.Grid;

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
    procedure DefineSize(const Rows, Columns: Byte);
  end;

implementation

{ TStringGridHelper }

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
begin
  raise ENotImplemented.CreateFmt('The method %s is not implemented!', ['ToMatrix'.QuotedString]);
end;

end.
