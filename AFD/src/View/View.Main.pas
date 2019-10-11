unit View.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, FMX.Types,
  FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls, FMX.Edit, FMX.TabControl,
  FMX.Controls.Presentation, System.Rtti, FMX.Grid.Style, FMX.ScrollBox, FMX.Grid, Helper.FMX,
  System.Actions, FMX.ActnList, FMX.Memo, System.StrUtils, Impl.Dialogs, Impl.AFD, Impl.Types,
  Impl.Transitions, FMX.Layouts, FMX.ListBox, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView, System.ImageList, FMX.ImgList;

type
  TMain = class sealed(TForm)
    ActionBuildAFD: TAction;
    ActionCheck: TAction;
    ActionClear: TAction;
    ActionList: TActionList;
    ButtonBuildAFD: TButton;
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
    LabelStates: TLabel;
    LabelSymbols: TLabel;
    LabelTransitions: TLabel;
    LabelWord: TLabel;
    LabelWords: TLabel;
    ListWords: TListBox;
    PanelButtons: TPanel;
    TabControlView: TTabControl;
    TabItemInput: TTabItem;
    TabItemOutput: TTabItem;
    procedure ActionBuildAFDExecute(Sender: TObject);
    procedure GridSelectCell(Sender: TObject; const ACol, ARow: Integer; var CanSelect: Boolean);
    procedure ActionCheckExecute(Sender: TObject);
    procedure ActionClearExecute(Sender: TObject);
    procedure TabControlViewChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EditSymbolsChange(Sender: TObject);
    procedure EditStatesChange(Sender: TObject);
    procedure ListWordsChangeCheck(Sender: TObject);
  strict private
    FAFD: TAFD;
  private
    function GetFinalStates: TArray<TState>;
    function GetInitialState: TState;
    function GetStates: TArray<TState>;
    function GetSymbols: TArray<TSymbol>;
    function GetTransitions: TMatrix;
    function GetWord: TWord;
    procedure DrawMatrix;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Symbols: TArray<TSymbol> read GetSymbols;
    property States: TArray<TState> read GetStates;
    property InitialState: TState read GetInitialState;
    property FinalStates: TArray<TState> read GetFinalStates;
    property Transitions: TMatrix read GetTransitions;
    property Word: TWord read GetWord;
  end;

implementation

{$R *.fmx}

{ TMain }

constructor TMain.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAFD := TAFD.Create;
end;

destructor TMain.Destroy;
begin
  FAFD.Free;
  inherited Destroy;
end;

procedure TMain.ActionCheckExecute(Sender: TObject);
var
  Item: TListBoxItem;
begin
  Item := TListBoxItem.Create(ListWords);
  try
    Item.IsChecked := FAFD.Accept(Word);
    Item.IsCheckedBackup := Item.IsChecked;
    Item.Text := IfThen(Word.IsEmpty, TAFD.EmptySymbol, Word);

    ListWords.AddObject(Item);
  except
    on E: Exception do
    begin
      TDialogs.Warning(E.Message);
    end;
  end;
end;

procedure TMain.ActionClearExecute(Sender: TObject);
begin
  FAFD.Clear;
  EditSymbols.Text := string.Empty;
  EditStates.Text := string.Empty;
  EditInitialState.Text := string.Empty;
  EditFinalStates.Text := string.Empty;
  EditWord.Text := string.Empty;
  ListWords.Items.Clear;
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

procedure TMain.ActionBuildAFDExecute(Sender: TObject);
begin
  EditWord.Text := TWord.Empty;
  ListWords.Items.Clear;
  try
    FAFD := FAFD.AddSymbols(Symbols)
                .AddStates(States)
                .AddInitialState(InitialState)
                .AddFinalStates(FinalStates)
                .AddTransitions(Transitions);

    TabControlView.Next;
  except
    on E: Exception do
    begin
      TDialogs.Warning(E.Message);
    end;
  end;
end;

function TMain.GetInitialState: TState;
begin
  Result := EditInitialState.Text.Trim;
end;

function TMain.GetFinalStates: TArray<TState>;
begin
  Result := EditFinalStates.Text.Split([','], TStringSplitOptions.ExcludeEmpty);
end;

function TMain.GetStates: TArray<TState>;
begin
  Result := EditStates.Text.Split([','], TStringSplitOptions.ExcludeEmpty);
end;

function TMain.GetSymbols: TArray<TSymbol>;
begin
  Result := EditSymbols.Text.Split([','], TStringSplitOptions.ExcludeEmpty);
end;

function TMain.GetTransitions: TMatrix;
begin
  Result := Grid.ToMatrix;
end;

function TMain.GetWord: TWord;
begin
  Result := EditWord.Text;
end;

procedure TMain.GridSelectCell(Sender: TObject; const ACol, ARow: Integer; var CanSelect: Boolean);
begin
  CanSelect := (ACol <> Grid.FirstColumn) and (ARow <> Grid.FirstRow);
end;

procedure TMain.ListWordsChangeCheck(Sender: TObject);
begin
  (Sender as TListBoxItem).IsChecked := (Sender as TListBoxItem).IsCheckedBackup;
end;

procedure TMain.TabControlViewChange(Sender: TObject);
begin
  ButtonBuildAFD.Visible := TabControlView.ActiveTab = TabItemInput;
end;

end.
