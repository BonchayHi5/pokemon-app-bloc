import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/blocs/pokemon/pokemon_bloc.dart';
import 'package:pokemon_app/ui/screen/widget/pokemon_card.dart';

class AllPokeTab extends StatelessWidget {
  const AllPokeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonBloc, PokemonBlocState>(
      builder: (context, state) {
        if (state is PokemonBlocLoadingState) {
          return Center(
            child: CircularProgressIndicator(color: Colors.blue[900]!),
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
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.2,
                ),
                itemCount: state.filterTypes.isNotEmpty
                    ? state.filterPokemonList.length
                    : state.pokemonList.length,
                itemBuilder: (BuildContext ctx, index) {
                  final pokemon = state.filterTypes.isEmpty ? state.pokemonList[index] : state.filterPokemonList[index];
                  return PokemonCard(pokemon: pokemon);
                }),
          );
        }
        return Container();
      },
    );
  }
}
