import 'package:flutter/material.dart';
import 'package:thermometer/src/thermo_page.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      restorationScopeId: 'app',
      supportedLocales: const [
        Locale('en', ''), // English, no country code
      ],
      theme: ThemeData(),
      home: const ThermoPage(),
    );
  }
}
