abstract class SearchStates {}

class InitialSearchState extends SearchStates {}

class LoadingSearchState extends SearchStates {}

class SucessSearchState extends SearchStates {}

class ErrorSearchState extends SearchStates {
  final String error;
  ErrorSearchState(this.error);
}