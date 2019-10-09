unit Impl.List.Test;

interface

uses
  TestFramework, Impl.List, System.SysUtils;

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
const
  Elements: TArray<string> = ['Led Zeppelin'];
var
  Index: Integer;
begin
  FList.Add(Elements);
  for Index := Low(Elements) to High(Elements) do
    CheckEquals(Elements[Index], FList.ToArray[Index]);
end;

procedure TListTest.TestAddMoreThanOneElement;
const
  Elements: TArray<string> = ['Pink Floyd', 'Kyuss', 'Alcest'];
var
  Index: Integer;
begin
  FList.Add(Elements);
  for Index := Low(Elements) to High(Elements) do
    CheckEquals(Elements[Index], FList.ToArray[Index]);
end;

procedure TListTest.TestIsEmptyWhenListIsEmpty;
begin
  CheckTrue(FList.IsEmpty);
end;

procedure TListTest.TestIsEmptyWhenListIsNotEmpty;
begin
  FList.Add('Opeth');
  CheckFalse(FList.IsEmpty);
end;

procedure TListTest.TestClearWhenListIsEmpty;
begin
  FList.Clear;
  CheckTrue(FList.IsEmpty);
end;

procedure TListTest.TestClearWhenListHasOneElement;
begin
  FList.Add('Alice In Chains');
  FList.Clear;
  CheckTrue(FList.IsEmpty);
end;

procedure TListTest.TestClearWhenListHasMoreThanOneElement;
begin
  FList.Add(['Midlake', 'Agalloch', 'Blind Melon']);
  FList.Clear;
  CheckTrue(FList.IsEmpty);
end;

procedure TListTest.TestCountWhenListIsEmpty;
begin
  CheckEquals(0, FList.Count);
end;

procedure TListTest.TestCountWhenListHasOneElement;
begin
  FList.Add('Rush');
  CheckEquals(1, FList.Count);
end;

procedure TListTest.TestCountWhenListHasMoreThanOneElement;
begin
  FList.Add(['Explosions In The Sky', 'God Is An Astronaut', 'Caspian', 'Mono']);
  CheckEquals(4, FList.Count);
end;

procedure TListTest.TestContainsWhenListContainsTheElement;
begin
  FList.Add(['Black Sabbath', 'Deep Purple', 'Blue Öyster Cult', 'Uriah Heep']);
  CheckTrue(FList.Contains('Blue Öyster Cult'));
end;

procedure TListTest.TestContainsWhenListNotContainsTheElement;
begin
  CheckFalse(FList.Contains('Iron Maiden'));
end;

procedure TListTest.TestToStringWhenListIsEmpty;
begin
  CheckEquals('[]', FList.ToString);
end;

procedure TListTest.TestToStringWhenListHasOneElement;
begin
  FList.Add('Judas Priest');
  CheckEquals('[Judas Priest]', FList.ToString);
end;

procedure TListTest.TestToStringWhenListHasMoreThanOneElement;
begin
  FList.Add(['Anthax', 'Megadeth', 'Metallica', 'Slayer']);
  CheckEquals('[Anthax, Megadeth, Metallica, Slayer]', FList.ToString);
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
begin
  FList.Add(['S0', 'S1', 'S2', 'S3', 'S4']);

  CheckEquals('S0',  FList.ToArray[0]);
  CheckEquals('S1',  FList.ToArray[1]);
  CheckEquals('S2',  FList.ToArray[2]);
  CheckEquals('S3',  FList.ToArray[3]);
  CheckEquals('S4',  FList.ToArray[4]);
end;

initialization
  RegisterTest(TListTest.Suite);

end.

