// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'pokemon_bloc.dart';

abstract class PokemonBlocState extends Equatable {
  const PokemonBlocState();
  
  @override
  List<Object> get props => [];
}

class PokemonBlocInitialState extends PokemonBlocState {}
class PokemonBlocLoadingState extends PokemonBlocState {}
class PokemonBlocSuccessState extends PokemonBlocState {
  bool isFilterFav;
  final List<PokemonModel> pokemonList;
  List<PokemonModel> filterPokemonList;
  PokemonBlocSuccessState({
    this.isFilterFav = false,
    required this.pokemonList,
    required this.filterPokemonList,
  });
}

class PokemonBlocErrorState extends PokemonBlocState {
  final String errorMsg;
  const PokemonBlocErrorState({required this.errorMsg});
}

