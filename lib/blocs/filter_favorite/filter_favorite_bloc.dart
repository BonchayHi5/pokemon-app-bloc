import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokemon_app/model/pokemon_model.dart';

part 'filter_favorite_event.dart';
part 'filter_favorite_state.dart';

class FilterFavoriteBloc extends Bloc<FilterFavoriteEvent, FilterFavoriteState> {
  FilterFavoriteBloc() : super(const FilterFavoriteLoaded(pokemonList: [])) {
    on<UpdateFilterFavorite>(_updateFilterFavorite);
  }

  void _updateFilterFavorite(event, emit) {
    final state = this.state;
    if(state is FilterFavoriteLoaded) {
      emit(FilterFavoriteLoading());
      if(state.pokemonList.contains(event.pokemon)) {
        emit(FilterFavoriteLoaded(pokemonList: List.from(state.pokemonList)..remove(event.pokemon)));
      } else {
        emit(FilterFavoriteLoaded(pokemonList: List.from(state.pokemonList)..add(event.pokemon)));
      }
    }
  }

  List get getfavouriteBreeds {
    final state = this.state;
    List pokemonList = [];
    if(state is FilterFavoriteLoaded) {
      pokemonList = state.pokemonList;
    }
    return pokemonList;
  }
}
