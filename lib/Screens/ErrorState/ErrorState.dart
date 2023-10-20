import 'package:flutter/material.dart';

class errorState extends StatelessWidget {
  const errorState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.wifi_tethering_error_sharp,
            size: 180.0,
          ),
          Text(
            'check your internet connection',
            style: TextStyle(fontSize: 22),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
