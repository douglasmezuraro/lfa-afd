unit Test.Validator;

interface

uses
  DFA, System.SysUtils, TestFramework;

type
  TAFDValidationsTest = class sealed(TTestCase)
  strict private
    FValidator: TValidator;
    LDTO: TDeterministicFiniteAutomaton;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestValidateWhenAutomatonHasDuplicatedSymbol;
    procedure TestValidateWhenAutomatonHasDuplicatedState;
    procedure TestValidateWhenAutomatonHasNotStatesAndInitialStateIsNotDefined;
    procedure TestValidateWhenAutomatonHasStatesAndIntitialStatesIsNotDefined;
    procedure TestValidateWhenAutomatonInitialStateIsNotFound;
    procedure TestValidateWhenAutomatonHasNotStatesAndFinalStatesIsNotDefined;
    procedure TestValidateWhenAutomatonHasStatesFinalStatesIsNotDefined;
    procedure TestValidateWhenAutomatonHasDuplicatedFinalStates;
    procedure TestValidateWhenAutomatonHasFinalStatesNotFound;
    procedure TestValidateWhenAutomatonHasNotStatesAndTransitionsIsNotDefined;
    procedure TestValidateWhenAutomatonHasStatesAndTransitionsIsNotDefined;
    procedure TestValidateWhenAutomatonHasTransitionHasSourceNotDefined;
    procedure TestValidateWhenAutomatonHasTransitionHasSourceNotFound;
    procedure TestValidateWhenAutomatonHasTransitionHasSymbolNotDefined;
    procedure TestValidateWhenAutomatonHasTransitionHasSymbolNotFound;
    procedure TestValidateWhenAutomatonHasTransitionHasTargetNotDefined;
    procedure TestValidateWhenAutomatonHasTransitionHasTargetNotFound;
    procedure TestValidateWhenAutomatonIsValid;
  end;

implementation

procedure TAFDValidationsTest.SetUp;
begin
  inherited SetUp;
  FValidator := TValidator.Create;
  LDTO := TDeterministicFiniteAutomaton.Create;
end;

procedure TAFDValidationsTest.TearDown;
begin
  LDTO.Free;
  FValidator.Free;
  inherited TearDown;
end;

procedure TAFDValidationsTest.TestValidateWhenAutomatonIsValid;
begin
end;

procedure TAFDValidationsTest.TestValidateWhenAutomatonHasDuplicatedFinalStates;
begin
end;

procedure TAFDValidationsTest.TestValidateWhenAutomatonHasDuplicatedState;
begin
end;

procedure TAFDValidationsTest.TestValidateWhenAutomatonHasDuplicatedSymbol;
begin
end;

procedure TAFDValidationsTest.TestValidateWhenAutomatonHasStatesFinalStatesIsNotDefined;
begin
end;

procedure TAFDValidationsTest.TestValidateWhenAutomatonHasFinalStatesNotFound;
begin
end;

procedure TAFDValidationsTest.TestValidateWhenAutomatonHasNotStatesAndFinalStatesIsNotDefined;
begin
end;

procedure TAFDValidationsTest.TestValidateWhenAutomatonHasNotStatesAndInitialStateIsNotDefined;
begin
end;

procedure TAFDValidationsTest.TestValidateWhenAutomatonHasNotStatesAndTransitionsIsNotDefined;
begin
end;

procedure TAFDValidationsTest.TestValidateWhenAutomatonHasStatesAndIntitialStatesIsNotDefined;
begin
end;

procedure TAFDValidationsTest.TestValidateWhenAutomatonInitialStateIsNotFound;
begin
end;

procedure TAFDValidationsTest.TestValidateWhenAutomatonHasTransitionHasSourceNotDefined;
begin
end;

procedure TAFDValidationsTest.TestValidateWhenAutomatonHasTransitionHasSourceNotFound;
begin
end;

procedure TAFDValidationsTest.TestValidateWhenAutomatonHasTransitionHasSymbolNotDefined;
begin
end;

procedure TAFDValidationsTest.TestValidateWhenAutomatonHasTransitionHasSymbolNotFound;
begin
end;

procedure TAFDValidationsTest.TestValidateWhenAutomatonHasTransitionHasTargetNotDefined;
begin
end;

procedure TAFDValidationsTest.TestValidateWhenAutomatonHasTransitionHasTargetNotFound;
begin
end;

procedure TAFDValidationsTest.TestValidateWhenAutomatonHasStatesAndTransitionsIsNotDefined;
begin
end;

initialization
  RegisterTest(TAFDValidationsTest.Suite);

end.

