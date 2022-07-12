import 'dart:convert';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:social_media/core/constants/enums.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> with HydratedMixin {
  ThemeBloc() : super(ThemeInitial()) {
    on<ChangeTheme>((event, emit) {
      if (event.changeTo == MyThemeMode.dark) {
        emit(state.copyWith(isDark: true));
      }
      if (event.changeTo == MyThemeMode.light) {
        emit(state.copyWith(isDark: false));
      }
    });
    on<GetTheme>((event, emit) {});
  }

  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    return ThemeState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(ThemeState state) {
    return state.toMap();
  }
}
