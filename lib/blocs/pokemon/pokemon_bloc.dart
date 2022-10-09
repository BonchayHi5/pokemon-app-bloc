import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:pokemon_app/model/pokemon_model.dart';
import 'package:pokemon_app/service/api_services.dart';

part 'pokemon_bloc_event.dart';
part 'pokemon_bloc_state.dart';

class PokemonBloc extends Bloc<PokemonBlocEvent, PokemonBlocState> {
  PokemonBloc() : super(PokemonBlocInitialState()) {
    on<FetchPokemonEvent>(_onFetchPoke);
  }

  void _onFetchPoke(event, emit) async {
    emit(PokemonBlocLoadingState());
    try {
      final pokemonList = await ApiService.fetchPokemonList();
      emit(PokemonBlocSuccessState(pokemonList: pokemonList));

    } catch (e) {
      emit(PokemonBlocErrorState(errorMsg: e.toString()));
    }
    // FlutterNativeSplash.remove();
  }

}
