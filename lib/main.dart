import 'package:bible_for_dawah/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bible For Dawah',
      theme: ThemeData.dark().copyWith(
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0XFF3D3434),
          ),
          scaffoldBackgroundColor: const Color(0XFF2D2424),
          textTheme: const TextTheme(
            bodyText1: TextStyle(
              color: Color(0XFFE0C097),
            ),
          )
          // scaffoldBackgroundColor: Colors.black,
          ),
      initialRoute: '/home',
      routes: routes,
    );
  }
}
