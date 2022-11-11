import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/blocs/pokemon/pokemon_bloc.dart';
import 'package:pokemon_app/blocs/theme/theme_cubit.dart';
import 'package:pokemon_app/blocs/search_pokemon/search_pokemon_bloc.dart';
import 'package:pokemon_app/service/app_localizations.dart';
import 'package:pokemon_app/ui/screen/widget/all_poke_tab.dart';
import 'package:pokemon_app/ui/screen/widget/favorite_poke_tab.dart';
import 'package:pokemon_app/ui/screen/widget/filter_button.dart';
import 'package:pokemon_app/ui/screen/widget/language_card.dart';
import 'package:pokemon_app/ui/theme/theme.dart';
import 'package:pokemon_app/ui/screen/widget/search_delegate.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(child: Text("all".tr(context))),
              Tab(child: Text("favorite".tr(context)))
            ],
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          centerTitle: false,
          leadingWidth: 180,
          leading: Padding(
            padding: const EdgeInsets.only(left: 16), 
            child: Image.asset("assets/pokemon-logo.png"),
          ),
          actions: [
            const FilterButton(),
            BlocProvider.value(
              value: BlocProvider.of<PokemonBloc>(context),
              child: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  final state = context.read<PokemonBloc>().state;
                  if(state is PokemonBlocSuccessState) {
                    showSearch(
                      context: context,
                      delegate: PokemonSearchDelegate(
                        pokemonBloc: BlocProvider.of<SearchPokemonBloc>(context),
                        pokemonList: state.pokemonList,
                      )
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: IconButton(
                icon: const Icon(Icons.language),
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: ((context) {
                        List<Map> suppLocale = [
                          {
                            "title" : "English",
                            "value": "en"
                          },
                          {
                            "title" : "Khmer",
                            "value": "km"
                          }
                        ];
                        return Wrap(
                          children: List.generate(
                            suppLocale.length,
                            (index) {
                              return LanguageCard(
                                data: suppLocale[index],
                              );
                            }
                          ),
                        );
                      }
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: BlocBuilder<ThemeCubit, ThemeData>(
          builder: (context, state) {
            return FloatingActionButton(
              onPressed: () {
                context.read<ThemeCubit>().onChangeTheme();
              },
              child: Icon(state == AppTheme.lightTheme
                  ? Icons.sunny
                  : Icons.brightness_2
                )
            );
          },
        ),
        body: const TabBarView(
          children: [
            AllPokeTab(),
            FilterPokeTab(),
          ]
        ),
      ),
    );
  }
}

