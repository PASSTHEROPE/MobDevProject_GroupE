import 'package:flutter/material.dart';

import 'spacers.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Center(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Color.fromARGB(255, 251, 251, 251),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
                WidthSpacer(myWidth: 25.50),
                Text("Welcome Back!"),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
