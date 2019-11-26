unit Impl.Transitions.Test;

interface

uses
  Impl.Transitions, Impl.Transition, TestFramework;

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
  FTransitions.Add(TTransition.Create('Q0', 'a', 'Q1'));
  CheckFalse(FTransitions.IsEmpty)
end;

procedure TTransitionsTest.TestClearWhenHasMoreThanOneTransition;
begin
  FTransitions.Add(TTransition.Create('Q0', 'a', 'Q1'));
  FTransitions.Add(TTransition.Create('Q1', 'a', 'Q2'));
  FTransitions.Add(TTransition.Create('Q2', 'c', 'Q3'));
  FTransitions.Clear;

  CheckTrue(FTransitions.IsEmpty);
end;

procedure TTransitionsTest.TestClearWhenHasOneTransition;
begin
  FTransitions.Add(TTransition.Create('Q0', 'a', 'Q1'));
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
  FTransitions.Add(TTransition.Create('Q0', 'a', 'Q1'));
  FTransitions.Add(TTransition.Create('Q1', 'a', 'Q2'));
  FTransitions.Add(TTransition.Create('Q2', 'c', 'Q3'));
  FTransitions.Add(TTransition.Create('Q3', 'd', 'Q4'));
  FTransitions.Add(TTransition.Create('Q4', 'e', 'Q5'));

  CheckEquals(5, FTransitions.Count);
end;

procedure TTransitionsTest.TestCountWhenHasOneTransition;
begin
  FTransitions.Add(TTransition.Create('Q0', 'a', 'Q1'));
  CheckEquals(1, FTransitions.Count);
end;

procedure TTransitionsTest.TestCountWhenIsEmpty;
begin
  CheckEquals(0, FTransitions.Count);
end;

procedure TTransitionsTest.TestIsEmptyWhenHasMoreThanOneTransition;
begin
  FTransitions.Add(TTransition.Create('Q0', 'a', 'Q1'));
  FTransitions.Add(TTransition.Create('Q1', 'a', 'Q2'));
  FTransitions.Add(TTransition.Create('Q2', 'c', 'Q3'));
  FTransitions.Add(TTransition.Create('Q3', 'd', 'Q4'));
  FTransitions.Add(TTransition.Create('Q4', 'e', 'Q5'));

  CheckFalse(FTransitions.IsEmpty);
end;

procedure TTransitionsTest.TestIsEmptyWhenHasOneTransition;
begin
  FTransitions.Add(TTransition.Create('Q0', 'a', 'Q1));
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
  A := TTransition.Create('Q0', 'a', 'Q1');
  B := TTransition.Create('Q1', 'a', 'Q2');
  C := TTransition.Create('Q2', 'c', 'Q3');

  FTransitions.Add([A, B, C]);

  CheckTrue(A.Equals(FTransitions.ToArray[0]));
  CheckTrue(B.Equals(FTransitions.ToArray[1]));
  CheckTrue(C.Equals(FTransitions.ToArray[2]));
end;

procedure TTransitionsTest.TestToArrayWhenHasOneTransition;
var
  A: TTransition;
begin
  A := TTransition.Create('Q0', 'a', 'Q1');
  FTransitions.Add(A);

  CheckTrue(A.Equals(FTransitions.ToArray[0]));
end;

procedure TTransitionsTest.TestToArrayWhenIsEmpty;
begin
  CheckEquals(0, Length(FTransitions.ToArray));
end;

procedure TTransitionsTest.TestTransitionWhenTransitionExists;
var
  A, B: TTransition;
begin
  A := TTransition.Create('Q0', 'a', 'Q1');
  FTransitions.Add(A);
  B := FTransitions.Transition('Q0', 'a');

  CheckTrue(A.Equals(B));
end;

procedure TTransitionsTest.TestTransitionWhenTransitionNotExists;
var
  A, B: TTransition;
begin
  A := TTransition.Create('Q0', 'a', 'Q1');
  FTransitions.Add(A);
  B := FTransitions.Transition('Q0', 'b');

  CheckFalse(A.Equals(B));
end;

initialization
  RegisterTest(TTransitionsTest.Suite);

end.
