unit Impl.AFD.Types;

interface

uses
  System.SysUtils;

type
  TSymbol = string;
  TState = string;
  TTransition = string;
  TMatrix = TArray<TArray<TTransition>>;

  ENotDefined = class(Exception);
  ESymbolsNotDefined = class(ENotDefined);
  EStatesNotDefined = class(ENotDefined);
  EInitialStateNotDefined = class(ENotDefined);
  EFinalStatesNotDefined = class(ENotDefined);
  ETransitionsNotDefined = class(ENotDefined);

implementation

end.
