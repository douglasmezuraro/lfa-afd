unit Impl.AFDExercise1.Test;

interface

uses
  TestFramework, Impl.AFD, Impl.List, Impl.Transitions, System.SysUtils, Impl.Types;

type
  TestTAFD = class(TTestCase)
  private
    FAFD: TAFD;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestAcceptWithWordsTheyMustAccept;
    procedure TestAcceptWithWordsTheyMustNotAccept;
  end;

implementation

procedure TestTAFD.SetUp;
const
  Transitisions: TMatrix = [['  ', 'a ', 'b ', 'c '],
                            ['S0', 'S1', '  ', '  '],
                            ['S1', 'S1', '  ', 'S2'],
                            ['S2', 'S3', 'S4', 'S2'],
                            ['S3', '  ', 'S5', '  '],
                            ['S4', 'S5', '  ', '  '],
                            ['S5', '  ', '  ', 'S6'],
                            ['S6', 'S7', '  ', '  '],
                            ['S7', 'S8', '  ', '  '],
                            ['S8', 'S7', '  ', '  ']];
begin
  FAFD := TAFD.Create;
  FAFD := FAFD.AddSymbols(['a', 'b', 'c'])
              .AddStates(['S0', 'S1', 'S2', 'S3', 'S4', 'S5', 'S6', 'S7', 'S8'])
              .AddInitialState('S0')
              .AddFinalStates(['S6', 'S8'])
              .AddTransitions(Transitisions);
end;

procedure TestTAFD.TearDown;
begin
  FAFD.Free;
end;

procedure TestTAFD.TestAcceptWithWordsTheyMustAccept;
const
  Words: TArray<TWord> = ['acabc',
                          'acbac',
                          'acabcaa',
                          'acbacaa',
                          'aaccabc',
                          'aaccbac',
                          'aaccabcaaaa',
                          'aaccbacaaaa',
                          'aaccabcaaaaaa',
                          'aaccbacaaaa'];
var
  Word: TWord;
begin
  for Word in Words do
    CheckTrue(FAFD.Accept(Word));
end;

procedure TestTAFD.TestAcceptWithWordsTheyMustNotAccept;
const
  Words: TArray<TWord> = ['',
                          'a',
                          'b',
                          'c',
                          'ac',
                          'aca',
                          'acb',
                          'acab',
                          'acba',
                          'acabca',
                          'acbaca',
                          'acabcaaa',
                          'acbacaaa',
                          'acabcaaaaa',
                          'acbacaaaaa'];
var
  Word: TWord;
begin
  for Word in Words do
    CheckFalse(FAFD.Accept(Word));
end;

initialization
  RegisterTest(TestTAFD.Suite);

end.

