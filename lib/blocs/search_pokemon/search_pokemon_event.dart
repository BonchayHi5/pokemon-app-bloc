// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_pokemon_bloc.dart';

abstract class SearchPokemonEvent extends Equatable {
    
  @override
  List<Object> get props => [];
}

class SearchPokemon extends SearchPokemonEvent {
  final String queryText;
  SearchPokemon({required this.queryText});
}






