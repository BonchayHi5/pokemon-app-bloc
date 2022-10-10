import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokemon_app/model/pokemon_model.dart';

part 'filter_favorite_event.dart';
part 'filter_favorite_state.dart';

class FilterFavoriteBloc extends Bloc<FilterFavoriteEvent, FilterFavoriteState> {

  FilterFavoriteBloc() : super(FilterFavoriteInitial()) {
    on<UpdateFilterFavorite>((event, emit) {
      final state = this.state;
      if(state is FilterFavoriteLoaded) {
        emit(FilterFavoriteLoading());
        emit(FilterFavoriteLoaded(pokemonList: List.from(state.pokemonList)..add(event.pokemon)));
      }
    });

  }

}
