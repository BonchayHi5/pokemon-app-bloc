// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'pokemon_bloc.dart';

abstract class PokemonBlocEvent extends Equatable {
  const PokemonBlocEvent();

  @override
  List<Object> get props => [];
}

class FetchPokemonEvent extends PokemonBlocEvent {}
class FilterPokemonByTypeEvent extends PokemonBlocEvent {}
class AddFilterPokeTypeEvent extends PokemonBlocEvent {
  final String pokemonType;
  const AddFilterPokeTypeEvent(this.pokemonType);
}
class RemoveFilterPokeTypeEvent extends PokemonBlocEvent {
  final String pokemonType;
  const RemoveFilterPokeTypeEvent(this.pokemonType);
}
class ClearFilterPokemonByTypeEvent extends PokemonBlocEvent {}


