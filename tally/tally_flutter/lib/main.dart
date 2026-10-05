import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'client.dart';
import 'screens/desk_shell.dart';
import 'screens/sign_in_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeClient();
  runApp(const TallyApp());
}

class TallyApp extends StatelessWidget {
  const TallyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final base = ColorScheme.fromSeed(
      seedColor: const Color(0xFF0A0A0A),
      brightness: Brightness.light,
      primary: const Color(0xFF0A0A0A),
      secondary: const Color(0xFFD4AF37),
      surface: const Color(0xFFFAFAFA),
    );

    return MaterialApp(
      title: 'TALLY — Accra Guest-House Till',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: base,
        useMaterial3: true,
        textTheme: GoogleFonts.dmSansTextTheme(),
        scaffoldBackgroundColor: const Color(0xFFFAFAFA),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0A0A0A),
          foregroundColor: Color(0xFFFAFAFA),
          elevation: 0,
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: const Color(0xFF0A0A0A),
            foregroundColor: const Color(0xFFFAFAFA),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ),
      home: const SignInScreen(child: DeskShell()),
    );
  }
}
