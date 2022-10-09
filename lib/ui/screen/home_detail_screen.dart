import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/blocs/pokemon/pokemon_bloc.dart';
import 'package:pokemon_app/model/pokemon_model.dart';
import 'package:pokemon_app/utils/app_utils.dart';

class HomeDetailScreen extends StatelessWidget {
  final PokemonModel pokemon;
  const HomeDetailScreen({super.key,required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppUtils.toPokemonTypeColor(pokemon.typeofpokemon.first.toLowerCase()),
      appBar: AppBar(
        backgroundColor: AppUtils.toPokemonTypeColor(pokemon.typeofpokemon.first.toLowerCase()),
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios_new,color: Colors.white),
        ),
        actions:  [
          BlocBuilder<PokemonBloc,PokemonBlocState>(
            builder: ((context, state){
              return Padding(
              padding: const EdgeInsets.only(right: 16), 
              child: GestureDetector(
                onTap: () {
                  context.read<PokemonBloc>().add(AddToFavEvent(pokemon: pokemon));
                },
                child: const Icon(Icons.favorite_border,color: Colors.white)));
            }),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                )
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 32),
                      const Text("Description",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600)),
                      const SizedBox(height: 16),
                      Text(pokemon.xdescription),
                      const SizedBox(height: 24),
                      textRow("Category", pokemon.category),
                      textRow("Height", pokemon.height),
                      textRow("Weight", pokemon.weight),
                      stateRow("Speed", pokemon.speed),
                      stateRow("HP", pokemon.hp),
                      stateRow("Attack", pokemon.attack),
                      stateRow("Defense", pokemon.defense),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 90,
            child: Hero(
              tag: pokemon.id,
              child: CachedNetworkImage(imageUrl: pokemon.imageurl,height: MediaQuery.of(context).size.height * 0.35),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(pokemon.name,style: const TextStyle(color: Colors.white,fontSize: 28,fontWeight: FontWeight.w800)),
                        const SizedBox(height: 16),
                        Row(
                          children: List.generate(pokemon.typeofpokemon.length, (index) => Padding(
                            padding: const EdgeInsets.only(right: 5),
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
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(pokemon.id,style: const TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.w700))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  textRow(String leadingText, String trailingText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Text(leadingText,style: TextStyle(color: Colors.grey[500],fontWeight: FontWeight.w600))),
            Expanded(child: Text(trailingText,style: const TextStyle(fontWeight: FontWeight.w600))),
            Expanded(child: Container())
          ],
        ),
      ),
    );
  }
  stateRow(String leadingText, int trailing) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Text(leadingText,style: TextStyle(color: Colors.grey[500],fontWeight: FontWeight.w600))),
            Expanded(child: Text(trailing.toString(),style: const TextStyle(fontWeight: FontWeight.w600))),
            Expanded(child: LinearProgressIndicator(value: double.parse(trailing.toString()),color:  double.parse(trailing.toString()) <50 ? Colors.red : Colors.greenAccent)),
          ],
        ),
      ),
    );
  }
  
}