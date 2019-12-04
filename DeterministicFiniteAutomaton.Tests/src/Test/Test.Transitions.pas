unit Test.Transitions;

interface

uses
  Impl.Transition, Impl.Transitions, TestFramework;

type
  TTransitionsTest = class(TTestCase)
  strict private
    FTransitions: TTransitions;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestAdd;
    procedure TestClearWhenHasMoreThanOneTransition;
    procedure TestClearWhenHasOneTransition;
    procedure TestClearWhenIsEmpty;
    procedure TestCountWhenHasMoreThenOneTransition;
    procedure TestCountWhenHasOneTransition;
    procedure TestCountWhenIsEmpty;
    procedure TestIsEmptyWhenHasMoreThanOneTransition;
    procedure TestIsEmptyWhenHasOneTransition;
    procedure TestIsEmptyWhenIsEmpty;
    procedure TestToArrayWhenHasMoreThanOneTransition;
    procedure TestToArrayWhenHasOneTransition;
    procedure TestToArrayWhenIsEmpty;
    procedure TestTransitionWhenTransitionExists;
    procedure TestTransitionWhenTransitionNotExists;
  end;

implementation

procedure TTransitionsTest.SetUp;
begin
  FTransitions := TTransitions.Create;
end;

procedure TTransitionsTest.TearDown;
begin
  FTransitions.Free;
end;

procedure TTransitionsTest.TestAdd;
begin
  FTransitions.Add(TTransition.Create('q0', 'a', 'q1'));
  CheckFalse(FTransitions.IsEmpty)
end;

procedure TTransitionsTest.TestClearWhenHasMoreThanOneTransition;
begin
  FTransitions.Add(TTransition.Create('q0', 'a', 'q1'));
  FTransitions.Add(TTransition.Create('q1', 'a', 'q2'));
  FTransitions.Add(TTransition.Create('q2', 'c', 'q3'));
  FTransitions.Clear;

  CheckTrue(FTransitions.IsEmpty);
end;

procedure TTransitionsTest.TestClearWhenHasOneTransition;
begin
  FTransitions.Add(TTransition.Create('q0', 'a', 'q1'));
  FTransitions.Clear;
  CheckTrue(FTransitions.IsEmpty);
end;

procedure TTransitionsTest.TestClearWhenIsEmpty;
begin
  FTransitions.Clear;
  CheckTrue(FTransitions.IsEmpty);
end;

procedure TTransitionsTest.TestCountWhenHasMoreThenOneTransition;
begin
  FTransitions.Add(TTransition.Create('q0', 'a', 'q1'));
  FTransitions.Add(TTransition.Create('q1', 'a', 'q2'));
  FTransitions.Add(TTransition.Create('q2', 'c', 'q3'));
  FTransitions.Add(TTransition.Create('q3', 'd', 'q4'));
  FTransitions.Add(TTransition.Create('q4', 'e', 'q5'));

  CheckEquals(5, FTransitions.Count);
end;

procedure TTransitionsTest.TestCountWhenHasOneTransition;
begin
  FTransitions.Add(TTransition.Create('q0', 'a', 'q1'));
  CheckEquals(1, FTransitions.Count);
end;

procedure TTransitionsTest.TestCountWhenIsEmpty;
begin
  CheckEquals(0, FTransitions.Count);
end;

procedure TTransitionsTest.TestIsEmptyWhenHasMoreThanOneTransition;
begin
  FTransitions.Add(TTransition.Create('q0', 'a', 'q1'));
  FTransitions.Add(TTransition.Create('q1', 'a', 'q2'));
  FTransitions.Add(TTransition.Create('q2', 'c', 'q3'));
  FTransitions.Add(TTransition.Create('q3', 'd', 'q4'));
  FTransitions.Add(TTransition.Create('q4', 'e', 'q5'));

  CheckFalse(FTransitions.IsEmpty);
end;

procedure TTransitionsTest.TestIsEmptyWhenHasOneTransition;
begin
  FTransitions.Add(TTransition.Create('q0', 'a', 'q1'));
  CheckFalse(FTransitions.IsEmpty);
end;

procedure TTransitionsTest.TestIsEmptyWhenIsEmpty;
begin
  CheckTrue(FTransitions.IsEmpty);
end;

procedure TTransitionsTest.TestToArrayWhenHasMoreThanOneTransition;
var
  A, B, C: TTransition;
begin
  A := TTransition.Create('q0', 'a', 'q1');
  B := TTransition.Create('q1', 'a', 'q2');
  C := TTransition.Create('q2', 'c', 'q3');

  FTransitions.Add([A, B, C]);

  CheckTrue(A.Equals(FTransitions.ToArray[0]));
  CheckTrue(B.Equals(FTransitions.ToArray[1]));
  CheckTrue(C.Equals(FTransitions.ToArray[2]));
end;

procedure TTransitionsTest.TestToArrayWhenHasOneTransition;
var
  Transition: TTransition;
begin
  Transition := TTransition.Create('q0', 'a', 'q1');
  FTransitions.Add(Transition);

  CheckTrue(Transition.Equals(FTransitions.ToArray[0]));
end;

procedure TTransitionsTest.TestToArrayWhenIsEmpty;
begin
  CheckEquals(0, Length(FTransitions.ToArray));
end;

procedure TTransitionsTest.TestTransitionWhenTransitionExists;
var
  A, B: TTransition;
begin
  A := TTransition.Create('q0', 'a', 'q1');
  FTransitions.Add(A);
  B := FTransitions.Transition('q0', 'a');

  CheckTrue(A.Equals(B));
end;

procedure TTransitionsTest.TestTransitionWhenTransitionNotExists;
var
  A, B: TTransition;
begin
  A := TTransition.Create('q0', 'a', 'q1');
  FTransitions.Add(A);
  B := FTransitions.Transition('q0', 'b');

  CheckFalse(A.Equals(B));
end;

initialization
  RegisterTest(TTransitionsTest.Suite);

end.
