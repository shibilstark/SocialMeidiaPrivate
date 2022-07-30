import 'dart:developer';

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

ProfileState _newState = ProfileLoading();

@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepo _profile_repo;

  ProfileBloc(this._profile_repo) : super(ProfileInitial()) {
    on<GetCurrentUser>((event, emit) async {
      if (_newState is ProfileLoading) {
        emit(ProfileLoading());
      }

      final response = await _profile_repo.getCurrentUser();

      _newState = response.fold(
        (success) {
          return ProfileSuccess(success);
        },
        (failure) {
          return ProfileError(failure);
        },
      );

      emit(_newState);
    });
  }
}
