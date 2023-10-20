import 'dart:convert';

import 'package:first_app/Screens/ErrorState/ErrorState.dart';
import 'package:first_app/Screens/LoadingState/loding_state.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Screens/LoadedState/LoadedState.dart';
import 'Screens/SleepState/sleep_state.dart';

void main() {
  runApp(MySharedData(sharedValue: SleepState(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'random jokes app'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //DataState state = SleepState();

  Future<void> fetchJoke() async {
    setState(() {
      MySharedData.of(context).sharedValue = LoadingState();
    });
    await Future.delayed(Duration(seconds: 2), () {});
    try {
      final response = await http.get(Uri.parse(
          //'https://official-joke-api.appspot.com/random_joke'));
          'https://official-joke-api.appspot.com/random_joke'));
      if (response.statusCode == 200) {
        // Successful response.
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        setState(() {
          MySharedData.of(context).sharedValue =
              LoadedState([jsonResponse['setup'], jsonResponse['punchline']]);
        });
      } else {
        // Handle errors.
        print('Failed to fetch joke. Status code: ${response.statusCode}');
        setState(() {
          MySharedData.of(context).sharedValue = ErrorState("error u know ");
        });
      }
    } catch (Exception) {
      print(Exception.toString());
      setState(() {
        MySharedData.of(context).sharedValue = ErrorState("some junk");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: AnimatedSwitcher(
        duration: const Duration(seconds: 2),
        child: switch (MySharedData.of(context).sharedValue) {
          SleepState() => const sleepState(),
          LoadingState() => const loadingState(),
          LoadedState(data: List<String> data) => loadedState(
              data: data,
            ),
          ErrorState(message: var message) => const errorState(),
        },
        transitionBuilder: (Widget child, Animation<double> animation) {
          final offset = Tween<Offset>(
            begin: const Offset(1, 0),
            end: const Offset(0, 0),
          ).animate(animation);
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: offset,
              child: child,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await fetchJoke();
          },
          child: const Icon(Icons.refresh)),
    );
  }
}

sealed class DataState {}

class SleepState extends DataState {}

class LoadingState extends DataState {}

class LoadedState extends DataState {
  final List<String> data;
  LoadedState(
    this.data,
  );
}

class ErrorState extends DataState {
  final String message;
  ErrorState(this.message);
}

class MySharedData extends InheritedWidget {
  DataState sharedValue;

  MySharedData({required this.sharedValue, required Widget child})
      : super(child: child);

  @override
  bool updateShouldNotify(MySharedData oldWidget) {
    return sharedValue != oldWidget.sharedValue;
  }

  static MySharedData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MySharedData>()!;
  }
}
