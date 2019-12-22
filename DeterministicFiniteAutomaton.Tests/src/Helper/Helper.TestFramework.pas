unit Helper.TestFramework;

interface

uses
  TestFramework, System.SysUtils;

type
  TTestFrameworkHelper = class Helper for TAbstractTest
  private
    function EqualsArray(const A, B: TArray<string>): Boolean;
  public
    procedure CheckEquals(const Expected, Actual: TArray<string>); overload;
    procedure CheckNotEquals(const Expected, Actual: TArray<string>); overload;
    procedure CheckEquals(const Expected, Actual: TObject); overload;
    procedure CheckNotEquals(const Expected, Actual: TObject); overload;
  end;

implementation

procedure TTestFrameworkHelper.CheckEquals(const Expected, Actual: TArray<string>);
begin
  CheckTrue(EqualsArray(Expected, Actual));
end;

procedure TTestFrameworkHelper.CheckEquals(const Expected, Actual: TObject);
begin
  CheckTrue(Expected.Equals(Actual));
end;

procedure TTestFrameworkHelper.CheckNotEquals(const Expected, Actual: TObject);
begin
  CheckFalse(Expected.Equals(Actual));
end;

procedure TTestFrameworkHelper.CheckNotEquals(const Expected, Actual: TArray<string>);
begin
  CheckFalse(EqualsArray(Expected, Actual));
end;

function TTestFrameworkHelper.EqualsArray(const A, B: TArray<string>): Boolean;
var
  Index: Integer;
begin
  if Length(A) <> Length(B) then
    Exit(False);

  for Index := Low(A) to High(A) do
  begin
    if not A[Index].Equals(B[Index]) then
      Exit(False);
  end;

  Result := True;
end;

end.

