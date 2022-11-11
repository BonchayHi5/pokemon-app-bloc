import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/ui/screen/widget/pokemon_card.dart';

import '../../../blocs/filter_favorite/filter_favorite_bloc.dart';

class FilterPokeTab extends StatelessWidget {
  const FilterPokeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterFavoriteBloc, FilterFavoriteState>(
        builder: (context, state) {
          if (state is FilterFavoriteLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.blue[900]!,
              ),
            );
          }
          if (state is FilterFavoriteLoaded) {
            return state.pokemonList.isEmpty
                ? const Center(
                    child: Text(
                    "No Favorite Pokemon",
                  ))
                : Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
                    child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 1.2,
                        ),
                        itemCount: state.pokemonList.length,
                        itemBuilder: (BuildContext ctx, index) {
                          final pokemon = state.pokemonList[index];
                          return PokemonCard(pokemon: pokemon);
                        }),
                  );
          }
          return Container();
    });
  }
}
