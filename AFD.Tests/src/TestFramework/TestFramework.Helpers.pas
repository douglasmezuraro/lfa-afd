unit TestFramework.Helpers;

interface

uses
  TestFramework, System.SysUtils;

type
  TTestFrameworkHelper = class Helper for TTestCase
  public
    procedure Check(const AMethod: TProc; const AClass: ExceptionClass;
      const AMsg: string = string.Empty);
  end;

implementation

{ TTestFrameworkHelper }

procedure TTestFrameworkHelper.Check(const AMethod: TProc; const AClass: ExceptionClass; const AMsg: string);
begin
  StartExpectingException(AClass);
  AMethod;
  StopExpectingException(AMsg);
end;

end.
