
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:pokemon_app/model/pokemon_model.dart';
import 'package:pokemon_app/service/api_services.dart';

part 'pokemon_bloc_event.dart';
part 'pokemon_bloc_state.dart';

class PokemonBloc extends Bloc<PokemonBlocEvent, PokemonBlocState> {
  PokemonBloc() : super(PokemonBlocInitialState()) {
    on<FetchPokemonEvent>(_onFetchPoke);
    on<AddFilterPokeTypeEvent>(_onAddFilterPokeType);
    on<ClearFilterPokemonByTypeEvent>(_onClearFilterPokeByType);
  }

  void _onFetchPoke(event, emit) async {
    emit(PokemonBlocLoadingState());
    try {
      List<String> allType = [];
      final pokemonList = await ApiService.fetchPokemonList();
      for(var i in pokemonList) {
        for (var element in i.typeofpokemon) {
          if(!allType.contains(element)){
            allType.add(element);
          }
        }
      }
      emit(
        PokemonBlocSuccessState(
          filterTypes: const [],
          pokemonList: pokemonList,
          allType: allType,
          filterPokemonList: const [],
        ),
      );
    } catch (e) {
      emit(PokemonBlocErrorState(errorMsg: e.toString()));
    }
    FlutterNativeSplash.remove();
  }

  void _onAddFilterPokeType(event, emit) async {
    final state = this.state;
    if(state is PokemonBlocSuccessState) {   
      List<String> filterTypes = [];       
      ///add new filterType  
      if(!state.filterTypes.contains(event.pokemonType.toString().toLowerCase())) {
        filterTypes = List.from(state.filterTypes)..add(event.pokemonType.toString().toLowerCase());
      }
      emit(PokemonBlocLoadingState());
      emit(
        PokemonBlocSuccessState( 
          filterTypes: filterTypes.isEmpty ? state.filterTypes : filterTypes,  
          pokemonList: state.pokemonList,
          allType: state.allType,
          filterPokemonList: _getfilterPokeList(filterTypes, state.pokemonList)
        ),
      );
    }
  }


  List<PokemonModel> _getfilterPokeList(List<String> filterTypes,List<PokemonModel> pokemonList) {
    List<PokemonModel> filterPokemonList = []; 
    if(filterTypes.isNotEmpty) {
      for(var poke in pokemonList) {
        final item = poke.typeofpokemon.firstWhere((element) => filterTypes.contains(element.toLowerCase()),orElse: ()=> "");
        if(item!="") {
          filterPokemonList.add(poke);
        }
      }
    } else {

    }
    return filterPokemonList;

  }

 

  void _onClearFilterPokeByType(event, emit) async {
    final state = this.state;
    if(state is PokemonBlocSuccessState) {
      if(state.filterPokemonList.isNotEmpty) {
        state.filterPokemonList.clear();
      }
      emit(PokemonBlocLoadingState());
      emit(
        PokemonBlocSuccessState( 
          filterTypes: const [],  
          pokemonList: state.pokemonList,
          allType: state.allType,
          filterPokemonList: List.from(state.filterPokemonList)
        ),
      );
    }
  }



  void _onUpdatePoke(event, emit) async {
    // final state = this.state;
    // if(state is PokemonBlocSuccessState) {
    //   final initialList = state.pokemonList;
    //   final poke = initialList.firstWhere((element) => element.id == event.pokemon.id);
    //   poke.isFav = !poke.isFav;
    //   if(!state.isFilterFav) {
    //     emit(PokemonBlocLoadingState());
    //     emit(
    //       PokemonBlocSuccessState(
    //         isFilterFav: state.isFilterFav,
    //         pokemonList: initialList,
    //         allType: state.allType,
    //         filterPokemonList: const []
    //       ),
    //     );
    //   }
    // }
  }
  
  // void _onFilterFavPokeClicked(event, emit) async {
  //   // final state = this.state;
  //   // if(state is PokemonBlocSuccessState) {
  //   //   final initialList = state.pokemonList;
  //   //   final filterPokeList = getFavPokeList(initialList);
  //   //   state.isFilterFav = !state.isFilterFav;
  //   //   emit(PokemonBlocLoadingState());
  //   //   emit(
  //   //     PokemonBlocSuccessState(
  //   //       isFilterFav: state.isFilterFav, 
  //   //       pokemonList: initialList,
  //   //       allType: state.allType,
  //   //       filterPokemonList: filterPokeList
  //   //     ),
  //   //   );
  //   // }
  // }

  // void _onFilterFavPoke(event, emit) async {
  //   final state = this.state;
  //   if(state is PokemonBlocSuccessState) {
  //     final initialList = state.pokemonList;
  //     final filterPokeList = getFavPokeList(initialList);
  //     emit(PokemonBlocLoadingState());
  //     emit(
  //       PokemonBlocSuccessState(
  //         filterType: const [],
  //         pokemonList: initialList,
  //         allType: state.allType,
  //         filterPokemonList: filterPokeList
  //       ),
  //     );
  //   }
  // }

  List<PokemonModel> getFavPokeList(List<PokemonModel> initialList) {
    return initialList.where((element) => element.isFav).toList();
  }

}
