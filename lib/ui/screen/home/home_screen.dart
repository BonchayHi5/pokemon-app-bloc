import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/bloc/pokemon_bloc.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PokemonBloc()..add(FetchPokemonEvent()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: const Text("Pokemon App",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800),),
        ),
        
        body: BlocBuilder<PokemonBloc, PokemonState>(
          builder: (context, state) {
            if (state is PokemonLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is PokemonErrorState) {
              return Center(
                child: Text(
                  state.errorMessage,
                ),
              );
            }

            if (state is PokemonSuccessState) {
              return ListView.builder(
                itemCount: state.pokemonList.length,
                itemExtent: 66,
                itemBuilder: (context, index) {
                  final pokemon = state.pokemonList[index];
                  return ListTile(
                    contentPadding: const EdgeInsets.only(left: 16),
                    tileColor: Colors.white,
                    leading: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: Image.network(
                        pokemon.imageurl,
                      ),
                    ),
                    title: Text(pokemon.name),
                    subtitle: Text(pokemon.category),
                  );
                },
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget customIconShape(IconData icon) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Icon(icon),
    );
  }
}