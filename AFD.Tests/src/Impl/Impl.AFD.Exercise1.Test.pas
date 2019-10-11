unit Impl.AFDExercise1.Test;

interface

uses
  TestFramework, Impl.AFD, Impl.List, Impl.Transitions, System.SysUtils, Impl.Types;

type
  TestTAFD = class(TTestCase)
  strict private
    FAFD: TAFD;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  end;

implementation

procedure TestTAFD.SetUp;
const
  Transitisions: TMatrix = [];
begin
  FAFD := TAFD.Create;
  FAFD := FAFD.AddSymbols(['a', 'b', 'c'])
              .AddStates(['S0', 'S1', 'S2', 'S3', 'S4', 'S5', 'S6', 'S7', 'S8'])
              .AddInitialState('S0')
              .AddFinalStates(['S6', 'S7'])
              .AddTransitions(TTransitions.Create(Transitisions));
end;

procedure TestTAFD.TearDown;
begin
  FAFD.Free;
end;

initialization
  RegisterTest(TestTAFD.Suite);

end.

