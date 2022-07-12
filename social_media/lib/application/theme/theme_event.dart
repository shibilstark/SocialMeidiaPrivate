part of 'theme_bloc.dart';

abstract class ThemeEvent {}

class ChangeTheme extends ThemeEvent {
  MyThemeMode changeTo;

  ChangeTheme({required this.changeTo});
}

class GetTheme extends ThemeEvent {}
