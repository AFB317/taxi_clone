import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';

class Option {
  dynamic id;
  String title;
  IconData icon;
  String value;

  Option({
    required this.id,
    required this.title,
    required this.icon,
    required this.value,
  });

  static List<Option> list = [
    Option(id: 1, title: "me", icon: Entypo.user,value: "0"),
    Option(id: 2, title: "someone", icon: Entypo.users,value: "1"),
  ];
  static Option selectedOption = list[0];
}