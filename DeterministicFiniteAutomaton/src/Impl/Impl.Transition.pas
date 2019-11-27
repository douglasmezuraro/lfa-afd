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
    constructor Create(const Source: TState; const Symbol: TSymbol; const Target: TState); overload;
  public
    property Source: TState read FSource write FSource;
    property Symbol: TSymbol read FSymbol write FSymbol;
    property Target: TState read FTarget write FTarget;
  end;

implementation

constructor TTransition.Create(const Source: TState; const Symbol: TSymbol; const Target: TState);
begin
  FSource := Source;
  FSymbol := Symbol;
  FTarget := Target;
end;

end.

