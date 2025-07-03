import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../../../main.dart';
import '../../../models/menu_item.dart';
import '../../../utils/languages/constants.dart';
import '../../../utils/languages/models.dart';
import '../dialogs.dart';

class MenuIcon extends StatelessWidget {
  final Color? color;

  const MenuIcon({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'floating_location',
      mini: true,
      onPressed: () => ZoomDrawer.of(context)!.toggle(),
      child: Icon(Icons.menu, color: color),
    );
  }
}

class MenuWidget extends StatefulWidget {
  final MenuItem currentItem;
  final ValueChanged<MenuItem> onSelectedItem;

  const MenuWidget({
    super.key,
    required this.currentItem,
    required this.onSelectedItem,
  });

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  Language selectedLang = Language.languageList[0];

  @override
  Widget build(BuildContext context) {
    getLocale().then(
      (locale) => {
        setState(() {
          selectedLang = Language.languageList.firstWhere(
            (element) => element.languageCode == locale.languageCode,
          );
        }),
      },
    );
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LanguagePopMenu(
                selected: selectedLang,
                myLists: Language.languageList,
                onChanged: (Language? value) {
                  _changeLanguage(value!);
                },
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 40,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        MaterialCommunityIcons.account_circle,
                        size: 40,
                      ),
                      Text("Alec Doe"),
                    ],
                  ),
                ),
              ),
              buildItems(context, list: MenuItem.all),
              const Spacer(),
              buildSignOut(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildItems(BuildContext context, {required List<MenuItem> list}) {
    return Wrap(runSpacing: 16, children: list.map(buildMenuItem).toList());
  }

  Widget buildMenuItem(MenuItem item) => ListTile(
    selectedTileColor: Colors.white12,
    selected: widget.currentItem == item,
    selectedColor: Colors.white,
    leading: Icon(item.iconData),
    title: Text("${getTranslated(context, item.title)}"),
    onTap: () => widget.onSelectedItem(item),
  );

  _changeLanguage(Language language) async {
    Locale temp = await setLocale(language.languageCode);
    if (!mounted) return;
    MyApp.setLocale(context, temp);
  }

  buildSignOut() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: OutlinedButton.icon(
        onPressed: () {
          //SIGN OUT ACTION
        },
        style: OutlinedButton.styleFrom(
          shape: const StadiumBorder(),
          side: const BorderSide(width: 1, color: Colors.white),
        ),
        icon: const Icon(Icons.lock_outline, color: Colors.white),
        label: Text(
          getTranslated(context, "sign_out")!.toUpperCase(),
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
