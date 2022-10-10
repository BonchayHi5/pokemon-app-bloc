import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<ChangeLocaleState> {
  LocaleCubit() : super(ChangeLocaleState(locale: const Locale("en")));

  void changeLocale(String languageCode) {
    print("change local $languageCode");
    emit(ChangeLocaleState(locale: Locale(languageCode)));
  }
}
