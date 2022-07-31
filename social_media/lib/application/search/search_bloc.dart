import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:social_media/domain/failures/main_failures.dart';
import 'package:social_media/domain/models/user_model/user_model.dart';
import 'package:social_media/infrastructure/search/search_repo.dart';

part 'search_event.dart';
part 'search_state.dart';

@injectable
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepo _searchRepo;
  SearchBloc(this._searchRepo) : super(SearchIdle()) {
    on<SearchUser>((event, emit) async {
      if (event.query.isEmpty) {
        emit(SearchIdle());
      } else {
        emit(SearchLoading());

        final response = await _searchRepo.searchUser(query: event.query);

        final newState = response.fold((results) {
          return SearchSuccess(results);
        }, (err) {
          return SearchError(err);
        });

        emit(newState);
      }
    });
  }
}
