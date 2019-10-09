unit Impl.AFD.Validations.Test;

interface

uses
  TestFramework, Impl.AFD, Impl.List, Impl.Transitions, System.SysUtils, Impl.Types, TestFramework.Helpers;

type
  TAFDValidationsTest = class(TTestCase)
  strict private
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
  Check(procedure
        var
          Matrix: TMatrix;
        begin
          FAFD.AddSymbols(['a', 'b', 'c'])
              .AddStates(['S0', 'S1', 'S2', 'S3'])
              .AddInitialState('S0')
              .AddFinalStates(['S3', 'S3'])
              .AddTransitions(TTransitions.Create(Matrix));
        end,
        EDuplicated);
end;

procedure TAFDValidationsTest.TestAcceptWithDuplicatedState;
begin
  Check(procedure
        var
         Matrix: TMatrix;
        begin
         FAFD.AddSymbols(['a', 'b', 'c'])
             .AddStates(['S0', 'S0', 'S1', 'S2', 'S3'])
             .AddInitialState(TState.Empty)
             .AddFinalStates([])
             .AddTransitions(TTransitions.Create(Matrix));
        end, EDuplicated);
end;

procedure TAFDValidationsTest.TestAcceptWithDuplicatedSymbol;
begin
  Check(procedure
        var
         Matrix: TMatrix;
        begin
         FAFD.AddSymbols(['a', 'b', 'b', 'c'])
             .AddStates([])
             .AddInitialState(TState.Empty)
             .AddFinalStates([])
             .AddTransitions(TTransitions.Create(Matrix));
        end, EDuplicated);
end;

procedure TAFDValidationsTest.TestAcceptWithFinalStatesNotDefined;
begin
  Check(procedure
        var
         Matrix: TMatrix;
        begin
         FAFD.AddSymbols(['a', 'b', 'c'])
             .AddStates(['S0', 'S1', 'S2', 'S3'])
             .AddInitialState('S0')
             .AddFinalStates([])
             .AddTransitions(TTransitions.Create(Matrix));
        end, ENotDefined);
end;

procedure TAFDValidationsTest.TestAcceptWithFinalStatesNotFound;
begin
  Check(procedure
        var
         Matrix: TMatrix;
        begin
         FAFD.AddSymbols(['a', 'b', 'c'])
             .AddStates(['S0', 'S1', 'S2', 'S3'])
             .AddInitialState('S0')
             .AddFinalStates(['S4'])
             .AddTransitions(TTransitions.Create(Matrix));
        end, ENotFound);
end;

procedure TAFDValidationsTest.TestAcceptWithInitialStateNotDefined;
begin
  Check(procedure
        var
         Matrix: TMatrix;
        begin
         FAFD.AddSymbols(['a', 'b', 'c'])
             .AddStates(['S0', 'S1', 'S2', 'S3'])
             .AddInitialState(TState.Empty)
             .AddFinalStates([])
             .AddTransitions(TTransitions.Create(Matrix));
        end, ENotDefined);
end;

procedure TAFDValidationsTest.TestAcceptWithInitialStateNotFound;
begin
  Check(procedure
        var
         Matrix: TMatrix;
        begin
         FAFD.AddSymbols(['a', 'b', 'c'])
             .AddStates(['S0', 'S1', 'S2', 'S3'])
             .AddInitialState('S4')
             .AddFinalStates([])
             .AddTransitions(TTransitions.Create(Matrix));
        end, ENotFound);
end;

procedure TAFDValidationsTest.TestAcceptWithNoStatesDefined;
begin
  Check(procedure
        var
          Matrix: TMatrix;
        begin
          FAFD.AddSymbols(['a', 'b', 'c'])
              .AddStates([])
              .AddInitialState(TState.Empty)
              .AddFinalStates([])
              .AddTransitions(TTransitions.Create(Matrix));
        end, ENotDefined);
end;

procedure TAFDValidationsTest.TestAcceptWithNoSymbolsDefined;
begin
  Check(procedure
        var
         Matrix: TMatrix;
        begin
         FAFD.AddSymbols([])
             .AddStates([])
             .AddInitialState(TState.Empty)
             .AddFinalStates([])
             .AddTransitions(TTransitions.Create(Matrix));
        end, ENotDefined);
end;

initialization
  RegisterTest(TAFDValidationsTest.Suite);

end.

