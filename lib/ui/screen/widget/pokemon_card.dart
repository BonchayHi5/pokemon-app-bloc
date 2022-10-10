import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
          color: AppUtils.toPokemonTypeColor(pokemon.typeofpokemon.first.toLowerCase()),
          borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Text(pokemon.id,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w700)),
            ),
            Text(pokemon.name,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w600)),
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
                        children: List.generate(pokemon.typeofpokemon.length, (index) => Padding(
                          padding: const EdgeInsets.only(bottom: 0),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 6),
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(32)
                            ),
                            child: Text(
                                pokemon.typeofpokemon[index],
                                style: TextStyle(fontSize: 12, color: AppUtils.toPokemonTypeColor(pokemon.typeofpokemon[index].toLowerCase())
                              ),
                            ),
                          ),
                        )),
                      ),
                    ),
                    Hero(
                      tag: pokemon.id,
                      child: CachedNetworkImage(imageUrl:pokemon.imageurl,height: 70, width: 70),
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