import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/blocs/pokemon/pokemon_bloc.dart';


class FilterButton extends StatelessWidget {
  const FilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonBloc,PokemonBlocState>(
      builder: (context,state) {
        bool isFilter = false;
        if(state is PokemonBlocSuccessState) {
          isFilter = state.isFilterFav;
        }
        return GestureDetector(
        onTap: () {
          _showBottomSheet(context);
        },
        child:  Icon(
           Icons.filter_list,
           color: isFilter ? Colors.green : Colors.black,
          ),
        );
      },
    );
  }

  void _showBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: ((context) {     
        return SizedBox(
          height: 140,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Align(
                  child: Text(
                    "Filter",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                BlocBuilder<PokemonBloc,PokemonBlocState>(
                  builder: (context,state) {
                    bool isFilter = false;
                    if(state is PokemonBlocSuccessState) {
                      isFilter = state.isFilterFav;
                    }
                    return GestureDetector(
                      onTap: () {
                        if(state is PokemonBlocSuccessState) {
                          final filterFavBloc = context.read<PokemonBloc>();
                          filterFavBloc.add(FilterFavPokemonEvent());
                          Navigator.pop(context);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isFilter? Colors.green : Colors.grey[200],
                          borderRadius: BorderRadius.circular(16)
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Favorite",
                              style: TextStyle(
                                color: isFilter 
                                    ? Colors.white 
                                    : Colors.black
                              ),
                            ),
                            if(isFilter) const Icon(
                              Icons.check,
                              color: Colors.white,
                            ),
                          ],
                        )
                      ),
                    );
                  },
                )
              ],
            ),
          )
        );
      }
    ),
  );
  }
}