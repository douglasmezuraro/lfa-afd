unit Helper.StringGrid;

interface

uses
  FMX.Grid, System.Classes, System.UITypes, System.SysUtils;

type
  TStringGridHelper = class Helper for TStringGrid
  public const
    FirstRow: Byte = 0;
    FirstColumn: Byte = 0;
  private
    function Eof: Boolean;
    procedure DefineRowCount(const Rows: Byte);
    procedure DefineColumnCount(const Columns: Byte);
    function GetValue(const Column: TColumn): string;
    procedure SetValue(const Column: TColumn; const Value: string);
    procedure Delete;
    procedure Insert;
  public
    function IsEmpty: Boolean;
    procedure Clear;
    procedure DefineSize(const Rows, Columns: Byte);
    procedure ForEach(const Method: TProc);
    procedure Notify(const Key: Word; const Shift: TShiftState);
    property Value[Const Column: TColumn]: string read GetValue write SetValue;
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

procedure TStringGridHelper.Notify(const Key: Word; const Shift: TShiftState);
begin
  if not (ssCtrl in Shift) then
    Exit;

  case Key of
    vkInsert, vkDown: Insert;
    vkDelete: Delete;
  end;
end;

procedure TStringGridHelper.SetValue(const Column: TColumn; const Value: string);
begin
  Cells[Column.Index, Row] := Value;
end;

end.

