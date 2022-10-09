// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'pokemon_bloc.dart';

abstract class PokemonBlocEvent extends Equatable {
  const PokemonBlocEvent();

  @override
  List<Object> get props => [];
}

class FetchPokemonEvent extends PokemonBlocEvent {}

class AddToFavEvent extends PokemonBlocEvent{
  final PokemonModel pokemon;
  const AddToFavEvent({required this.pokemon});
}
