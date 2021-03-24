unit DFA.Types;

interface

uses
  System.SysUtils;

type
  EDuplicated = class abstract(EArgumentException);
  ENotDefined = class abstract(EArgumentException);
  ENotContains = class abstract(EArgumentException);
  EInitialStateNotDefined = class sealed(ENotDefined);
  EFinalStatesNotDefined = class sealed(ENotDefined);
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

