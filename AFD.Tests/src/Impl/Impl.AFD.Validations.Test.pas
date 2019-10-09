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
    procedure TestAcceptWithDuplicatedSymbolException;
    procedure TestAcceptWithNoStatesDefinedException;
    procedure TestAcceptWithDuplicatedStateException;
    procedure TestAcceptWithInitialStateNotDefinedException;
    procedure TestAcceptWithInitialStateNotFoundException;
    procedure TestAcceptWithFinalStatesNotDefinedException;
    procedure TestAcceptWithDuplicatedFinalStatesException;
    procedure TestAcceptWithFinalStatesNotFoundException;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestAcceptWithNoSymbolsDefined;
    procedure TestAcceptWithDuplicatedSymbol;
    procedure TestAcceptWithNoStatesDefined;
    procedure TestAcceptWithDuplicatedState;
    procedure TestAcceptWithInitialStateNotDefined;
    procedure TestAcceptWithInitialStateNotFound;
    procedure TestAcceptWithFinalStatesNotDefined;
    procedure TestAcceptWithDuplicatedFinalStates;
    procedure TestAcceptWithFinalStatesNotFound;
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

procedure TAFDValidationsTest.TestAcceptWithDuplicatedFinalStates;
begin
  CheckException(TestAcceptWithDuplicatedFinalStatesException, EDuplicated);
end;

procedure TAFDValidationsTest.TestAcceptWithDuplicatedFinalStatesException;
var
  Matrix: TMatrix;
begin
  FAFD.AddSymbols(['a', 'b', 'c'])
      .AddStates(['S0', 'S1', 'S2', 'S3'])
      .AddInitialState('S0')
      .AddFinalStates(['S3', 'S3'])
      .AddTransitions(TTransitions.Create(Matrix));
end;

procedure TAFDValidationsTest.TestAcceptWithDuplicatedState;
begin
  CheckException(TestAcceptWithDuplicatedStateException, EDuplicated);
end;

procedure TAFDValidationsTest.TestAcceptWithDuplicatedStateException;
var
  Matrix: TMatrix;
begin
  FAFD.AddSymbols(['a', 'b', 'c'])
      .AddStates(['S0', 'S0', 'S1', 'S2', 'S3'])
      .AddInitialState(TState.Empty)
      .AddFinalStates([])
      .AddTransitions(TTransitions.Create(Matrix));
end;

procedure TAFDValidationsTest.TestAcceptWithDuplicatedSymbol;
begin
  CheckException(TestAcceptWithDuplicatedSymbolException, EDuplicated);
end;

procedure TAFDValidationsTest.TestAcceptWithDuplicatedSymbolException;
var
  Matrix: TMatrix;
begin
  FAFD.AddSymbols(['a', 'b', 'b', 'c'])
      .AddStates([])
      .AddInitialState(TState.Empty)
      .AddFinalStates([])
      .AddTransitions(TTransitions.Create(Matrix));
end;

procedure TAFDValidationsTest.TestAcceptWithFinalStatesNotDefined;
begin
  CheckException(TestAcceptWithFinalStatesNotDefinedException, ENotDefined);
end;

procedure TAFDValidationsTest.TestAcceptWithFinalStatesNotDefinedException;
var
  Matrix: TMatrix;
begin
  FAFD.AddSymbols(['a', 'b', 'c'])
      .AddStates(['S0', 'S1', 'S2', 'S3'])
      .AddInitialState('S0')
      .AddFinalStates([])
      .AddTransitions(TTransitions.Create(Matrix));
end;

procedure TAFDValidationsTest.TestAcceptWithFinalStatesNotFound;
begin
  CheckException(TestAcceptWithFinalStatesNotFoundException, ENotFound);
end;

procedure TAFDValidationsTest.TestAcceptWithFinalStatesNotFoundException;
var
  Matrix: TMatrix;
begin
  FAFD.AddSymbols(['a', 'b', 'c'])
      .AddStates(['S0', 'S1', 'S2', 'S3'])
      .AddInitialState('S0')
      .AddFinalStates(['S4'])
      .AddTransitions(TTransitions.Create(Matrix));
end;

procedure TAFDValidationsTest.TestAcceptWithInitialStateNotDefined;
begin
  CheckException(TestAcceptWithInitialStateNotDefinedException, ENotDefined);
end;

procedure TAFDValidationsTest.TestAcceptWithInitialStateNotDefinedException;
var
  Matrix: TMatrix;
begin
  FAFD.AddSymbols(['a', 'b', 'c'])
      .AddStates(['S0', 'S1', 'S2', 'S3'])
      .AddInitialState(TState.Empty)
      .AddFinalStates([])
      .AddTransitions(TTransitions.Create(Matrix));
end;

procedure TAFDValidationsTest.TestAcceptWithInitialStateNotFound;
begin
  CheckException(TestAcceptWithInitialStateNotFoundException, ENotFound);
end;

procedure TAFDValidationsTest.TestAcceptWithInitialStateNotFoundException;
var
  Matrix: TMatrix;
begin
  FAFD.AddSymbols(['a', 'b', 'c'])
      .AddStates(['S0', 'S1', 'S2', 'S3'])
      .AddInitialState('S4')
      .AddFinalStates([])
      .AddTransitions(TTransitions.Create(Matrix));
end;

procedure TAFDValidationsTest.TestAcceptWithNoStatesDefined;
begin
  CheckException(TestAcceptWithNoStatesDefinedException, ENotDefined);
end;

procedure TAFDValidationsTest.TestAcceptWithNoStatesDefinedException;
var
  Matrix: TMatrix;
begin
  FAFD.AddSymbols(['a', 'b', 'c'])
      .AddStates([])
      .AddInitialState(TState.Empty)
      .AddFinalStates([])
      .AddTransitions(TTransitions.Create(Matrix));
end;

procedure TAFDValidationsTest.TestAcceptWithNoSymbolsDefined;
begin
  CheckException(TestAcceptWithNoSymbolsDefinedException, ENotDefined);
end;

procedure TAFDValidationsTest.TestAcceptWithNoSymbolsDefinedException;
var
  Matrix: TMatrix;
begin
  FAFD.AddSymbols([])
      .AddStates([])
      .AddInitialState(TState.Empty)
      .AddFinalStates([])
      .AddTransitions(TTransitions.Create(Matrix));
end;

initialization
  RegisterTest(TAFDValidationsTest.Suite);

end.

