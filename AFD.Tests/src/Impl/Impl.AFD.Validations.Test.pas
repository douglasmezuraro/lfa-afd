unit Impl.AFD.Validations.Test;

interface

uses
  TestFramework, Impl.AFD, Impl.List, Impl.Transitions, System.SysUtils, Impl.Types;

type
  TAFDValidationsTest = class(TTestCase)
  strict private
    FAFD: TAFD;
  private
    procedure TestAcceptWithNoSymbolsDefinedException;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestAcceptWithNoSymbolsDefined;
  end;

implementation

{ TAFDValidationsTest }

procedure TAFDValidationsTest.SetUp;
begin
  inherited SetUp;
  FAFD := TAFD.Create;
end;

procedure TAFDValidationsTest.TearDown;
begin
  FAFD.Free;
  inherited TearDown;
end;

procedure TAFDValidationsTest.TestAcceptWithNoSymbolsDefined;
begin
  CheckException(TestAcceptWithNoSymbolsDefinedException, ENotDefined);
end;

procedure TAFDValidationsTest.TestAcceptWithNoSymbolsDefinedException;
var
  Matrix: TMatrix;
begin
  FAFD.Clear;

  FAFD.AddSymbols([])
      .AddStates([])
      .AddInitialState(TState.Empty)
      .AddFinalStates([])
      .AddTransitions(TTransitions.Create(Matrix));
end;

initialization
  RegisterTest(TAFDValidationsTest.Suite);

end.

