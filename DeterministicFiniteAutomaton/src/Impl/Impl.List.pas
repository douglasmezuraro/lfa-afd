unit Impl.List;

interface

uses
  System.Generics.Collections, System.Rtti, System.SysUtils;

type
  TList<T> = class sealed(System.Generics.Collections.TList<T>)
  public
    function Duplicated: TList<T>;
    function IsEmpty: Boolean;
    function ToString: string; override;
  end;

implementation

function TList<T>.Duplicated: TList<T>;
var
  Temp: TList<T>;
  Element: T;
begin
  Result := TList<T>.Create;
  Temp := TList<T>.Create;
  try
    for Element in List do
    begin
      if Temp.Contains(Element) then
        Result.Add(Element);

      Temp.Add(Element);
    end;
  finally
    Temp.Free;
  end;
end;

function TList<T>.IsEmpty: Boolean;
begin
  Result := List = nil;
end;

function TList<T>.ToString: string;
const
  Separator: string = ', ';
var
  Element: T;
  Builder: TStringBuilder;
begin
  if IsEmpty then
  begin
    Exit('[]');
  end;

  Builder := TStringBuilder.Create('[');
  try
    for Element in List do
    begin
      Builder.Append(TValue.From<T>(Element).ToString).Append(Separator);
    end;

    Result := Builder.Remove(Builder.Length - Separator.Length, Separator.Length).Append(']').ToString;
  finally
    Builder.Free;
  end;
end;

end.

