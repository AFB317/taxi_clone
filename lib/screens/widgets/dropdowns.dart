import 'package:flutter/material.dart';

import '../../models/country.dart';
import '../../utils/functions.dart';

class CountryDropDown extends StatelessWidget {
  final ValueChanged<Country?> onChanged;
  final List<Country> countries;
  final Country selectedCountry;

  const CountryDropDown({
    super.key,
    required this.countries,
    required this.selectedCountry,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<Country>(
        value: selectedCountry,
        items: buildDropDownMenuItems(countries),
        onChanged: onChanged,
        selectedItemBuilder: (BuildContext context) {
          return selectedDropDownWidget(countries);
        },
      ),
    );
  }

  List<DropdownMenuItem<Country>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<Country>> items = [];
    for (Country listItem in listItems) {
      items.add(
        DropdownMenuItem(
          value: listItem,
          child: ListTile(
            leading: Text(
              countryFlag("${listItem.code}"),
              style: const TextStyle(fontSize: 20),
            ),
            minLeadingWidth: 3,
            contentPadding: EdgeInsets.zero,
            titleTextStyle: const TextStyle(fontSize: 12, color: Colors.black),
            subtitleTextStyle: const TextStyle(
              fontSize: 12,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            title: Text(
              "${listItem.name}",
              maxLines: 2,
            ),
            subtitle: Text(
              "${listItem.prefix}",
            ),
            dense: true,
          ),
        ),
      );
    }
    return items;
  }

  List<DropdownMenuItem<Country>> selectedDropDownWidget(List listItems) {
    List<DropdownMenuItem<Country>> items = [];
    for (Country listItem in listItems) {
      items.add(
        DropdownMenuItem(
          value: listItem,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Row(
              children: [
                Text(
                  countryFlag("${listItem.code}"),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 30),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "${listItem.prefix}",
                  textAlign: TextAlign.center,
                  //style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return items;
  }
}
