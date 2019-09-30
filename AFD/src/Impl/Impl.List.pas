unit Impl.List;

interface

uses
  System.SysUtils;

type
  TList = class sealed
  private
    FList: TArray<string>;
  public
    procedure Add(const Item: string);
    procedure Clear;
    function IsEmpty: Boolean;
    function Contains(const Item: string): Boolean;
    function Count: UInt32;
    function ToString: string; override;
  end;

implementation

{ TList }

procedure TList.Add(const Item: string);
begin
  SetLength(FList, Count + 1);
  FList[High(FList)] := Item;
end;

procedure TList.Clear;
begin
  SetLength(FList, 0);
end;

function TList.Contains(const Item: string): Boolean;
var
  LItem: string;
begin
  for LItem in FList do
  begin
    if LItem.Equals(Item) then
      Exit(True);
  end;

  Result := False;
end;

function TList.Count: UInt32;
begin
  Result := Length(FList);
end;

function TList.IsEmpty: Boolean;
begin
  Result := Count = 0;
end;

function TList.ToString: string;
var
  Item: string;
begin
  for Item in FList do
  begin
    if Result.Trim.IsEmpty then
      Result := Item
    else
      Result := Result + ', ' + Item;
  end;

  Result := '[' + Result + ']';
end;

end.
