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
  final List<String> filterTypes;
  final List<PokemonModel> pokemonList;
  final List<String> allType;
  final List<PokemonModel> filterPokemonList;
  const PokemonBlocSuccessState({
    required this.filterTypes,
    required this.pokemonList,
    required this.allType,
    required this.filterPokemonList,
  });

  @override
  List<Object> get props => [filterTypes,pokemonList,allType,filterPokemonList];
}

class PokemonBlocErrorState extends PokemonBlocState {
  final String errorMsg;
  const PokemonBlocErrorState({required this.errorMsg});
}

