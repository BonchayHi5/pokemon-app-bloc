import 'package:flutter/material.dart';

extension PokemonTypeExtension on String {
  
}
class AppUtils {
  
  static Color convertHexaColor(String colorhexcode) {
    /* Convert Hexa Color */
    String colornew = '0xFF$colorhexcode';
    colornew = colornew.replaceAll('#', '');
    final colorint = int.parse(colornew);
    return Color(colorint);
  }

  static Color toPokemonTypeColor({required String type}) {
    switch (type.toLowerCase()) {
      case 'normal':
        return AppUtils.convertHexaColor('#A8A77A');
      case 'fire':
        return AppUtils.convertHexaColor('#EE8130');
      case 'water':
        return AppUtils.convertHexaColor('#6390F0');
      case 'electric':
        return AppUtils.convertHexaColor('#EE8130');
      case 'grass':
        return AppUtils.convertHexaColor('#7AC74C');
      case 'ice':
        return AppUtils.convertHexaColor('#96D9D6');
      case 'fighting':
        return AppUtils.convertHexaColor('#C22E28');
      case 'poison':
        return AppUtils.convertHexaColor('#A33EA1');
      case 'ground':
        return AppUtils.convertHexaColor('#E2BF65');
      case 'flying':
        return AppUtils.convertHexaColor('#A98FF3');
      case 'psychic':
        return AppUtils.convertHexaColor('#F95587');
      case 'bug':
        return AppUtils.convertHexaColor('#A6B91A');
      case 'rock':
        return AppUtils.convertHexaColor('#B6A136');
      case 'ghost':
        return AppUtils.convertHexaColor('#735797');
      case 'dragon':
        return AppUtils.convertHexaColor('#6F35FC');
      case 'dark':
        return AppUtils.convertHexaColor('#705746');
      case 'steel':
        return AppUtils.convertHexaColor('#B7B7CE');
      case 'fairy':
        return AppUtils.convertHexaColor('#D685AD');
    }
    return Colors.black;
  }

}
