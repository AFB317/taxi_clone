import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/constants.dart';

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
            appImage,
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 1600),
          bottom: 20,
          child: Column(
            children: [
              Image.asset(
                afrImage,
                width: 45,
                height: 45,
              ),
              DefaultTextStyle(
                style: GoogleFonts.openSans(
                  textStyle: const TextStyle(
                    fontSize: 12.0,
                    letterSpacing: 1,
                    color: Colors.black,
                  ),
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    WavyAnimatedText(
                      "AFRIREGISTER S.A",
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    WavyAnimatedText('Always going the extra mile'),
                  ],
                  isRepeatingAnimation: true,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
