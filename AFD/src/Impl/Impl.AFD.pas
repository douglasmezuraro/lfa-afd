unit Impl.AFD;

interface

uses
  Impl.Types, Impl.Transition, Impl.Transitions, System.SysUtils, System.StrUtils;

type
  TAFD = class sealed
  strict private
    FSymbols: TArray<TSymbol>;
    FStates: TArray<TState>;
    FInitialState: TState;
    FFinalStates: TArray<TState>;
    FTransitions: TTransitions;
  private
    function InternalAccept(const Word: TWord): Boolean;
  public
    constructor Create;
    destructor Destroy; override;
    function Accept(const Word: TWord): Boolean;
    procedure Clear;
  public
    property Symbols: TArray<TSymbol> read FSymbols write FSymbols;
    property States: TArray<TState> read FStates write FStates;
    property InitialState: TState read FInitialState write FInitialState;
    property FinalStates: TArray<TState> read FFinalStates write FFinalStates;
    property Transitions: TTransitions read FTransitions write FTransitions;
  end;

implementation

uses
  Impl.AFD.Validator;

constructor TAFD.Create;
begin
  FTransitions := TTransitions.Create;
end;

destructor TAFD.Destroy;
begin
  FTransitions.Free;
  inherited;
end;

function TAFD.Accept(const Word: TWord): Boolean;
var
  Validator: TValidator;
begin
  Validator := TValidator.Create;
  try
    if not Validator.Validate(Self) then
      raise EArgumentException.Create(Validator.Error);

    Result := InternalAccept(Word);
  finally
    Validator.Free;
  end;
end;

procedure TAFD.Clear;
begin
  FTransitions.Clear;
  SetLength(FSymbols, 0);
  SetLength(FStates, 0);
  SetLength(FFinalStates, 0);
  FInitialState := string.Empty;
end;

function TAFD.InternalAccept(const Word: TWord): Boolean;
var
  State: TState;
  Symbol: TSymbol;
  Transition: TTransition;
begin
  State := FInitialState;

  for Symbol in Word do
  begin
    Transition := FTransitions.Transition(State, Symbol);

    if not Assigned(Transition) then
      Exit(False);

    State := Transition.Target;
  end;

  Result := MatchStr(State, FFinalStates);
end;

end.

