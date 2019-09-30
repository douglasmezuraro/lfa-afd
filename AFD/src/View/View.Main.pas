unit View.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Controls.Presentation, System.Rtti, FMX.Grid.Style,
  FMX.ScrollBox, FMX.Grid, FMX.TabControl, Helper.FMX, Impl.AFD, Impl.AFD.Types,
  System.Actions, FMX.ActnList, FMX.Memo, Impl.Dialogs, System.StrUtils;

type
  TMain = class(TForm)
    ActionList: TActionList;
    ActionBuildAFD: TAction;
    ActionBuildMatrix: TAction;
    ActionCheck: TAction;
    PanelButtons: TPanel;
    ButtonClear: TButton;
    ActionClear: TAction;
    TabControlView: TTabControl;
    TabItemInput: TTabItem;
    LabelSymbols: TLabel;
    EditSymbols: TEdit;
    LabelStates: TLabel;
    EditStates: TEdit;
    LabelInitialState: TLabel;
    EditInitialState: TEdit;
    LabelFinalStates: TLabel;
    EditFinalStates: TEdit;
    LabelTransitions: TLabel;
    Grid: TStringGrid;
    TabItemOutput: TTabItem;
    ButtonCheck: TButton;
    EditWord: TEdit;
    LabelWord: TLabel;
    LabelWords: TLabel;
    MemoWords: TMemo;
    ButtonBuildMatrix: TButton;
    ButtonBuildAFD: TButton;
    procedure ActionBuildAFDExecute(Sender: TObject);
    procedure ActionBuildMatrixExecute(Sender: TObject);
    procedure GridSelectCell(Sender: TObject; const ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure ActionCheckExecute(Sender: TObject);
    procedure ActionClearExecute(Sender: TObject);
    procedure TabControlViewChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  strict private
    FAFD: TAFD;
  private
    function GetFinalStates: TArray<TState>;
    function GetInitialState: TState;
    function GetStates: TArray<TState>;
    function GetSymbols: TArray<TSymbol>;
    function GetTransitions: TTransitions;
    function GetWord: string;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Symbols: TArray<TSymbol> read GetSymbols;
    property States: TArray<TState> read GetStates;
    property InitialState: TState read GetInitialState;
    property FinalStates: TArray<TState> read GetFinalStates;
    property Transitions: TTransitions read GetTransitions;
    property Word: string read GetWord;
  end;

implementation

{$R *.fmx}

{ TMain }

procedure TMain.ActionBuildMatrixExecute(Sender: TObject);
var
  Row, Column: Byte;
begin
  Grid.DefineSize(Length(States) + 1, Length(Symbols) + 1);

  for Row := 1 to Pred(Grid.RowCount) do
    Grid.Cells[Grid.FirstColumn, Row] := States[Row - 1];

  for Column := 1 to Pred(Grid.ColumnCount) do
    Grid.Cells[Column, Grid.FirstRow] := Symbols[Column - 1]
end;

procedure TMain.ActionCheckExecute(Sender: TObject);
const
  Result: array[Boolean] of string = ('Rejected', 'Accepted');
var
  Message: string;
begin
  Message := Format('[%.3d][Status: %s][Word: %s]', [Succ(MemoWords.Lines.Count), Result[FAFD.Accept(Word)], IfThen(Word.IsEmpty, 'ʎ', Word)]);
  MemoWords.Lines.Add(Message);
end;

procedure TMain.ActionClearExecute(Sender: TObject);
begin
  FAFD.Clear;
  EditSymbols.Text := string.Empty;
  EditStates.Text := string.Empty;
  EditInitialState.Text := string.Empty;
  EditFinalStates.Text := string.Empty;
  EditWord.Text := string.Empty;
  MemoWords.Lines.Clear;
end;

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

procedure TMain.FormShow(Sender: TObject);
begin
  TabControlView.ActiveTab := TabItemInput;
end;

procedure TMain.ActionBuildAFDExecute(Sender: TObject);
begin
  try
    FAFD := FAFD.AddSymbols(Symbols)
                .AddStates(States)
                .AddInitialState(InitialState)
                .AddFinalStates(FinalStates)
                .AddTransitions(Transitions);
  except
    on E: Exception do
    begin
      TDialogs.Warning(E.Message);
    end;
  end;
end;


function TMain.GetFinalStates: TArray<TState>;
begin
  Result := EditFinalStates.Text.Split([',']);
end;

function TMain.GetInitialState: TState;
begin
  Result := EditInitialState.Text.Trim;
end;

function TMain.GetStates: TArray<TState>;
begin
  Result := EditStates.Text.Split([',']);
end;

function TMain.GetSymbols: TArray<TSymbol>;
begin
  Result := EditSymbols.Text.Split([',']);
end;

function TMain.GetTransitions: TTransitions;
begin
  Result := TTransitions.Create(Grid.ToMatrix);
end;

function TMain.GetWord: string;
begin
  Result := EditWord.Text;
end;

procedure TMain.GridSelectCell(Sender: TObject; const ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  CanSelect := (ACol <> Grid.FirstColumn) and (ARow <> Grid.FirstRow);
end;

procedure TMain.TabControlViewChange(Sender: TObject);
begin
  ButtonBuildAFD.Visible := TabControlView.ActiveTab = TabItemInput;
  ButtonBuildMatrix.Visible := TabControlView.ActiveTab = TabItemInput;
end;

end.
