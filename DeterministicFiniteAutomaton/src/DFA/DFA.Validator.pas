unit DFA.Validator;

interface

uses
  DFA.Types, System.SysUtils, System.Generics.Collections;

type
  TValidator = class sealed
  strict private
    FSymbols: TList<TSymbol>;
    FStates: TList<TState>;
    FInitialState: TState;
    FFinalStates: TList<TState>;
    FTransitions: TList<TTransition>;
  private
    function GetDuplicated(const AValues: TArray<string>): TArray<string>;
    function PrettyPrintList(const AValues: TList<string>): string;
  private
    procedure ValidateInitialState;
    procedure ValidateStates;
    procedure ValidateSymbols;
    procedure ValidateFinalStates;
    procedure ValidateTransitions;
  public
    constructor Create(const ADTO: TDTO);
    destructor Destroy; override;
    procedure Validate;
  end;

implementation

constructor TValidator.Create(const ADTO: TDTO);
begin
  FSymbols := TList<TSymbol>.Create;
  FStates := TList<TState>.Create;
  FInitialState := ADTO.InitialState;
  FFinalStates := TList<TState>.Create;
  FTransitions := TList<TTransition>.Create;
  FSymbols.AddRange(ADTO.Symbols);
  FStates.AddRange(ADTO.States);
  FFinalStates.AddRange(ADTO.FinalStates);
  FTransitions.AddRange(ADTO.Transitions);
end;

destructor TValidator.Destroy;
begin
  FTransitions.Free;
  FFinalStates.Free;
  FStates.Free;
  FSymbols.Free;
  inherited;
end;

function TValidator.GetDuplicated(const AValues: TArray<string>): TArray<string>;
var
  LValue: string;
  LAux, LDuplicated: TList<string>;
begin
  LAux := TList<string>.Create;
  LDuplicated := TList<string>.Create;
  try
    for LValue in AValues do
    begin
      if LAux.Contains(LValue) then
      begin
        LDuplicated.Add(LValue);
      end;

      LAux.Add(LValue);
    end;

    Result := LDuplicated.ToArray;
  finally
    LDuplicated.Free;
    LAux.Free;
  end;
end;

function TValidator.PrettyPrintList(const AValues: TList<string>): string;
var
  LValue: string;
  LBuilder: TStringBuilder;
begin
  LBuilder := TStringBuilder.Create('[');
  try
    for LValue in AValues do
    begin
      LBuilder.Append(LValue);
      if LValue <> AValues.Last then
      begin
        LBuilder.Append(', ');
      end;
    end;

    Result := LBuilder.Append(']').ToString;
  finally
    LBuilder.Free;
  end;
end;

procedure TValidator.Validate;
begin
  ValidateInitialState;
  ValidateStates;
  ValidateSymbols;
  ValidateFinalStates;
  ValidateTransitions;
end;

procedure TValidator.ValidateInitialState;
begin
  if (FStates.Count > 0) and (FInitialState.IsEmpty) then
  begin
    raise EInitialStateIsNotDefined.Create('The initial state is not defined.');
  end;

  if FInitialState.IsEmpty then
  begin
    Exit;
  end;

  if not FStates.Contains(FInitialState) then
  begin
    raise EStatesNotContaisTheState.CreateFmt('The state "%s" is not in states list "%s".', [FInitialState, PrettyPrintList(FStates)]);
  end;
end;

procedure TValidator.ValidateStates;
var
  LState: TState;
  LDuplicated: TArray<TState>;
begin
  LDuplicated := GetDuplicated(FStates.ToArray);
  for LState in LDuplicated do
  begin
    raise EDuplicatedState.CreateFmt('The state "%s" is duplicated.', [LState]);
  end;
end;

procedure TValidator.ValidateSymbols;
var
  LSymbol: TSymbol;
  LDuplicated: TArray<TSymbol>;
begin
  LDuplicated := GetDuplicated(FSymbols.ToArray);
  for LSymbol in LDuplicated do
  begin
    raise EDuplicatedSymbol.CreateFmt('The symbol "%s" is duplicated.', [LSymbol]);
  end;
end;

procedure TValidator.ValidateFinalStates;
var
  LState: TState;
  LDuplicated: TArray<TState>;
begin
  if (FFinalStates.Count = 0) and (FStates.Count > 1) then
  begin
    raise EFinalStatesIsNotDefined.Create('The final states is not defined.');
  end;

  for LState in FFinalStates do
  begin
    if not FStates.Contains(LState) then
    begin
      raise EStatesNotContaisTheState.CreateFmt('The final state "%s" is not in states list "%s".', [LState, PrettyPrintList(FStates)]);
    end;
  end;

  LDuplicated := GetDuplicated(FFinalStates.ToArray);
  for LState in LDuplicated do
  begin
    raise EDuplicatedState.CreateFmt('The state "%s" is duplicated.', [LState]);
  end;
end;

procedure TValidator.ValidateTransitions;
var
  LTransition: TTransition;
begin
  if (FSymbols.Count > 0) and (FStates.Count > 0) and (FTransitions.Count = 0) then
  begin
    raise ETransitionsIsNotDefined.Create('The transitions has been not defined.');
  end;

  for LTransition in FTransitions.ToArray do
  begin
    if LTransition.Source.IsEmpty then
    begin
      raise ETransitionSourceStateIsNotDefined.Create('The transition source state is not defined.');
    end;

    if not FStates.Contains(LTransition.Source) then
    begin
      raise EStatesNotContaisTheState.CreateFmt('The source state "%s" is not in states list "%s".', [LTransition.Source, PrettyPrintList(FStates)]);
    end;

    if LTransition.Symbol.IsEmpty then
    begin
      raise ESymbolIsNotDefined.Create('The transition symbol is not defined.');
    end;

    if not FSymbols.Contains(LTransition.Symbol) then
    begin
      raise ESymbolsNotContainsTheSymbol.CreateFmt('The symbol "%s" is not in symbols list "%s".', [LTransition.Symbol, PrettyPrintList(FSymbols)]);
    end;

    if LTransition.Target.IsEmpty then
    begin
      raise ETransitionTargetStateIsNotDefined.Create('The transition target state is not defined');
    end;

    if not FStates.Contains(LTransition.Target) then
    begin
      raise EStatesNotContaisTheState.CreateFmt('The target state "%s" is not in states list "%s".', [LTransition.Target, PrettyPrintList(FStates)]);
    end;
  end;
end;

end.

