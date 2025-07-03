import 'package:flutter/material.dart';


class SplashWidget extends StatefulWidget {
  const SplashWidget({super.key});

  @override
  State<SplashWidget> createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      children: [
        Positioned(
          width: size.width * 0.4,
          height: size.height * 0.4,
          child: Image.asset(
            "APP IMAGE",
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 1600),
          bottom: 20,
          child: Column(
            children: [
              Image.asset(
                "APP IMAGE",
                width: 45,
                height: 45,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
