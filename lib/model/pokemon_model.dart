import 'dart:convert';

	// - description
	//   		- height
	//   		- category
	//   		- weight
	//   		- typeofpokemon
	//   		- speed
	//   		- hp
	//   		- attack
	//   		- defense

  // - Pokemon name
	// 		- Pokemon Image
	// 		- Pokemon Id
	// 		- Pokemon Type




// const colours = {
// 	normal: '#A8A77A',
// 	fire: '#EE8130',
// 	water: '#6390F0',
// 	electric: '#F7D02C',
// 	grass: '#7AC74C',
// 	ice: '#96D9D6',
// 	fighting: '#C22E28',
// 	poison: '#A33EA1',
// 	ground: '#E2BF65',
// 	flying: '#A98FF3',
// 	psychic: '#F95587',
// 	bug: '#A6B91A',
// 	rock: '#B6A136',
// 	ghost: '#735797',
// 	dragon: '#6F35FC',
// 	dark: '#705746',
// 	steel: '#B7B7CE',
// 	fairy: '#D685AD',
// };
// }


List<PokemonModel> pokemonListModelFromJson(String str) => List<PokemonModel>.from(json.decode(str).map((x) => PokemonModel.fromJson(x)));

String pokemonListModelToJson(List<PokemonModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PokemonModel {
    PokemonModel({
      required this.name,
      required this.id,
      required this.imageurl,
      required this.xdescription,
      required this.ydescription,
      required this.height,
      required this.category,
      required this.weight,
      required this.typeofpokemon,
      required this.hp,
      required this.attack,
      required this.defense,
      required this.speed,
        // this.isFav = false,
        this.weaknesses,
        this.evolutions,
        this.abilities,
        this.specialAttack,
        this.specialDefense,
        this.total,
        this.malePercentage,
        this.femalePercentage,
        this.genderless,
        this.cycles,
        this.eggGroups,
        this.evolvedfrom,
        this.reason,
        this.baseExp,
    });

    final String name;
    final String id;
    final String imageurl;
    final String xdescription;
    final String ydescription;
    final String height;
    final String category;
    final String weight;
    final List<String> typeofpokemon;
    final List<String>? weaknesses;
    final List<String>? evolutions;
    final List<String>? abilities;
    final int hp;
    final int attack;
    final int defense;
    final int? specialAttack;
    final int? specialDefense;
    final int speed;
    // bool isFav;
    final int? total;
    final String? malePercentage;
    final String? femalePercentage;
    final int? genderless;
    final String? cycles;
    final String? eggGroups;
    final String? evolvedfrom;
    final String? reason;
    final String? baseExp;

    factory PokemonModel.fromJson(Map<String, dynamic> json) => PokemonModel(
        name: json["name"],
        id: json["id"],
        imageurl: json["imageurl"],
        xdescription: json["xdescription"],
        ydescription: json["ydescription"],
        height: json["height"],
        category: json["category"],
        weight: json["weight"],
        typeofpokemon: List<String>.from(json["typeofpokemon"].map((x) => x)),
        weaknesses: List<String>.from(json["weaknesses"].map((x) => x)),
        evolutions: List<String>.from(json["evolutions"].map((x) => x)),
        abilities: List<String>.from(json["abilities"].map((x) => x)),
        hp: json["hp"],
        attack: json["attack"],
        defense: json["defense"],
        specialAttack: json["special_attack"],
        specialDefense: json["special_defense"],
        speed: json["speed"],
        total: json["total"],
        malePercentage: json["male_percentage"],
        femalePercentage:json["female_percentage"],
        genderless: json["genderless"],
        cycles: json["cycles"],
        eggGroups: json["egg_groups"],
        evolvedfrom: json["evolvedfrom"],
        reason: json["reason"],
        baseExp: json["base_exp"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "imageurl": imageurl,
        "xdescription": xdescription,
        "ydescription": ydescription,
        "height": height,
        "category": category,
        "weight": weight,
        "typeofpokemon": typeofpokemon == null ? null : List<dynamic>.from(typeofpokemon.map((x) => x)),
        "weaknesses": weaknesses == null ? null : List<dynamic>.from(weaknesses!.map((x) => x)),
        "evolutions": evolutions == null ? null : List<dynamic>.from(evolutions!.map((x) => x)),
        "abilities": abilities == null ? null : List<dynamic>.from(abilities!.map((x) => x)),
        "hp": hp,
        "attack": attack,
        "defense": defense,
        "special_attack": specialAttack,
        "special_defense": specialDefense,
        "speed": speed,
        "total": total,
        "male_percentage": malePercentage,
        "female_percentage": femalePercentage,
        "genderless": genderless,
        "cycles": cycles,
        "egg_groups": eggGroups,
        "evolvedfrom": evolvedfrom,
        "reason": reason,
        "base_exp": baseExp,
    };
}
