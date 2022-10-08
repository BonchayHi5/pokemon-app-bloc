import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_app/ui/theme/theme.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeLoadedState(appThemeData[AppTheme.light]!)) {
    on<SwitchThemeEvent>(_onSwitchThemeEvent);
  }

  void _onSwitchThemeEvent(event,emit) {
    
  }

}
