unit View.Main;

interface

uses
  FMX.ActnList, FMX.Controls, FMX.Controls.Presentation, FMX.Edit, FMX.Forms, FMX.Grid, FMX.Layouts,
  FMX.ListBox, FMX.ScrollBox, FMX.StdCtrls, FMX.TabControl, FMX.Types, Helper.Edit, Helper.ListBox,
  Helper.ListBoxItem, Helper.StringGrid, Impl.DeterministicFiniteAutomaton, Impl.Dialogs, Impl.Transition,
  Impl.Transitions, Impl.Types, System.Actions, System.Classes, System.StrUtils, System.SysUtils,
  System.Rtti, FMX.Grid.Style;

type
  TMain = class sealed(TForm)
    ActionCheck: TAction;
    ActionClear: TAction;
    ActionList: TActionList;
    ButtonCheck: TButton;
    ButtonClear: TButton;
    EditFinalStates: TEdit;
    EditInitialState: TEdit;
    EditStates: TEdit;
    EditSymbols: TEdit;
    EditWord: TEdit;
    Grid: TStringGrid;
    LabelFinalStates: TLabel;
    LabelInitialState: TLabel;
    LabelLog: TLabel;
    LabelStates: TLabel;
    LabelSymbols: TLabel;
    LabelTransitions: TLabel;
    LabelWord: TLabel;
    ListLog: TListBox;
    PanelButtons: TPanel;
    TabControlView: TTabControl;
    TabItemInput: TTabItem;
    TabItemOutput: TTabItem;
    procedure GridSelectCell(Sender: TObject; const ACol, ARow: Integer; var CanSelect: Boolean);
    procedure ActionCheckExecute(Sender: TObject);
    procedure ActionClearExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EditSymbolsChange(Sender: TObject);
    procedure EditStatesChange(Sender: TObject);
    procedure ListLogChangeCheck(Sender: TObject);
  strict private
    FAutomaton: TDeterministicFiniteAutomaton;
    function GetFinalStates: TArray<TState>;
    function GetInitialState: TState;
    function GetStates: TArray<TState>;
    function GetSymbols: TArray<TSymbol>;
    function GetTransitions: TTransitions;
    function GetWord: TWord;
  private
    procedure DrawMatrix;
    procedure Check;
    procedure Clear;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Symbols: TArray<TSymbol> read GetSymbols;
    property States: TArray<TState> read GetStates;
    property InitialState: TState read GetInitialState;
    property FinalStates: TArray<TState> read GetFinalStates;
    property Transitions: TTransitions read GetTransitions;
    property Word: TWord read GetWord;
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
  FAutomaton.Clear;
  try
    FAutomaton.Symbols      := Symbols;
    FAutomaton.States       := States;
    FAutomaton.InitialState := InitialState;
    FAutomaton.FinalStates  := FinalStates;
    FAutomaton.Transitions  := Transitions;

    ListLog.Add(Word, FAutomaton.Accept(Word));
  except
    on Exception: EArgumentException do
      TDialogs.Warning(Exception.Message);
  end;
end;

procedure TMain.Clear;
begin
  FAutomaton.Clear;
  EditSymbols.Clear;
  EditStates.Clear;
  EditInitialState.Clear;
  EditFinalStates.Clear;
  EditWord.Clear;
  ListLog.Clear;
end;

procedure TMain.DrawMatrix;
var
  Row, Column: Byte;
begin
  Grid.Clear;

  if (Length(States) = 0) or (Length(Symbols) = 0) then
    Exit;

  Grid.DefineSize(Length(States) + 1, Length(Symbols) + 1);

  for Row := 1 to Pred(Grid.RowCount) do
    Grid.Cells[Grid.FirstColumn, Row] := States[Row - 1].Trim;

  for Column := 1 to Pred(Grid.ColumnCount) do
    Grid.Cells[Column, Grid.FirstRow] := Symbols[Column - 1].Trim;
end;

procedure TMain.EditStatesChange(Sender: TObject);
begin
  DrawMatrix;
end;

procedure TMain.EditSymbolsChange(Sender: TObject);
begin
  DrawMatrix;
end;

procedure TMain.FormShow(Sender: TObject);
begin
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

  for Row := 1 to Pred(Grid.RowCount) do
  begin
    for Column := 1 to Pred(Grid.ColumnCount) do
    begin
      if not Grid.Cells[Column, Row].IsEmpty then
      begin
        Transition := TTransition.Create;
        Transition.Source := Grid.Cells[Grid.FirstColumn, Row];
        Transition.Symbol := Grid.Cells[Column, Grid.FirstRow];
        Transition.Target := Grid.Cells[Column, Row];

        FAutomaton.Transitions.Add(Transition);
      end;
    end;
  end;

  Result := FAutomaton.Transitions;
end;

function TMain.GetWord: TWord;
begin
  Result := IfThen(EditWord.Text.Trim.IsEmpty, Empty, EditWord.Text.Replace(' ', ''));
end;

procedure TMain.GridSelectCell(Sender: TObject; const ACol, ARow: Integer; var CanSelect: Boolean);
begin
  CanSelect := (ACol <> Grid.FirstColumn) and (ARow <> Grid.FirstRow);
end;

procedure TMain.ListLogChangeCheck(Sender: TObject);
begin
  (Sender as TListBoxItem).Restore;
end;

end.

