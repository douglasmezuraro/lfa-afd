unit Helper.StringGrid;

interface

uses
  FMX.Grid, System.UITypes, System.SysUtils;

type
  TStringGridHelper = class Helper for TStringGrid
  public const
    FirstRow: Byte = 0;
    FirstColumn: Byte = 0;
  private
    function Eof: Boolean;
    function GetValue(const Column: TColumn): string;
    procedure DefineColumnCount(const Columns: Byte);
    procedure DefineRowCount(const Rows: Byte);
    procedure Delete;
    procedure Insert;
    procedure SetValue(const Column: TColumn; const Value: string);
  public
    function IsEmpty: Boolean;
    procedure Clear(const RemoveColumns: Boolean = False);
    procedure DefineSize(const Rows, Columns: Byte);
    procedure ForEach(const Method: TProc);
    procedure Notify(const Key: Word);
    property Value[Const Column: TColumn]: string read GetValue write SetValue;
  end;

implementation

procedure TStringGridHelper.Clear(const RemoveColumns: Boolean);
begin
  RowCount := 0;
  if RemoveColumns then
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

function TStringGridHelper.GetValue(const Column: TColumn): string;
begin
  if not ContainsObject(Column) then
    Exit(string.Empty);

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
  if ContainsObject(Column) then
    Cells[Column.Index, Row] := Value;
end;

end.

