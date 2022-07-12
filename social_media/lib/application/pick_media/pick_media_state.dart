part of 'pick_media_bloc.dart';

abstract class PickMediaState extends Equatable {
  const PickMediaState();

  @override
  List<Object> get props => [];
}

class PickMediaInitial extends PickMediaState {}

class PickMediaLoading extends PickMediaState {}

class PickMediaSuccess extends PickMediaState {
  final PostTypeModel postTypeModel;
  PickMediaSuccess({required this.postTypeModel});
}

class PickMediaError extends PickMediaState {
  final MainFailures failure;
  PickMediaError({required this.failure});
}
