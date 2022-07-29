import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_feed_event.dart';
part 'home_feed_state.dart';

class HomeFeedBloc extends Bloc<HomeFeedEvent, HomeFeedState> {
  HomeFeedBloc() : super(HomeFeedInitial()) {
    on<HomeFeedEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
