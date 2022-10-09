import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:pokemon_app/blocs/cubit/theme_cubit.dart';
import 'package:pokemon_app/blocs/pokemon/pokemon_bloc.dart';
import 'package:pokemon_app/blocs/search_pokemon/search_pokemon_bloc.dart';
import 'package:pokemon_app/ui/screen/home_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PokemonBloc>(create: (BuildContext context) => PokemonBloc()..add(FetchPokemonEvent())),
        BlocProvider<SearchPokemonBloc>(create: (BuildContext context) => SearchPokemonBloc()),
        BlocProvider<ThemeCubit>(create: (BuildContext context) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit,ThemeData>(
        builder: (context,state) {
          return MaterialApp(
            title: 'Pokemon App',
            theme: state,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}