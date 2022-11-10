// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/blocs/search_pokemon/search_pokemon_bloc.dart';
import 'package:pokemon_app/ui/screen/home_detail_screen.dart';


class PokemonSearchDelegate extends SearchDelegate {
  final Bloc<SearchPokemonEvent, SearchPokemonState> pokemonBloc;
  PokemonSearchDelegate({required this.pokemonBloc});
  
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      Padding(
        padding: const EdgeInsets.only(right: 8, bottom: 0),
        child: IconButton(
          icon: const Icon(
            Icons.clear,
            // color: Colors.black,
          ),
          onPressed: () {
            query = '';
            pokemonBloc.add(SearchPokemon(queryText: query));
          },
        ),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        },
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    pokemonBloc.add(SearchPokemon(queryText: query));
    return BlocBuilder<SearchPokemonBloc,SearchPokemonState>(
      builder: (context,state) {
        if(state is SearchPokemonLoading) {
          return const Center(
            child: CircularProgressIndicator(
              // color: Colors.black,
            ),
          );
        }

        if(state is SearchPokemonNotFound) {
          return Center(
            child: Text(
              state.notFoundMsg,
              textAlign: TextAlign.center,
            ),
          );
        }

        if(state is SearchPokemonLoaded) {
          return ListView.builder(
            itemCount: state.pokemonResult.length,
            itemBuilder: (context, index) {
              final pokemon = state.pokemonResult[index];
              return GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return HomeDetailScreen(pokemon: pokemon);
                  }));
                },
                child: Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        radius: 24, 
                        backgroundColor: Colors.transparent, 
                        backgroundImage: NetworkImage(pokemon.imageurl),
                      ),
                      title: Text(
                        pokemon.name,
                        style: const TextStyle(fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Divider(),
                  ],
                ),
              );
            });
        }
        return Container();
      }
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
