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
    on<UpdatePokemonEvent>(_onUpdatePoke);
    on<FilterFavPokemonClickedEvent>(_onFilterFavPokeClicked);
    on<FilterFavPokemonEvent>(_onFilterFavPoke);
  }

  void _onFetchPoke(event, emit) async {
    emit(PokemonBlocLoadingState());
    try {
      final pokemonList = await ApiService.fetchPokemonList();
      emit(
        PokemonBlocSuccessState(
          pokemonList: pokemonList,filterPokemonList: const [],
        ),
      );
    } catch (e) {
      emit(PokemonBlocErrorState(errorMsg: e.toString()));
    }
    FlutterNativeSplash.remove();
  }


  void _onUpdatePoke(event, emit) async {
    final state = this.state;
    if(state is PokemonBlocSuccessState) {
      final initialList = state.pokemonList;
      final poke = initialList.firstWhere((element) => element.id == event.pokemon.id);
      poke.isFav = !poke.isFav;
      if(!state.isFilterFav) {
        emit(PokemonBlocLoadingState());
        emit(
          PokemonBlocSuccessState(
            isFilterFav: state.isFilterFav,
            pokemonList: initialList,
            filterPokemonList: const []
          ),
        );
      }
    }
  }
  
  void _onFilterFavPokeClicked(event, emit) async {
    final state = this.state;
    if(state is PokemonBlocSuccessState) {
      final initialList = state.pokemonList;
      final filterPokeList = getFavPokeList(initialList);
      state.isFilterFav = !state.isFilterFav;
      emit(PokemonBlocLoadingState());
      emit(
        PokemonBlocSuccessState(
          isFilterFav: state.isFilterFav, 
          pokemonList: initialList,
          filterPokemonList: filterPokeList
        ),
      );
    }
  }

  void _onFilterFavPoke(event, emit) async {
    final state = this.state;
    if(state is PokemonBlocSuccessState) {
      final initialList = state.pokemonList;
      final filterPokeList = getFavPokeList(initialList);
      emit(PokemonBlocLoadingState());
      emit(
        PokemonBlocSuccessState(
          isFilterFav: state.isFilterFav,
          pokemonList: initialList,
          filterPokemonList: filterPokeList
        ),
      );
    }
  }

  List<PokemonModel> getFavPokeList(List<PokemonModel> initialList) {
    return initialList.where((element) => element.isFav).toList();
  }

}
