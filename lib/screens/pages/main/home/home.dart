import 'package:flutter/material.dart';

import '../../../widgets/home/bottom/bottom.dart';
import '../../../widgets/home/map.dart';
import '../../../widgets/home/menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          HomeMap(),
          Positioned(
            top: 50,
            left: 20,
            child: const MenuIcon(color: Colors.white),
          ),
          Positioned(
            bottom: 30,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.95,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                border: Border.all(color: Colors.black12),
              ),
              child: BottomStateWidget(),
            ),
          ),
        ],
      ),
    );
  }
}
