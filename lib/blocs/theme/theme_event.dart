part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
  @override
  List<Object> get props => [];
}

class SwitchThemeEvent extends ThemeEvent {
  final bool isDarkTheme;
  final ThemeData appTheme;
  const SwitchThemeEvent({required this.isDarkTheme, required this.appTheme});
}
