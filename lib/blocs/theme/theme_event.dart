part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
  @override
  List<Object> get props => [];
}

class SwitchThemeEvent extends ThemeEvent {
  const SwitchThemeEvent();
}