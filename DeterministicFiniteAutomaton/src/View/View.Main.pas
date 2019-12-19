unit View.Main;

interface

uses
  FMX.ActnList, FMX.Controls, FMX.Controls.Presentation, FMX.Edit, FMX.Forms, FMX.Grid, FMX.Grid.Style,
  FMX.Layouts, FMX.ListBox, FMX.ScrollBox, FMX.StdCtrls, FMX.TabControl, FMX.Types, Helper.Edit,
  Helper.StringGrid, Impl.DeterministicFiniteAutomaton, Impl.Dialogs, Impl.Transition, Impl.Transitions,
  Impl.Types, Impl.Validator, System.Actions, System.Classes, System.Rtti, System.SysUtils;

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
    procedure ActionCheckExecute(Sender: TObject);
    procedure ActionClearExecute(Sender: TObject);
    procedure EditStatesChange(Sender: TObject);
    procedure EditSymbolsChange(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure GridInputSelectCell(Sender: TObject; const ACol, ARow: Integer; var CanSelect: Boolean);
    procedure TabControlViewChange(Sender: TObject);
  strict private
    FAutomaton: TDeterministicFiniteAutomaton;
    function GetFinalStates: TArray<TState>;
    function GetInitialState: TState;
    function GetStates: TArray<TState>;
    function GetSymbols: TArray<TSymbol>;
    function GetTransitions: TTransitions;
  private
    function Validate: TValidationResult;
    procedure DrawGrid;
    procedure Check;
    procedure Clear;
    procedure Setup;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Symbols: TArray<TSymbol> read GetSymbols;
    property States: TArray<TState> read GetStates;
    property InitialState: TState read GetInitialState;
    property FinalStates: TArray<TState> read GetFinalStates;
    property Transitions: TTransitions read GetTransitions;
  end;

implementation

{$R *.fmx}

constructor TMain.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAutomaton := TDeterministicFiniteAutomaton.Create;
end;

destructor TMain.Destroy;
begin
  FAutomaton.Free;
  inherited Destroy;
end;

procedure TMain.ActionCheckExecute(Sender: TObject);
begin
  Check;
end;

procedure TMain.ActionClearExecute(Sender: TObject);
begin
  Clear;
end;

procedure TMain.Check;
begin
  Setup;

  if not Validate.Key then
  begin
    TDialogs.Warning(Validate.Value);
    Exit;
  end;

  GridOutput.ForEach(
    procedure
    begin
      GridOutput.Value[ColumnResult] := Result[FAutomaton.Accept(GridOutput.Value[ColumnInput])];
    end);
end;

procedure TMain.Clear;
begin
  FAutomaton.Clear;
  EditSymbols.Clear;
  EditStates.Clear;
  EditInitialState.Clear;
  EditFinalStates.Clear;
  GridInput.Clear(True);
  GridOutput.Clear;
end;

procedure TMain.DrawGrid;
var
  Row, Column: Byte;
begin
  GridInput.Clear;

  if (States = nil) or (Symbols = nil) then
    Exit;

  GridInput.DefineSize(Length(States) + 1, Length(Symbols) + 1);

  for Row := 1 to Pred(GridInput.RowCount) do
    GridInput.Cells[GridInput.FirstColumn, Row] := States[Row - 1].Trim;

  for Column := 1 to Pred(GridInput.ColumnCount) do
    GridInput.Cells[Column, GridInput.FirstRow] := Symbols[Column - 1].Trim;
end;

procedure TMain.EditStatesChange(Sender: TObject);
begin
  DrawGrid;
end;

procedure TMain.EditSymbolsChange(Sender: TObject);
begin
  DrawGrid;
end;

procedure TMain.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if GridOutput.IsFocused then
    GridOutput.Notify(Key);
end;

procedure TMain.FormShow(Sender: TObject);
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

function TMain.GetTransitions: TTransitions;
var
  Column, Row: Integer;
  Transition: TTransition;
begin
  FAutomaton.Transitions.Clear;

  for Row := 1 to Pred(GridInput.RowCount) do
  begin
    for Column := 1 to Pred(GridInput.ColumnCount) do
    begin
      if not GridInput.Cells[Column, Row].IsEmpty then
      begin
        Transition := TTransition.Create;
        Transition.Source := GridInput.Cells[GridInput.FirstColumn, Row];
        Transition.Symbol := GridInput.Cells[Column, GridInput.FirstRow];
        Transition.Target := GridInput.Cells[Column, Row];

        FAutomaton.Transitions.Add(Transition);
      end;
    end;
  end;

  Result := FAutomaton.Transitions;
end;

procedure TMain.GridInputSelectCell(Sender: TObject; const ACol, ARow: Integer; var CanSelect: Boolean);
begin
  CanSelect := (ACol <> GridInput.FirstColumn) and (ARow <> GridInput.FirstRow);
end;

procedure TMain.Setup;
begin
  FAutomaton.Clear;
  FAutomaton.Symbols      := Symbols;
  FAutomaton.States       := States;
  FAutomaton.InitialState := InitialState;
  FAutomaton.FinalStates  := FinalStates;
  FAutomaton.Transitions  := Transitions;
end;

procedure TMain.TabControlViewChange(Sender: TObject);
begin
  ButtonCheck.Visible := (Sender as TTabControl).ActiveTab <> TabItemInput;
end;

function TMain.Validate: TValidationResult;
var
  Validator: TValidator;
begin
  Validator := TValidator.Create;
  try
    Result := Validator.Validate(FAutomaton);
  finally
    Validator.Free;
  end;
end;

end.

