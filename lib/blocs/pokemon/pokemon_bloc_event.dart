// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'pokemon_bloc.dart';

abstract class PokemonBlocEvent extends Equatable {
  const PokemonBlocEvent();

  @override
  List<Object> get props => [];
}

class FetchPokemonEvent extends PokemonBlocEvent {}
// class UpdatePokemonEvent extends PokemonBlocEvent {
//   final PokemonModel pokemon;
//   const UpdatePokemonEvent({required this.pokemon});
// }
class FilterPokemonByTypeEvent extends PokemonBlocEvent {
  // final String pokemonType;
  // const FilterPokemonByTypeEvent(this.pokemonType);
}
class AddFilterPokeTypeEvent extends PokemonBlocEvent {
  final String pokemonType;
  const AddFilterPokeTypeEvent(this.pokemonType);
}

class ClearFilterPokemonByTypeEvent extends PokemonBlocEvent {
}
// class FilterFavPokemonClickedEvent extends PokemonBlocEvent {}
// class FilterFavPokemonEvent extends PokemonBlocEvent {}

