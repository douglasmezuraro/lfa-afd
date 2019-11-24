unit Impl.Transition;

interface

uses
  Impl.Types;

type
  TTransition = class sealed
  strict private
    FSymbol: TSymbol;
    FSource: TState;
    FTarget: TState;
  public
    property Source: TState read FSource write FSource;
    property Symbol: TSymbol read FSymbol write FSymbol;
    property Target: TState read FTarget write FTarget;
  end;

implementation

end.
