unit Fixture.Validator;

interface

uses
  DUnitX.TestFramework;

type
  [TestFixture]
  TValidatorFixture = class sealed
  end;

implementation

initialization
  TDUnitX.RegisterTestFixture(TValidatorFixture);

end.

