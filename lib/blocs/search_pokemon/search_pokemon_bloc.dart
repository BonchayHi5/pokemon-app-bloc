import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokemon_app/model/pokemon_model.dart';

part 'search_pokemon_event.dart';
part 'search_pokemon_state.dart';

class SearchPokemonBloc extends Bloc<SearchPokemonEvent, SearchPokemonState> {
  SearchPokemonBloc() : super(SearchPokemonInitial()) {
    on<SearchPokemonEvent>(_searchPoke);
  }
  
  void _searchPoke(event, emit) async {
    if(event.queryText.isEmpty) {
      emit(SearchPokemonInitial());
    } else {
      emit(SearchPokemonLoading());
      try {
        final pokemonList = event.pokemonList;
        final resultList = pokemonList.where((element) => element.name.toString().toLowerCase().contains(event.queryText.toLowerCase())).toList();
        if(resultList.isNotEmpty) {
          emit(SearchPokemonLoaded(pokemonResult: resultList));
        } else {
          emit(const SearchPokemonNotFound(notFoundMsg: "No Pokemon Found"));
        }
      } catch (e) {
        emit(SearchPokemonError(errorMsg: e.toString()));
      }
    }
  }


}
