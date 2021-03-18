unit Impl.Dialogs;

interface

uses
  FMX.Dialogs, FMX.DialogService, System.SysUtils, System.UITypes;

type
  TDialogs = class sealed
  strict private
    const HelpCtx = 0;
  private
    class function OpenDialog(const ADialog: TOpenDialog; const AExtension: string; out AFileName: string): Boolean;
  public
    class function Confirmation(const AMessage: string): Boolean; overload;
    class function Confirmation(const AMessage: string; const AArgs: array of const): Boolean; overload;
    class procedure Error(const AMessage: string); overload;
    class procedure Error(const AMessage: string; const AArgs: array of const); overload;
    class procedure Information(const AMessage: string); overload;
    class procedure Information(const AMessage: string; const AArgs: array of const); overload;
    class procedure Warning(const AMessage: string); overload;
    class procedure Warning(const AMessage: string; const AArgs: array of const); overload;
    class function OpenFile(const AExtension: string; out AFileName: string): Boolean;
    class function SaveFile(const AExtension: string; out AFileName: string): Boolean;
  end;

implementation

class function TDialogs.Confirmation(const AMessage: string; const AArgs: array of const): Boolean;
begin
  Result := Confirmation(Format(AMessage, AArgs));
end;

class function TDialogs.Confirmation(const AMessage: string): Boolean;
var
  LResult: Boolean;
begin
  TDialogService.MessageDialog(AMessage, TMsgDlgType.mtConfirmation, FMX.Dialogs.mbYesNo, TMsgDlgBtn.mbNo, HelpCtx,
    procedure(const AResult: TModalResult)
    begin
      LResult := IsPositiveResult(AResult);
    end);

  Result := LResult;
end;

class procedure TDialogs.Error(const AMessage: string; const AArgs: array of const);
begin
  Error(Format(AMessage, AArgs));
end;

class procedure TDialogs.Error(const AMessage: string);
begin
  TDialogService.MessageDialog(AMessage, TMsgDlgType.mtError, [TMsgDlgBtn.mbOK], TMsgDlgBtn.mbOK, HelpCtx, nil);
end;

class procedure TDialogs.Information(const AMessage: string; const AArgs: array of const);
begin
  Information(Format(AMessage, AArgs));
end;

class procedure TDialogs.Information(const AMessage: string);
begin
  TDialogService.MessageDialog(AMessage, TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], TMsgDlgBtn.mbOK, HelpCtx, nil);
end;

class procedure TDialogs.Warning(const AMessage: string; const AArgs: array of const);
begin
  Warning(Format(AMessage, AArgs));
end;

class procedure TDialogs.Warning(const AMessage: string);
begin
  TDialogService.MessageDialog(AMessage, TMsgDlgType.mtWarning, [TMsgDlgBtn.mbOK], TMsgDlgBtn.mbOK, HelpCtx, nil);
end;

class function TDialogs.OpenDialog(const ADialog: TOpenDialog; const AExtension: string; out AFileName: string): Boolean;
begin
  if not Assigned(ADialog) then
  begin
    Exit(False);
  end;

  ADialog.Filter := '|*.' + AExtension;
  try
    if ADialog.Execute then
    begin
      AFileName := ADialog.FileName;

      if not AFileName.EndsWith('.' + AExtension) then
      begin
        AFileName := AFileName + '.' + AExtension;
      end;

      Exit(True);
    end;

    Result := False;
  finally
    ADialog.Free;
  end;
end;

class function TDialogs.OpenFile(const AExtension: string; out AFileName: string): Boolean;
begin
  Result := OpenDialog(TOpenDialog.Create(nil), AExtension, AFileName);
end;

class function TDialogs.SaveFile(const AExtension: string; out AFileName: string): Boolean;
begin
  Result := OpenDialog(TSaveDialog.Create(nil), AExtension, AFileName);
end;

end.

