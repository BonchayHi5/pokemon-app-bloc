import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/blocs/cubit/theme_cubit.dart';
import 'package:pokemon_app/blocs/pokemon/pokemon_bloc.dart';
import 'package:pokemon_app/blocs/search_pokemon/search_pokemon_bloc.dart';
import 'package:pokemon_app/ui/theme/theme.dart';
import 'package:pokemon_app/ui/widget/search_delegate.dart';
import 'package:pokemon_app/ui/widget/pokemon_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: false,
        leadingWidth: 180,
        leading: Padding(padding: const EdgeInsets.only(left: 16), child: Image.asset("assets/pokemon-logo.png")),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: PokemonSearchDelegate(pokemonBloc: BlocProvider.of<SearchPokemonBloc>(context)),
                  );
                },
                icon: const Icon(Icons.search)),
          )
        ],
      ),
      floatingActionButton: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, state) {
          return FloatingActionButton(
            onPressed: () {
              context.read<ThemeCubit>().onChangeTheme();
            },
            child: Icon(state == AppTheme.lightTheme ? Icons.sunny : Icons.brightness_2),
          );
        },
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
        },
      ),
    );
  }
}
