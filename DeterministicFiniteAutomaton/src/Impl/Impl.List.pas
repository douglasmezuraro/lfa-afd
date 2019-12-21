unit Impl.List;

interface

uses
  System.SysUtils;

type
  TList = class sealed
  strict private
    FList: TArray<string>;
  public
    function Contains(const Item: string): Boolean;
    function Count: Integer;
    function HasDuplicated(out Item: string): Boolean;
    function IsEmpty: Boolean;
    function ToArray: TArray<string>;
    function ToString: string; override;
    procedure Add(const Item: string); overload;
    procedure Add(const Items: TArray<string>); overload;
    procedure Clear;
  end;

implementation

procedure TList.Add(const Item: string);
begin
  SetLength(FList, Count + 1);
  FList[High(FList)] := Item;
end;

procedure TList.Add(const Items: TArray<string>);
var
  Element: string;
begin
  for Element in Items do
    Add(Element);
end;

procedure TList.Clear;
begin
  FList := nil;
end;

function TList.Contains(const Item: string): Boolean;
var
  Element: string;
begin
  for Element in FList do
  begin
    if Element.Equals(Item) then
      Exit(True);
  end;

  Result := False;
end;

function TList.Count: Integer;
begin
  Result := Length(FList);
end;

function TList.HasDuplicated(out Item: string): Boolean;
var
  A, B: string;
  Count: Integer;
begin
  for A in FList do
  begin
    Count := 0;
    for B in FList do
    begin
      if A <> B then
        Continue;

      Inc(Count);

      if Count > 1 then
      begin
        Item := A;
        Exit(True);
      end;
    end;
  end;

  Result := False;
end;

function TList.IsEmpty: Boolean;
begin
  Result := FList = nil;
end;

function TList.ToArray: TArray<string>;
begin
  Result := FList;
end;

function TList.ToString: string;
const
  Separator: string = ', ';
var
  Element: string;
  Builder: TStringBuilder;
begin
  if IsEmpty then
    Exit('[]');

  Builder := TStringBuilder.Create('[');
  try
    for Element in FList do
    begin
      Builder.Append(Element).Append(Separator);
    end;

    Result := Builder.Remove(Builder.Length - Separator.Length, Separator.Length).Append(']').ToString;
  finally
    Builder.Free;
  end;
end;

end.

