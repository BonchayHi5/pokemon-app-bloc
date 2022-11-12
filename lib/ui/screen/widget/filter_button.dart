import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/blocs/pokemon/pokemon_bloc.dart';
import 'package:pokemon_app/utils/app_utils.dart';


class FilterButton extends StatelessWidget {
  const FilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonBloc,PokemonBlocState>(
      builder: (context,state) {    
        return GestureDetector(
        onTap: () {
          _showBottomSheet(context);
        },
        child:  const Icon(
           Icons.filter_list,
           color: Colors.black,
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
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<PokemonBloc,PokemonBlocState>(
                  builder: (context,state) {
                    if(state is PokemonBlocSuccessState) {
                      return Column(
                        children: [
                          const Align(
                          child: Text(
                            "Filter Options",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                           Wrap(
                            children: List.generate(state.allType.length, (index) {
                              return GestureDetector(
                                onTap: () {
                                  if(!state.filterTypes.contains(state.allType[index].toLowerCase())) {
                                    context.read<PokemonBloc>().add(AddFilterPokeTypeEvent(state.allType[index]));
                                  }
                                },
                                child: Padding(
                                    padding: const EdgeInsets.only(bottom: 0),
                                    child: Container(
                                      margin: const EdgeInsets.only(bottom: 6,right: 8),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 14,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppUtils.toPokemonTypeColor(
                                            type: state.allType[index]
                                          ),
                                        borderRadius: BorderRadius.circular(32)
                                      ),
                                      child: Text(
                                        state.allType[index].toUpperCase(),
                                        style: const TextStyle(
                                          fontSize: 12, 
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                              );
                              } 
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Align(
                            child: Text(
                              "Filtered Options",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          if(state.filterTypes.isNotEmpty)
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {
                                context.read<PokemonBloc>().add(ClearFilterPokemonByTypeEvent());
                              },
                              child: const Text(
                                "Clear",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            children: List.generate(state.filterTypes.length, (index) {
                              return Padding(
                                  padding: const EdgeInsets.only(bottom: 0),
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 6,right: 8),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppUtils.toPokemonTypeColor(
                                          type: state.filterTypes[index]
                                        ),
                                      borderRadius: BorderRadius.circular(32)
                                    ),
                                    child: Text(
                                      state.filterTypes[index].toUpperCase(),
                                      style: const TextStyle(
                                        fontSize: 12, 
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                );
                              } 
                            ),
                          ),
                        ],
                      );
                    }
                    return Container();
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