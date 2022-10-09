part of 'filter_favorite_bloc.dart';

abstract class FilterFavoriteState extends Equatable {
  const FilterFavoriteState();
  
  @override
  List<Object> get props => [];
}

class FilterFavoriteInitial extends FilterFavoriteState {}
class FilterFavoriteLoaded extends FilterFavoriteState {
  final List<PokemonModel> pokemonList;
  const FilterFavoriteLoaded({required this.pokemonList});
}
class FilterFavoriteLoading extends FilterFavoriteState {}
