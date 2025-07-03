import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../utils/constants.dart';
import '../../utils/languages/constants.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              errorInternetImage,
              width: 100,
              height: 100,
            ),
            Text(
              "${getTranslated(context, 'check_internet')}",
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
