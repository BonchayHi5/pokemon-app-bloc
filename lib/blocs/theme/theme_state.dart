part of 'theme_bloc.dart';

abstract class ThemeState extends Equatable {

  const ThemeState();
  
  @override
  List<Object> get props => [];
}

class ThemeLoadedState extends ThemeState {
  final bool isDark;
  final ThemeData themeData;

  const ThemeLoadedState({required this.isDark, required this.themeData});
}
