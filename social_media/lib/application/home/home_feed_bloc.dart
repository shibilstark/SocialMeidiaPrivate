// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:social_media/domain/failures/main_failures.dart';
import 'package:social_media/domain/models/home_feed/home_feed_model.dart';
import 'package:social_media/infrastructure/home/home_repo.dart';

part 'home_feed_event.dart';
part 'home_feed_state.dart';

HomeFeedState _newState = HomeFeedLoding();

@injectable
class HomeFeedBloc extends Bloc<HomeFeedEvent, HomeFeedState> {
  final HomeRepo _homeRepo;
  HomeFeedBloc(this._homeRepo) : super(HomeFeedInitial()) {
    on<GetHomeFeed>((event, emit) async {
      if (_newState is HomeFeedLoding) {
        emit(HomeFeedLoding());
      }

      final response = await _homeRepo.getHomeFeed();

      _newState = response.fold((success) {
        return HomeFeedSuccess(success);
      }, (failure) {
        return HomeFeedError(failure);
      });
      emit(_newState);
    });
  }
}
