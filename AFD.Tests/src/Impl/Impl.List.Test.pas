unit Impl.List.Test;

interface

uses
  TestFramework, TestFramework.Helpers, Impl.List, System.SysUtils;

type
  TListTest = class(TTestCase)
  strict private
    FList: TList;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestAddOneElement;
    procedure TestAddMoreThanOneElement;
    procedure TestIsEmptyWhenListIsEmpty;
    procedure TestIsEmptyWhenListIsNotEmpty;
    procedure TestClearWhenListIsEmpty;
    procedure TestClearWhenListHasOneElement;
    procedure TestClearWhenListHasMoreThanOneElement;
    procedure TestCountWhenListIsEmpty;
    procedure TestCountWhenListHasOneElement;
    procedure TestCountWhenListHasMoreThanOneElement;
    procedure TestContainsWhenListContainsTheElement;
    procedure TestContainsWhenListNotContainsTheElement;
    procedure TestToStringWhenListIsEmpty;
    procedure TestToStringWhenListHasOneElement;
    procedure TestToStringWhenListHasMoreThanOneElement;
    procedure TestToArrayWhenListIsEmpty;
    procedure TestToArrayWhenListHasOneElement;
    procedure TestToArrayWhenListHasMoreThanOneElement;
    procedure TestHasDuplicatedWhenListDoesntHaveDuplicatedElement;
    procedure TestHasDuplicatedWhenListHaveDuplicatedElement;
  end;

implementation

procedure TListTest.SetUp;
begin
  FList := TList.Create;
end;

procedure TListTest.TearDown;
begin
  FList.Free;
end;

procedure TListTest.TestAddOneElement;
begin
  FList.Add('S0');
  CheckEquals('S0', FList.ToArray[0]);
end;

procedure TListTest.TestAddMoreThanOneElement;
const
  Elements: TArray<string> = ['S0', 'S1', 'S2'];
begin
  FList.Add(Elements);
  CheckEquals(Elements, FList.ToArray);
end;

procedure TListTest.TestIsEmptyWhenListIsEmpty;
begin
  CheckTrue(FList.IsEmpty);
end;

procedure TListTest.TestIsEmptyWhenListIsNotEmpty;
begin
  FList.Add('S0');
  CheckFalse(FList.IsEmpty);
end;

procedure TListTest.TestClearWhenListIsEmpty;
begin
  FList.Clear;
  CheckTrue(FList.IsEmpty);
end;

procedure TListTest.TestClearWhenListHasOneElement;
begin
  FList.Add('S0');
  FList.Clear;
  CheckTrue(FList.IsEmpty);
end;

procedure TListTest.TestClearWhenListHasMoreThanOneElement;
begin
  FList.Add(['S0', 'S1', 'S2']);
  FList.Clear;
  CheckTrue(FList.IsEmpty);
end;

procedure TListTest.TestCountWhenListIsEmpty;
begin
  CheckEquals(0, FList.Count);
end;

procedure TListTest.TestHasDuplicatedWhenListDoesntHaveDuplicatedElement;
var
  Element: string;
begin
  FList.Add(['S0', 'S1', 'S2', 'S3', 'S1', 'S4']);
  CheckTrue(Flist.HasDuplicated(Element));
  CheckEquals('S1', Element);
end;

procedure TListTest.TestHasDuplicatedWhenListHaveDuplicatedElement;
var
  Element: string;
begin
  FList.Add(['S0', 'S1', 'S2', 'S3', 'S4']);
  CheckFalse(Flist.HasDuplicated(Element));
  CheckEquals(string.Empty, Element);
end;

procedure TListTest.TestCountWhenListHasOneElement;
begin
  FList.Add('S0');
  CheckEquals(1, FList.Count);
end;

procedure TListTest.TestCountWhenListHasMoreThanOneElement;
begin
  FList.Add(['S0', 'S1', 'S2', 'S3']);
  CheckEquals(4, FList.Count);
end;

procedure TListTest.TestContainsWhenListContainsTheElement;
begin
  FList.Add(['S0', 'S1', 'S2', 'S3']);
  CheckTrue(FList.Contains('S2'));
end;

procedure TListTest.TestContainsWhenListNotContainsTheElement;
begin
  FList.Add(['S0', 'S1', 'S2']);
  CheckFalse(FList.Contains('S3'));
end;

procedure TListTest.TestToStringWhenListIsEmpty;
begin
  CheckEquals('[]', FList.ToString);
end;

procedure TListTest.TestToStringWhenListHasOneElement;
begin
  FList.Add('S0');
  CheckEquals('[S0]', FList.ToString);
end;

procedure TListTest.TestToStringWhenListHasMoreThanOneElement;
begin
  FList.Add(['S0', 'S1', 'S2', 'S3']);
  CheckEquals('[S0, S1, S2, S3]', FList.ToString);
end;

procedure TListTest.TestToArrayWhenListIsEmpty;
begin
  CheckEquals(0, Length(FList.ToArray));
end;

procedure TListTest.TestToArrayWhenListHasOneElement;
begin
  FList.Add('S0');
  CheckEquals('S0', FList.ToArray[0]);
end;

procedure TListTest.TestToArrayWhenListHasMoreThanOneElement;
const
  Elements: TArray<string> = ['S0', 'S1', 'S2', 'S3', 'S4'];
begin
  FList.Add(Elements);
  CheckEquals(Elements,  FList.ToArray);
end;

initialization
  RegisterTest(TListTest.Suite);

end.

