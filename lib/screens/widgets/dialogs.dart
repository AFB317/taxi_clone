import 'package:flutter/material.dart';

import '../../main.dart';
import '../../utils/constants.dart';
import '../../utils/languages/constants.dart';
import '../../utils/languages/models.dart';
import '../../utils/preferences.dart';

languageDialog(
    BuildContext buildContext,
    List languages,
    ) {
  showDialog(
    context: buildContext,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        titlePadding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
        elevation: 5.0,
        titleTextStyle:
        const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        title: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(15),
              topLeft: Radius.circular(15),
            ),
            color: Theme.of(buildContext).primaryColor,
          ),
          width: MediaQuery.of(buildContext).size.width,
          padding: const EdgeInsets.all(10),
          child: Text(
            "${getTranslated(buildContext, 'choose_language')}".toUpperCase(),
            textAlign: TextAlign.center,
          ),
        ),
        content: SizedBox(
          width: MediaQuery.of(buildContext).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListView.builder(
                primary: true,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: languages.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      Locale temp =
                      await setLocale(languages[index].languageCode);
                      if (context.mounted) {
                        MyApp.setLocale(context, temp);
                        PreferenceUtils.setPreference(langSet, true);
                        Navigator.pop(context);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                languages[index].flag,
                                style: const TextStyle(fontSize: 30),
                              ),
                              Text(
                                languages[index].name,
                                style: const TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}

class LanguagePopMenu extends StatelessWidget {
  final ValueChanged<Language?> onChanged;
  final List<Language> myLists;
  final Language selected;

  const LanguagePopMenu(
      {super.key,
        required this.onChanged,
        required this.myLists,
        required this.selected});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Language>(
      onSelected: onChanged,
      shape: Border.all(color: Colors.white70, width: 0.5),
      color: Theme.of(context).primaryColorDark,
      itemBuilder: (BuildContext context) {
        return myLists.map((listItem) {
          return PopupMenuItem<Language>(
            value: listItem,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  listItem.flag,
                  style: const TextStyle(fontSize: 30),
                ),
                const SizedBox(width: 10),
                Text(
                  listItem.name,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          );
        }).toList();
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: 10),
          Text(
            selected.flag,
            style: const TextStyle(fontSize: 25),
          ),
          const SizedBox(width: 10),
          Text(
            selected.name.substring(0, 2).toUpperCase(),
          ),
        ],
      ),
    );
  }
}
