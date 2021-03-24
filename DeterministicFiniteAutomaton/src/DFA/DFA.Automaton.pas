unit DFA.Automaton;

interface

uses
  DFA.Types, DFA.Validator, System.SysUtils;

type
  TDeterministicFiniteAutomaton = class sealed
  strict private
    FSymbols: TArray<TSymbol>;
    FStates: TArray<TState>;
    FInitialState: TState;
    FFinalStates: TArray<TState>;
    FTransitions: TArray<TTransition>;
  private
    function HasTransition(const AState: TState; const ASymbol: TSymbol; out ATransition: TTransition): Boolean;
  public
    constructor Create(const ADTO: TDTO);
    destructor Destroy; override;
    function Check(const AWord: TWord): Boolean;
  end;

implementation

constructor TDeterministicFiniteAutomaton.Create(const ADTO: TDTO);
var
  LValidator: TValidator;
begin
  LValidator := TValidator.Create(ADTO);
  try
    LValidator.Validate;
  finally
    LValidator.Free;
  end;

  FSymbols := ADTO.Symbols;
  FStates := ADTO.States;
  FInitialState := ADTO.InitialState;
  FFinalStates := ADTO.FinalStates;
  FTransitions := ADTO.Transitions;
end;

destructor TDeterministicFiniteAutomaton.Destroy;
var
  LTransition: TTransition;
begin
  for LTransition in FTransitions do
  begin
    LTransition.Free;
  end;

  inherited Destroy;
end;

function TDeterministicFiniteAutomaton.Check(const AWord: TWord): Boolean;
var
  LSymbol: TSymbol;
  LState, LCurrentState: TState;
  LTransition: TTransition;
begin
  LCurrentState := FInitialState;

  for LSymbol in AWord do
  begin
    if not HasTransition(LCurrentState, LSymbol, LTransition) then
    begin
      Exit(False);
    end;

    LCurrentState := LTransition.Target;
  end;

  for LState in FFinalStates do
  begin
    if LState.Equals(LCurrentState) then
    begin
      Exit(True);
    end;
  end;

  Result := False;
end;

function TDeterministicFiniteAutomaton.HasTransition(const AState: TState; const ASymbol: TSymbol; out ATransition: TTransition): Boolean;
var
  LTransition: TTransition;
begin
  for LTransition in FTransitions do
  begin
    if LTransition.Source.Equals(AState) and LTransition.Symbol.Equals(ASymbol) then
    begin
      ATransition := LTransition;
      Exit(True);
    end;
  end;

  Result := False;
end;

end.

