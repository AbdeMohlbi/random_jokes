import 'package:flutter/material.dart';

import '../../main.dart';

class loadingState extends StatefulWidget {
  const loadingState({super.key});

  @override
  State<loadingState> createState() => _loadingStateState();
}

class _loadingStateState extends State<loadingState> {
  @override
  Widget build(BuildContext context) {
    print(MySharedData.of(context).sharedValue);
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text("loading")],
      ),
    );
  }
}
