import 'package:flutter/material.dart';

import '../../models/option.dart';

class TextProvider extends ChangeNotifier {
  List<Option> options = Option.list;
  Option _selectedOption = Option.selectedOption;
  String guestName = 'me';
  String dateTime = '0';

  Option get selectedOption => _selectedOption;

  changeOption(Option option,{String guest = 'me'}) {
    _selectedOption = option;
    guestName = guest;
    notifyListeners();
  }

  changeTime({String time = '0'}) {
    dateTime = time;
    notifyListeners();
  }
}
