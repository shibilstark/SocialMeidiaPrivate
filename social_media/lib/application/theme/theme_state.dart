// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'theme_bloc.dart';

class ThemeState {
  bool isDark;

  ThemeState({required this.isDark});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isDark': isDark,
    };
  }

  factory ThemeState.fromMap(Map<String, dynamic> map) {
    return ThemeState(
      isDark: map['isDark'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ThemeState.fromJson(String source) =>
      ThemeState.fromMap(json.decode(source) as Map<String, dynamic>);

  ThemeState copyWith({
    bool? isDark,
  }) {
    return ThemeState(
      isDark: isDark ?? this.isDark,
    );
  }
}

class ThemeInitial extends ThemeState {
  ThemeInitial() : super(isDark: false);
}
