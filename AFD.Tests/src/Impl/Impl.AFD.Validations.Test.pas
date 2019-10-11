unit Impl.AFD.Validations.Test;

interface

uses
  TestFramework, Impl.AFD, Impl.List, Impl.Transitions, System.SysUtils, Impl.Types, TestFramework.Helpers;

type
  TAFDValidationsTest = class(TTestCase)
  private
    FAFD: TAFD;
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
  CheckEquals(procedure
              begin
                FAFD.AddSymbols(['a', 'b', 'c'])
                    .AddStates(['S0', 'S1', 'S2', 'S3'])
                    .AddInitialState('S0')
                    .AddFinalStates(['S3', 'S3'])
                    .AddTransitions([]);
              end,
              EDuplicated);
end;

procedure TAFDValidationsTest.TestAcceptWithDuplicatedState;
begin
  CheckEquals(procedure
              begin
               FAFD.AddSymbols(['a', 'b', 'c'])
                   .AddStates(['S0', 'S0', 'S1', 'S2', 'S3'])
                   .AddInitialState(TState.Empty)
                   .AddFinalStates([])
                   .AddTransitions([]);
              end, EDuplicated);
end;

procedure TAFDValidationsTest.TestAcceptWithDuplicatedSymbol;
begin
  CheckEquals(procedure
              begin
               FAFD.AddSymbols(['a', 'b', 'b', 'c'])
                   .AddStates([])
                   .AddInitialState(TState.Empty)
                   .AddFinalStates([])
                   .AddTransitions([]);
              end, EDuplicated);
end;

procedure TAFDValidationsTest.TestAcceptWithFinalStatesNotDefined;
begin
  CheckEquals(procedure
              begin
               FAFD.AddSymbols(['a', 'b', 'c'])
                   .AddStates(['S0', 'S1', 'S2', 'S3'])
                   .AddInitialState('S0')
                   .AddFinalStates([])
                   .AddTransitions([]);
              end, ENotDefined);
end;

procedure TAFDValidationsTest.TestAcceptWithFinalStatesNotFound;
begin
  CheckEquals(procedure
              begin
               FAFD.AddSymbols(['a', 'b', 'c'])
                   .AddStates(['S0', 'S1', 'S2', 'S3'])
                   .AddInitialState('S0')
                   .AddFinalStates(['S4'])
                   .AddTransitions([]);
              end, ENotFound);
end;

procedure TAFDValidationsTest.TestAcceptWithInitialStateNotDefined;
begin
  CheckEquals(procedure
              begin
               FAFD.AddSymbols(['a', 'b', 'c'])
                   .AddStates(['S0', 'S1', 'S2', 'S3'])
                   .AddInitialState(TState.Empty)
                   .AddFinalStates([])
                   .AddTransitions([]);
              end, ENotDefined);
end;

procedure TAFDValidationsTest.TestAcceptWithInitialStateNotFound;
begin
  CheckEquals(procedure
              begin
               FAFD.AddSymbols(['a', 'b', 'c'])
                   .AddStates(['S0', 'S1', 'S2', 'S3'])
                   .AddInitialState('S4')
                   .AddFinalStates([])
                   .AddTransitions([]);
              end, ENotFound);
end;

procedure TAFDValidationsTest.TestAcceptWithNoStatesDefined;
begin
  CheckEquals(procedure
              begin
                FAFD.AddSymbols(['a', 'b', 'c'])
                    .AddStates([])
                    .AddInitialState(TState.Empty)
                    .AddFinalStates([])
                    .AddTransitions([]);
              end, ENotDefined);
end;

procedure TAFDValidationsTest.TestAcceptWithNoSymbolsDefined;
begin
  CheckEquals(procedure
              begin
               FAFD.AddSymbols([])
                   .AddStates([])
                   .AddInitialState(TState.Empty)
                   .AddFinalStates([])
                   .AddTransitions([]);
              end, ENotDefined);
end;

initialization
  RegisterTest(TAFDValidationsTest.Suite);

end.

