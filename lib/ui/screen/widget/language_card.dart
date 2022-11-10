import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/blocs/locale/locale_cubit.dart';

class LanguageCard extends StatelessWidget {
  final Map data;
  const LanguageCard({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, ChangeLocaleState>(
      builder: (context,state) {
        final stateLangCode = state.locale.languageCode;
        final titleString = data["title"];
        return  GestureDetector(
          onTap: () {
            final localCube = context.read<LocaleCubit>();
            localCube.changeLocale(data["value"]);
            Navigator.pop(context);
          },
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: stateLangCode == data["value"]
                ? ListTile(
                    title: Text(
                      titleString.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    trailing: Icon(
                      Icons.check,
                      color: Colors.blue[900]!,
                    ),
                  )
                : ListTile(
                  title: Text(
                    titleString.toUpperCase(),
                    style: const TextStyle(
                        fontSize: 14
                      ),
                    ),
                  ),
          ),
        );
      }
    );
  }
}