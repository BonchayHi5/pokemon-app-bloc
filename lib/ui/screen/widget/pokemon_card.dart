import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/blocs/filter_favorite/filter_favorite_bloc.dart';
import 'package:pokemon_app/model/pokemon_model.dart';
import 'package:pokemon_app/ui/screen/home_detail_screen.dart';
import 'package:pokemon_app/utils/app_utils.dart';


class PokemonCard extends StatelessWidget {
  final PokemonModel pokemon;
  const PokemonCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return HomeDetailScreen(pokemon: pokemon);
        }));
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppUtils.toPokemonTypeColor(
            type: pokemon.typeofpokemon.first
          ),
          borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  pokemon.id,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                BlocBuilder<FilterFavoriteBloc,FilterFavoriteState>(
                  builder: ((context, state) {
                    final favState = state is FilterFavoriteLoaded;
                    if(favState) {
                      return  GestureDetector(
                        onTap: () {
                          final favBloc =  context.read<FilterFavoriteBloc>();
                          favBloc.add(UpdateFilterFavorite(pokemon: pokemon));
                        },
                        child: state.pokemonList.contains(pokemon) 
                          ? const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ) 
                          : const Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                            ),
                      );
                    } else {
                      return Container();
                    }
                  }),
                )
              ],
            ),
            Text(
              pokemon.name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(
                          pokemon.typeofpokemon.length, 
                          (index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 0),
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 6),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(32)
                                ),
                                child: Text(
                                  pokemon.typeofpokemon[index],
                                  style: TextStyle(
                                    fontSize: 12, 
                                    color: AppUtils.toPokemonTypeColor(
                                      type: pokemon.typeofpokemon[index]
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                        ),
                      ),
                    ),
                    Hero(
                      tag: pokemon.id,
                      child: CachedNetworkImage(
                        height: 70, 
                        width: 70,
                        imageUrl:pokemon.imageurl,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}