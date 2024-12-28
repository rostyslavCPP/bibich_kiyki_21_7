import 'package:flutter/material.dart';
import 'widgets/tabs_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'University App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.latoTextTheme().copyWith(
          bodyMedium: GoogleFonts.lato(fontSize: 14),
          titleLarge: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      home: const TabsScreen(),
    );
  }
}
