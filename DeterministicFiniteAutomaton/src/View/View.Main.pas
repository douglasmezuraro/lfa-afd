unit View.Main;

interface

uses
  FMX.ActnList, FMX.Controls, FMX.Controls.Presentation, FMX.Edit, FMX.Forms, FMX.Grid,
  FMX.StdCtrls, FMX.TabControl, FMX.Types, Helper.Edit,
  Helper.StringGrid, Impl.Dialogs, System.Classes, System.SysUtils,
  FMX.Menus, System.Types, System.Generics.Collections,

  System.Rtti, FMX.Grid.Style, System.Actions, FMX.ScrollBox, DFA;

type
  TMain = class sealed(TForm)
    ActionCheck: TAction;
    ActionClear: TAction;
    ActionList: TActionList;
    ButtonCheck: TButton;
    ButtonClear: TButton;
    ColumnInput: TStringColumn;
    ColumnResult: TStringColumn;
    EditFinalStates: TEdit;
    EditInitialState: TEdit;
    EditStates: TEdit;
    EditSymbols: TEdit;
    GridInput: TStringGrid;
    GridOutput: TStringGrid;
    LabelFinalStates: TLabel;
    LabelInitialState: TLabel;
    LabelStates: TLabel;
    LabelSymbols: TLabel;
    LabelTransitions: TLabel;
    PanelButtons: TPanel;
    TabControlView: TTabControl;
    TabItemInput: TTabItem;
    TabItemOutput: TTabItem;
    MenuBar: TMenuBar;
    MenuItemFile: TMenuItem;
    MenuItemOpenFile: TMenuItem;
    MenuItemSaveFile: TMenuItem;
    ActionOpenFile: TAction;
    ActionSaveFile: TAction;
    procedure ActionCheckExecute(ASender: TObject);
    procedure ActionClearExecute(ASender: TObject);
    procedure EditStatesChange(ASender: TObject);
    procedure EditSymbolsChange(ASender: TObject);
    procedure FormKeyUp(ASender: TObject; var AKey: Word; var AKeyChar: Char; AShift: TShiftState);
    procedure FormShow(ASender: TObject);
    procedure GridInputSelectCell(ASender: TObject; const AColumn, ARow: Integer; var CanSelect: Boolean);
    procedure TabControlViewChange(ASender: TObject);
    procedure ActionOpenFileExecute(ASender: TObject);
    procedure ActionSaveFileExecute(ASender: TObject);
  strict private
    function GetFinalStates: TArray<TState>;
    procedure SetFinalStates(const AFinalStates: TArray<TState>);
    function GetInitialState: TState;
    procedure SetInitialState(const AInitialState: TState);
    function GetStates: TArray<TState>;
    procedure SetStates(const AStates: TArray<TState>);
    function GetSymbols: TArray<TSymbol>;
    procedure SetSymbols(const ASymbols: TArray<TSymbol>);
    function GetTransitions: TArray<TTransition>;
    procedure SetTransitions(const ATransitions: TArray<TTransition>);
  private
    procedure DrawGrid;
    procedure Check;
    procedure Clear;
    procedure OpenFile;
    procedure SaveFile;
  public
    property Symbols: TArray<TSymbol> read GetSymbols write SetSymbols;
    property States: TArray<TState> read GetStates write SetStates;
    property InitialState: TState read GetInitialState write SetInitialState;
    property FinalStates: TArray<TState> read GetFinalStates write SetFinalStates;
    property Transitions: TArray<TTransition> read GetTransitions write SetTransitions;
  end;

implementation

{$R *.fmx}

procedure TMain.ActionCheckExecute(ASender: TObject);
begin
  Check;
end;

procedure TMain.ActionClearExecute(ASender: TObject);
begin
  Clear;
end;

procedure TMain.ActionOpenFileExecute(ASender: TObject);
begin
  OpenFile;
end;

procedure TMain.ActionSaveFileExecute(ASender: TObject);
begin
  SaveFile;
end;

procedure TMain.Check;
const
  RESULT_MESSAGE: array[Boolean] of string = ('Rejected', 'Accepted');
var
  LDTO: TDTO;
  LAutomaton: TDeterministicFiniteAutomaton;
begin
  LDTO.Symbols := Symbols;
  LDTO.States := States;
  LDTO.InitialState := InitialState;
  LDTO.FinalStates := FinalStates;
  LDTO.Transitions := Transitions;

  try
    LAutomaton := TDeterministicFiniteAutomaton.Create(LDTO);
    try
      GridOutput.ForEach(
        procedure
        begin
          GridOutput.Value[ColumnResult] := RESULT_MESSAGE[LAutomaton.Check(GridOutput.Value[ColumnInput])];
        end);
    finally
      LAutomaton.Free;
    end;
  except
    on E: Exception do
    begin
      TDialogs.Information(E.Message);
    end;
  end;
end;

procedure TMain.Clear;
begin
  EditSymbols.Clear;
  EditStates.Clear;
  EditInitialState.Clear;
  EditFinalStates.Clear;
  GridInput.Clear(True);
  GridOutput.Clear;
end;

procedure TMain.DrawGrid;
var
  LRow, LColumn: Integer;
begin
  GridInput.Clear;

  if (States = nil) or (Symbols = nil) then
  begin
    Exit;
  end;

  GridInput.Draw(Length(States) + 1, Length(Symbols) + 1);

  for LRow := 1 to Pred(GridInput.RowCount) do
  begin
    GridInput.Cells[GridInput.FirstColumn, LRow] := States[LRow - 1].Trim;
  end;

  for LColumn := 1 to Pred(GridInput.ColumnCount) do
  begin
    GridInput.Cells[LColumn, GridInput.FirstRow] := Symbols[LColumn - 1].Trim;
  end;
end;

procedure TMain.EditStatesChange(ASender: TObject);
begin
  DrawGrid;
end;

procedure TMain.EditSymbolsChange(ASender: TObject);
begin
  DrawGrid;
end;

procedure TMain.FormKeyUp(ASender: TObject; var AKey: Word; var AKeyChar: Char; AShift: TShiftState);
begin
  if GridOutput.IsFocused then
  begin
    GridOutput.Notify(AKey);
  end;
end;

procedure TMain.FormShow(ASender: TObject);
begin
  ButtonCheck.Visible := False;
  TabControlView.ActiveTab := TabItemInput;
end;

function TMain.GetInitialState: TState;
begin
  Result := EditInitialState.Text.Trim;
end;

function TMain.GetFinalStates: TArray<TState>;
begin
  Result := EditFinalStates.Text.Replace(' ', '').Split([','], TStringSplitOptions.ExcludeEmpty);
end;

function TMain.GetStates: TArray<TState>;
begin
  Result := EditStates.Text.Replace(' ', '').Split([','], TStringSplitOptions.ExcludeEmpty);
end;

function TMain.GetSymbols: TArray<TSymbol>;
begin
  Result := EditSymbols.Text.Replace(' ', '').Split([','], TStringSplitOptions.ExcludeEmpty);
end;

function TMain.GetTransitions: TArray<TTransition>;
var
  LRow, LColumn: Integer;
  LTransition: TTransition;
  LList: TList<TTransition>;
begin
  LList := TList<TTransition>.Create;
  try
    for LRow := 1 to Pred(GridInput.RowCount) do
    begin
      for LColumn := 1 to Pred(GridInput.ColumnCount) do
      begin
        if not GridInput.Cells[LColumn, LRow].IsEmpty then
        begin
          LTransition := TTransition.Create;
          LTransition.Source := GridInput.Cells[GridInput.FirstColumn, LRow];
          LTransition.Symbol := GridInput.Cells[LColumn, GridInput.FirstRow];
          LTransition.Target := GridInput.Cells[LColumn, LRow];

          LList.Add(LTransition);
        end;
      end;
    end;

    Result := LList.ToArray;
  finally
    LList.Free;
  end;
end;

procedure TMain.GridInputSelectCell(ASender: TObject; const AColumn, ARow: Integer; var CanSelect: Boolean);
begin
  CanSelect := (AColumn <> GridInput.FirstColumn) and (ARow <> GridInput.FirstRow);
end;

procedure TMain.OpenFile;
var
  LFileName: string;
begin
  if TDialogs.OpenFile('json', LFileName) then
  begin
    raise ENotImplemented.Create('OpenFile is currently not implemented.');
  end;
end;

procedure TMain.SaveFile;
var
  LFileName: string;
begin
  if TDialogs.SaveFile('json', LFileName) then
  begin
    raise ENotImplemented.Create('SaveFile is currently not implemented.');
  end;
end;

procedure TMain.SetFinalStates(const AFinalStates: TArray<TState>);
begin
  EditFinalStates.Text := string.Join(', ', AFinalStates);
end;

procedure TMain.SetInitialState(const AInitialState: TState);
begin
  EditInitialState.Text := AInitialState;
end;

procedure TMain.SetStates(const AStates: TArray<TState>);
begin
  EditStates.Text := string.Join(', ', AStates);
end;

procedure TMain.SetSymbols(const ASymbols: TArray<TSymbol>);
begin
  EditSymbols.Text := string.Join(', ', ASymbols);
end;

procedure TMain.SetTransitions(const ATransitions: TArray<TTransition>);
var
  LTransition: TTransition;
  LCoordinate: TPoint;
begin
  for LTransition in ATransitions do
  begin
    LCoordinate := GridInput.Coordinate[LTransition.Source, LTransition.Symbol];
    GridInput.Cells[LCoordinate.X, LCoordinate.Y] := LTransition.Target;
  end;
end;

procedure TMain.TabControlViewChange(ASender: TObject);
begin
  ButtonCheck.Visible := (ASender as TTabControl).ActiveTab <> TabItemInput;
end;

end.

