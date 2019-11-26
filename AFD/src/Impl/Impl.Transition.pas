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
    constructor Create(const Source, Target: TState; const Symbol: TSymbol); overload;
  public
    property Source: TState read FSource write FSource;
    property Target: TState read FTarget write FTarget;
    property Symbol: TSymbol read FSymbol write FSymbol;
  end;

implementation

constructor TTransition.Create(const Source, Target: TState; const Symbol: TSymbol);
begin
  FSource := Source;
  FTarget := Target;
  FSymbol := Symbol;
end;

end.

