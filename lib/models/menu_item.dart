import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';

class MenuItem {
  final String title;
  final IconData iconData;

  const MenuItem({
    required this.title,
    required this.iconData,
  });

  static const home = MenuItem(title: 'home', iconData: Ionicons.home_outline);
  static const rides =
  MenuItem(title: 'rides', iconData: Icons.receipt_long_outlined);
  static const wallet =
  MenuItem(title: 'wallet', iconData: Ionicons.wallet_outline);
  static const bookings = MenuItem(
      title: 'bookings', iconData: MaterialCommunityIcons.account_check_outline);
  static const account = MenuItem(
    title: 'account',
    iconData: FontAwesome.user_o,
  );

  static const all = <MenuItem>[home, rides, wallet, bookings, account];
}
