import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/blocs/pokemon/pokemon_bloc.dart';
import 'package:pokemon_app/blocs/search_pokemon/search_pokemon_bloc.dart';
import 'package:pokemon_app/ui/screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PokemonBloc>(
          create: (BuildContext context) => PokemonBloc()..add(FetchPokemonEvent()),
        ),
        BlocProvider<SearchPokemonBloc>(
          create: (BuildContext context) => SearchPokemonBloc(),
        ),
      ],
      child: const MaterialApp(
        title: 'Pokemon App',
        home: HomeScreen(),
      ),
    );
  }
}
