import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../utils/constants.dart';

class LoadingPage extends StatelessWidget {
  final Widget child;
  final bool isAsync;

  const LoadingPage({
    super.key,
    required this.child,
    required this.isAsync,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> wigs = [];
    wigs.add(child);
    if (isAsync) {
      final modal = Stack(
        children: [
          Opacity(
            opacity: 0.5,
            child: ModalBarrier(
              dismissible: false,
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
          const LoadingContent(),
        ],
      );
      wigs.add(modal);
    }
    return Stack(
      children: wigs,
    );
  }
}

class LoadingContent extends StatelessWidget {
  const LoadingContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SpinKitCircle(
            color: Theme.of(context).colorScheme.secondary,
            size: 70,
          ),
          Image.asset(
            appImage,
            width: 40,
          ),
        ],
      ),
    );
  }
}