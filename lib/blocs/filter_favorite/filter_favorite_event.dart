part of 'filter_favorite_bloc.dart';

abstract class FilterFavoriteEvent extends Equatable {
  const FilterFavoriteEvent();

  @override
  List<Object> get props => [];
}


class UpdateFilterFavorite extends FilterFavoriteEvent {
  final PokemonModel pokemon;
  const UpdateFilterFavorite({required this.pokemon});
}

