part of 'search_pokemon_bloc.dart';

abstract class SearchPokemonState extends Equatable {
  const SearchPokemonState();
  
  @override
  List<Object> get props => [];
}

class SearchPokemonInitial extends SearchPokemonState {}
class SearchPokemonLoaded extends SearchPokemonState {
  final List<PokemonModel> pokemonResult;
  const SearchPokemonLoaded({required this.pokemonResult});
}
class SearchPokemonLoading extends SearchPokemonState {}
class SearchPokemonNotFound extends SearchPokemonState {
  final String notFoundMsg;
  const SearchPokemonNotFound({required this.notFoundMsg});
}
class SearchPokemonError extends SearchPokemonState {
  final String errorMsg;
  const SearchPokemonError({required this.errorMsg});
}
