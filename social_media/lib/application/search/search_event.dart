part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchUser extends SearchEvent {
  final String query;
  SearchUser({required this.query});
}
