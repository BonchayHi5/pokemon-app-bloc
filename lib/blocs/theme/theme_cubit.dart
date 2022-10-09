import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_app/ui/theme/theme.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(AppTheme.lightTheme);

  void onChangeTheme() {
    if(state == AppTheme.lightTheme) {
      emit(AppTheme.darkTheme);
    } else {
      emit(AppTheme.lightTheme);
    }
  }
}
