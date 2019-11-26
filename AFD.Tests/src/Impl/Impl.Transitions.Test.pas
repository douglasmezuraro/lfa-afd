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
  FTransitions.Add(TTransition.Create('Q0', 'Q1', 'a'));
  CheckFalse(FTransitions.IsEmpty)
end;

procedure TTransitionsTest.TestClearWhenHasMoreThanOneTransition;
begin
  FTransitions.Add(TTransition.Create('Q0', 'Q1', 'a'));
  FTransitions.Add(TTransition.Create('Q1', 'Q2', 'a'));
  FTransitions.Add(TTransition.Create('Q2', 'Q3', 'c'));
  FTransitions.Clear;

  CheckTrue(FTransitions.IsEmpty);
end;

procedure TTransitionsTest.TestClearWhenHasOneTransition;
begin
  FTransitions.Add(TTransition.Create('Q0', 'Q1', 'a'));
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
  FTransitions.Add(TTransition.Create('Q0', 'Q1', 'a'));
  FTransitions.Add(TTransition.Create('Q1', 'Q2', 'a'));
  FTransitions.Add(TTransition.Create('Q2', 'Q3', 'c'));
  FTransitions.Add(TTransition.Create('Q3', 'Q4', 'd'));
  FTransitions.Add(TTransition.Create('Q4', 'Q5', 'e'));

  CheckEquals(5, FTransitions.Count);
end;

procedure TTransitionsTest.TestCountWhenHasOneTransition;
begin
  FTransitions.Add(TTransition.Create('Q0', 'Q1', 'a'));
  CheckEquals(1, FTransitions.Count);
end;

procedure TTransitionsTest.TestCountWhenIsEmpty;
begin
  CheckEquals(0, FTransitions.Count);
end;

procedure TTransitionsTest.TestIsEmptyWhenHasMoreThanOneTransition;
begin
  FTransitions.Add(TTransition.Create('Q0', 'Q1', 'a'));
  FTransitions.Add(TTransition.Create('Q1', 'Q2', 'a'));
  FTransitions.Add(TTransition.Create('Q2', 'Q3', 'c'));
  FTransitions.Add(TTransition.Create('Q3', 'Q4', 'd'));
  FTransitions.Add(TTransition.Create('Q4', 'Q5', 'e'));

  CheckFalse(FTransitions.IsEmpty);
end;

procedure TTransitionsTest.TestIsEmptyWhenHasOneTransition;
begin
  FTransitions.Add(TTransition.Create('Q0', 'Q1', 'a'));
  CheckFalse(FTransitions.IsEmpty);
end;

procedure TTransitionsTest.TestIsEmptyWhenIsEmpty;
begin
  CheckTrue(FTransitions.IsEmpty);
end;

procedure TTransitionsTest.TestToArrayWhenHasMoreThanOneTransition;
var
  A, B, C: TTransition;
  Transitions: TArray<TTransition>;
begin
  A := TTransition.Create('Q0', 'Q1', 'a');
  B := TTransition.Create('Q1', 'Q2', 'a');
  C := TTransition.Create('Q2', 'Q3', 'c');

  FTransitions.Add([A, B, C]);
  Transitions := FTransitions.ToArray;

  CheckTrue(A.Equals(Transitions[0]));
  CheckTrue(B.Equals(Transitions[1]));
  CheckTrue(C.Equals(Transitions[2]));
end;

procedure TTransitionsTest.TestToArrayWhenHasOneTransition;
var
  A: TTransition;
  Transitions: TArray<TTransition>;
begin
  A := TTransition.Create('Q0', 'Q1', 'a');
  FTransitions.Add(A);
  Transitions := FTransitions.ToArray;

  CheckTrue(A.Equals(Transitions[0]));
end;

procedure TTransitionsTest.TestToArrayWhenIsEmpty;
var
  Transitions: TArray<TTransition>;
begin
  Transitions := FTransitions.ToArray;
  CheckEquals(0, Length(Transitions));
end;

procedure TTransitionsTest.TestTransitionWhenTransitionExists;
var
  A, B: TTransition;
begin
  A := TTransition.Create('Q0', 'Q1', 'a');
  FTransitions.Add(A);
  B := FTransitions.Transition('Q0', 'a');

  CheckTrue(A.Equals(B));
end;

procedure TTransitionsTest.TestTransitionWhenTransitionNotExists;
var
  A, B: TTransition;
begin
  A := TTransition.Create('Q0', 'Q1', 'a');
  FTransitions.Add(A);
  B := FTransitions.Transition('Q0', 'b');

  CheckFalse(A.Equals(B));
end;

initialization
  RegisterTest(TTransitionsTest.Suite);

end.
