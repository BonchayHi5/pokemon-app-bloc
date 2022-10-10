import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/blocs/filter_favorite/filter_favorite_bloc.dart';
import 'package:pokemon_app/blocs/locale/locale_cubit.dart';
import 'package:pokemon_app/blocs/theme/theme_cubit.dart';
import 'package:pokemon_app/blocs/pokemon/pokemon_bloc.dart';
import 'package:pokemon_app/blocs/search_pokemon/search_pokemon_bloc.dart';
import 'package:pokemon_app/service/app_localizations.dart';
import 'package:pokemon_app/ui/screen/widget/all_poke_tab.dart';
import 'package:pokemon_app/ui/screen/widget/favorite_poke_tab.dart';
import 'package:pokemon_app/ui/theme/theme.dart';
import 'package:pokemon_app/ui/screen/widget/search_delegate.dart';
import 'package:pokemon_app/ui/screen/widget/pokemon_card.dart';

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
          leading: Padding(padding: const EdgeInsets.only(left: 16), child: Image.asset("assets/pokemon-logo.png")),
          actions: [
            IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: PokemonSearchDelegate(pokemonBloc: BlocProvider.of<SearchPokemonBloc>(context))
                  );
                }),
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
                        return BlocBuilder<LocaleCubit, ChangeLocaleState>(
                          builder: (context, state) {
                            return Wrap(
                              children: List.generate(suppLocale.length,(index) => GestureDetector(
                                  onTap: () {
                                    context.read<LocaleCubit>().changeLocale(suppLocale[index]["value"]);
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    child: state.locale.languageCode == suppLocale[index]["value"]
                                        ? ListTile(
                                            title: Text(suppLocale[index]["title"].toUpperCase(),style: const TextStyle(fontSize: 14)),
                                            trailing: Icon(Icons.check,color: Colors.blue[900]!),
                                          )
                                        : ListTile(title: Text(suppLocale[index]["title"].toUpperCase(),style: const TextStyle(fontSize: 14))),
                                  ),
                                ),
                              ),
                            );
                          },
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
                  : Icons.brightness_2),
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

