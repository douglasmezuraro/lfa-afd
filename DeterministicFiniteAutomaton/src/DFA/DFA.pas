unit DFA;

interface

uses
  DFA.Types, DFA.Automaton;

type
  EDuplicated = DFA.Types.EDuplicated;
  ENotDefined = DFA.Types.ENotDefined;
  ENotContains = DFA.Types.ENotContains;
  EInitialStateNotDefined = DFA.Types.EInitialStateNotDefined;
  EFinalStatesNotDefined = DFA.Types.EFinalStatesNotDefined;
  EStatesNotContaisTheState = DFA.Types.EStatesNotContaisTheState;
  ESymbolsNotContainsTheSymbol = DFA.Types.ESymbolsNotContainsTheSymbol;
  EDuplicatedState = DFA.Types.EDuplicatedState;
  EDuplicatedSymbol = DFA.Types.EDuplicatedSymbol;
  TSymbol = DFA.Types.TSymbol;
  TState = DFA.Types.TState;
  TWord = DFA.Types.TWord;
  TTransition = DFA.Types.TTransition;
  TDTO = DFA.Types.TDTO;
  TDeterministicFiniteAutomaton = DFA.Automaton.TDeterministicFiniteAutomaton;

implementation

end.

