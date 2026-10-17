import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animeverse/providers/app_state_provider.dart';
import 'config/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create : (_) => AppStateProvider(),
      child: MaterialApp.router(
        title: 'AnimeVerse',
        theme: ThemeData(
          fontFamily: 'Urbanist',
          brightness: Brightness.dark,
          colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0b395e),
          brightness: Brightness.dark,
        ),
      ),
      routerConfig: createRouter(),
      debugShowCheckedModeBanner: false,
    ),
    );
  }
}
