import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokemon_app/blocs/pokemon/pokemon_bloc.dart';
import 'package:pokemon_app/model/pokemon_model.dart';

part 'filter_favorite_event.dart';
part 'filter_favorite_state.dart';

class FilterFavoriteBloc extends Bloc<FilterFavoriteEvent, FilterFavoriteState> {
  final PokemonBloc _pokemonBloc;
  late StreamSubscription _pokemonStream;
  FilterFavoriteBloc({required PokemonBloc pokemonBloc}) : _pokemonBloc = pokemonBloc, super(FilterFavoriteInitial()) {
    on<UpdateFilterFavorite>((event, emit) {
      print("event create ${event.pokemonList.length}");
      emit(FilterFavoriteLoading());
      final favList = event.pokemonList.where((element) => element.isFav).toList();
      emit(FilterFavoriteLoaded(pokemonList: favList));
    });
    _pokemonStream = _pokemonBloc.stream.listen((event) {
      if(event is PokemonBlocSuccessState) {
        add(UpdateFilterFavorite(pokemonList: event.pokemonList));
      }
    });
  }

  void _onUpdateFilterFavortie(event,emit) {
    
  }

  @override
  Future<void> close() {
    _pokemonStream.cancel();
    return super.close();
  }
}
