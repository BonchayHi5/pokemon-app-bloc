part of 'filter_favorite_bloc.dart';

abstract class FilterFavoriteEvent extends Equatable {
  const FilterFavoriteEvent();

  @override
  List<Object> get props => [];
}


class UpdateFilterFavorite extends FilterFavoriteEvent {
  final List<PokemonModel> pokemonList;
  const UpdateFilterFavorite({this.pokemonList = const <PokemonModel>[]});
   @override
  List<Object> get props => [pokemonList];
}