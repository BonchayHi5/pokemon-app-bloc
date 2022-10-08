// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/blocs/pokemon/pokemon_bloc.dart';


class SearchBar extends StatelessWidget {
  final double? width;
  final String hintText;
  final Color? searchBarColor;
  const SearchBar({Key? key, this.width, required this.hintText, this.searchBarColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
    return BlocBuilder<PokemonBloc,PokemonBlocState>(
      builder: (context,state) {
        return Padding(
        padding: const EdgeInsets.only(bottom: 16,top: 16),
        child: Container(
          height: 48,
          width: width ?? double.infinity,
          decoration: BoxDecoration(
            color: searchBarColor ?? Colors.blueGrey[50],
            border: Border.all(width: 0.5,color: searchBarColor ?? Colors.white60),
            borderRadius: BorderRadius.circular(16),
          ),
          child: TextField(
            cursorColor: Colors.black,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(4),  
              isDense: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.black),
              ),
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.grey),
              prefixIcon: Icon(Icons.search,color: Colors.grey[700]!),
            ),
            onChanged: (v) {
              context.read<PokemonBloc>().add(SearchPokemonEvent(queryText: v));
            },
          ),
        ),
      );
      }
    );
  }
}
