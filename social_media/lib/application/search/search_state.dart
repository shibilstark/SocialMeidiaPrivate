part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchIdle extends SearchState {}

class SearchSuccess extends SearchState {
  List<UserModel> results;
  SearchSuccess(this.results);
}

class SearchError extends SearchState {
  MainFailures failures;

  SearchError(this.failures);
  @override
  List<Object> get props => [failures];
}
