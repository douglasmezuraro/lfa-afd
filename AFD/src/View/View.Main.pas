unit View.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Controls.Presentation, System.Rtti, FMX.Grid.Style,
  FMX.ScrollBox, FMX.Grid, FMX.TabControl, Helper.FMX, Impl.AFD, Impl.AFD.Types,
  System.Actions, FMX.ActnList;

type
  TMain = class(TForm)
    TabControlView: TTabControl;
    TabItemInput: TTabItem;
    EditFinalStates: TEdit;
    EditInitialState: TEdit;
    EditStates: TEdit;
    EditSymbols: TEdit;
    Grid: TStringGrid;
    ButtonBuild: TButton;
    ActionList: TActionList;
    ActionBuild: TAction;
    ButtonBuildMatrix: TButton;
    ActionBuildMatrix: TAction;
    procedure ActionBuildExecute(Sender: TObject);
    procedure ActionBuildMatrixExecute(Sender: TObject);
    procedure GridSelectCell(Sender: TObject; const ACol,
      ARow: Integer; var CanSelect: Boolean);
  strict private
    FAFD: TAFD;
  private
    function GetFinalStates: TArray<TState>;
    function GetInitialState: TState;
    function GetStates: TArray<TState>;
    function GetSymbols: TArray<TSymbol>;
    function GetTransitions: TMatrix;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Symbols: TArray<TSymbol> read GetSymbols;
    property States: TArray<TState> read GetStates;
    property InitialState: TState read GetInitialState;
    property FinalStates: TArray<TState> read GetFinalStates;
    property Transitions: TMatrix read GetTransitions;
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

procedure TMain.ActionBuildExecute(Sender: TObject);
begin
  FAFD := FAFD.AddSymbols(Symbols)
              .AddStates(States)
              .AddInitialState(InitialState)
              .AddFinalStates(FinalStates)
              .AddTransitions(Transitions);
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

function TMain.GetTransitions: TMatrix;
begin
  Result := Grid.ToMatrix;
end;

procedure TMain.GridSelectCell(Sender: TObject; const ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  CanSelect := (ACol <> Grid.FirstColumn) and (ARow <> Grid.FirstRow);
end;

end.
