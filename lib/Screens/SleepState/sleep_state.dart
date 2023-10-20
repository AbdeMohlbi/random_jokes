import 'package:flutter/material.dart';

class sleepState extends StatelessWidget {
  const sleepState({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Swipe, laugh, and have a great time! 😆',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
            )),
        Text(
          'remember to share the laughter with your friends! 🎈',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22),
        )
      ],
    );
  }
}
