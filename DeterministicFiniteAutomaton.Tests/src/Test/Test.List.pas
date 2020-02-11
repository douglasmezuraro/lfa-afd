unit Test.List;

interface

uses
 Helper.TestFramework, Impl.List, System.SysUtils, TestFramework;

type
  TListTest = class sealed(TTestCase)
  strict private
    FList: TList<string>;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestIsEmptyWhenListIsEmpty;
    procedure TestIsEmptyWhenListIsNotEmpty;
    procedure TestToStringWhenListIsEmpty;
    procedure TestToStringWhenListHasOneElement;
    procedure TestToStringWhenListHasMoreThanOneElement;
    procedure TestDuplicatedWhenListDontHaveDuplicatedElement;
    procedure TestDuplicatedWhenListHaveOneDuplicatedElement;
    procedure TestDuplicatedWhenListHaveMoreThanOneDuplicatedElement;
  end;

implementation

procedure TListTest.SetUp;
begin
  FList := TList<string>.Create;
end;

procedure TListTest.TearDown;
begin
  FList.Free;
end;

procedure TListTest.TestIsEmptyWhenListIsEmpty;
begin
  CheckTrue(FList.IsEmpty);
end;

procedure TListTest.TestIsEmptyWhenListIsNotEmpty;
begin
  FList.Add('q0');
  CheckFalse(FList.IsEmpty);
end;

procedure TListTest.TestDuplicatedWhenListDontHaveDuplicatedElement;
var
  Duplicated: TList<string>;
begin
  FList.AddRange(['q0', 'q1', 'q2', 'q3', 'q4']);

  Duplicated := FList.Duplicated;
  try
    CheckEquals([], Duplicated.ToArray);
  finally
    Duplicated.Free;
  end;
end;

procedure TListTest.TestDuplicatedWhenListHaveOneDuplicatedElement;
var
  Duplicated: TList<string>;
begin
  FList.AddRange(['q0', 'q1', 'q2', 'q3', 'q2']);

  Duplicated := FList.Duplicated;
  try
    CheckEquals(['q2'], Duplicated.ToArray);
  finally
    Duplicated.Free;
  end;
end;

procedure TListTest.TestDuplicatedWhenListHaveMoreThanOneDuplicatedElement;
var
  Duplicated: TList<string>;
begin
  FList.AddRange(['q0', 'q1', 'q2', 'q2', 'q3', 'q1', 'q4', 'q2']);

  Duplicated := FList.Duplicated;
  try
    CheckEquals(['q2', 'q1', 'q2'], Duplicated.ToArray);
  finally
    Duplicated.Free;
  end;
end;

procedure TListTest.TestToStringWhenListIsEmpty;
begin
  CheckEquals('[]', FList.ToString);
end;

procedure TListTest.TestToStringWhenListHasOneElement;
begin
  FList.Add('q0');
  CheckEquals('[q0]', FList.ToString);
end;

procedure TListTest.TestToStringWhenListHasMoreThanOneElement;
begin
  FList.AddRange(['q0', 'q1', 'q2', 'q3']);
  CheckEquals('[q0, q1, q2, q3]', FList.ToString);
end;

initialization
  RegisterTest(TListTest.Suite);

end.

