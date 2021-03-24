unit DFA.Types;

interface

uses
  System.SysUtils;

type
  EDuplicated = class abstract(EArgumentException);
  EIsNotDefined = class abstract(EArgumentException);
  ENotContains = class abstract(EArgumentException);
  EInitialStateIsNotDefined = class sealed(EIsNotDefined);
  EFinalStatesIsNotDefined = class sealed(EIsNotDefined);
  ETransitionsIsNotDefined = class sealed(EIsNotDefined);
  ETransitionSourceStateIsNotDefined = class sealed(EIsNotDefined);
  ETransitionTargetStateIsNotDefined = class sealed(EIsNotDefined);
  ESymbolIsNotDefined = class sealed(EIsNotDefined);
  EStatesNotContaisTheState = class sealed(ENotContains);
  ESymbolsNotContainsTheSymbol = class sealed(ENotContains);
  EDuplicatedState = class sealed(EDuplicated);
  EDuplicatedSymbol = class sealed(EDuplicated);

  TSymbol = string;
  TState = string;
  TWord = string;

  TTransition = class sealed
  strict private
    FSymbol: TSymbol;
    FSource: TState;
    FTarget: TState;
  public
    constructor Create(const ASource: TState; const ASymbol: TSymbol; const ATarget: TState); overload;
    property Source: TState read FSource write FSource;
    property Symbol: TSymbol read FSymbol write FSymbol;
    property Target: TState read FTarget write FTarget;
  end;

  TDTO = record
  public
    Symbols: TArray<TSymbol>;
    States: TArray<TState>;
    InitialState: TState;
    FinalStates: TArray<TState>;
    Transitions: TArray<TTransition>;
  end;

implementation

constructor TTransition.Create(const ASource: TState; const ASymbol: TSymbol; const ATarget: TState);
begin
  FSource := ASource;
  FSymbol := ASymbol;
  FTarget := ATarget;
end;

end.

