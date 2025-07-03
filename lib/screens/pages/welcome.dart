import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../../utils/constants.dart';
import '../../utils/enumerations.dart';
import '../../utils/languages/constants.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Lottie.asset(
            welcomeImage,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.6,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "${getTranslated(context, 'welcome_duma')}",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "${getTranslated(context, 'welcome_description')}",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                    letterSpacing: 1,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      context.go("/${RouterPath.welcome}/${RouterPath.signIn}");
                    },
                    child: Text(
                      "${getTranslated(context, 'sign_in')}".toUpperCase(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      context.go("/${RouterPath.welcome}/${RouterPath.signUp}");
                    },
                    child: Text(
                      "${getTranslated(context, 'sign_up')}".toUpperCase(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
