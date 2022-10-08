import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/blocs/pokemon/pokemon_bloc.dart';
import 'package:pokemon_app/ui/widget/pokemon_card.dart';
import 'package:pokemon_app/ui/widget/search_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PokemonBloc()..add(FetchPokemonEvent()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          centerTitle: false,
          title: const Text("Pokemon App",style:TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
        ),
        body: BlocBuilder<PokemonBloc, PokemonBlocState>(
          builder: (context, state) {
            if (state is PokemonBlocLoadingState) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              );
            }
            if (state is PokemonBlocErrorState) {
              return Center(
                child: Text(
                  state.errorMsg,
                  textAlign: TextAlign.center,
                ),
              );
            }
            if (state is PokemonBlocSuccessState) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SearchBar(hintText: "Search for a Pokemon"),
                    Expanded(
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
                    ),
                  ],
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
