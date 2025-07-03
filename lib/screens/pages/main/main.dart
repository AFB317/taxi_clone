import 'package:duma_taxi/screens/pages/main/bookings.dart';
import 'package:duma_taxi/screens/pages/main/rides.dart';
import 'package:duma_taxi/screens/pages/main/wallet.dart';
import 'package:duma_taxi/screens/widgets/home/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';

import '../../../models/menu_item.dart';
import '../../../utils/constants.dart';
import '../../../utils/providers/connected.dart';
import 'account.dart';
import 'home/home.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with WidgetsBindingObserver {
  MenuItem currentItem = MenuItem.home;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    //_checkVersion();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<ConnectedProvider>(context, listen: false).getData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: ZoomDrawer(
        closeCurve: Curves.bounceIn,
        style: DrawerStyle.defaultStyle,
        borderRadius: 24,
        openCurve: Curves.fastOutSlowIn,
        angle: 0.0,
        menuBackgroundColor: Theme.of(context).colorScheme.secondary,
        slideWidth: MediaQuery.of(context).size.width * 0.8,
        menuScreen: Builder(
          builder: (context) => MenuWidget(
              currentItem: currentItem,
              onSelectedItem: (item) {
                setState(() => currentItem = item);
                ZoomDrawer.of(context)!.close();
              }),
        ),
        mainScreen: getPage(),
        mainScreenTapClose: true,
      ),
    );
  }

  Widget getPage() {
    switch (currentItem) {
      case MenuItem.home:
        return const HomePage();
      case MenuItem.rides:
        return const RidesPage();
      case MenuItem.wallet:
        return const WalletPage(
          fromMenu: true,
        );
      case MenuItem.bookings:
        return const BookingsPage();
      case MenuItem.account:
        return const AccountPage();
      default:
        return const HomePage();
    }
  }

  /*_checkVersion() async {
    final newVersion = NewVersionPlus(iOSId: appId, androidId: appId);
    final status = await newVersion.getVersionStatus();
    if (status!.canUpdate) {
      if (mounted) {
        newVersion.showUpdateDialog(
          context: context,
          versionStatus: status,
          allowDismissal: false,
        );
      }
    }
  }*/
}
