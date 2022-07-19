import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:social_media/domain/failures/main_failures.dart';
import 'package:social_media/domain/models/profile_model/profile_model.dart';
import 'package:social_media/infrastructure/profile/profile_repo.dart';
import 'package:social_media/infrastructure/profile/profile_services.dart';

part 'profile_event.dart';
part 'profile_state.dart';

@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepo _profile_repo;
  ProfileBloc(this._profile_repo) : super(ProfileInitial()) {
    on<GetCurrentUser>((event, emit) async {
      emit(ProfileLoading());

      final response = await _profile_repo.getCurrentUser();

      final newState = response.fold(
        (success) {
          return emit(ProfileSuccess(success));
        },
        (failure) {
          return emit(ProfileError(failure));
        },
      );
    });
  }
}
