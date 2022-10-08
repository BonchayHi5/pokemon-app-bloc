import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/model/pokemon_model.dart';
import 'package:pokemon_app/service/api_services.dart';

part 'pokemon_bloc_event.dart';
part 'pokemon_bloc_state.dart';

class PokemonBloc extends Bloc<PokemonBlocEvent, PokemonBlocState> {
  PokemonBloc() : super(PokemonBlocInitialState()) {
    on<FetchPokemonEvent>(_onFetchPoke);
    on<SearchPokemonEvent>(_searchPoke);
  }

  void _onFetchPoke(event, emit) async {
    emit(PokemonBlocLoadingState());
    try {
      final pokemonList = await ApiService.fetchPokemonList();
      emit(PokemonBlocSuccessState(pokemonList: pokemonList));
    } catch (e) {
      emit(PokemonBlocErrorState(errorMsg: e.toString()));
    }
  }

  void _searchPoke(event, emit) async {
    final state = this.state;

    if(state is PokemonBlocSuccessState) {
      if(event.queryText.isNotEmpty) {
        emit(PokemonBlocLoadingState());
        final pokemonList = state.pokemonList.where((element) => element.name.toString().toLowerCase().startsWith(event.queryText.toLowerCase())).toList();
        emit(PokemonBlocSuccessState(pokemonList: pokemonList));
      } else {
        emit(PokemonBlocLoadingState());
        // final pokeList = await ApiService.fetchPokemonList();
        emit(const PokemonBlocSuccessState(pokemonList: []));
      }

    }
  }

}
