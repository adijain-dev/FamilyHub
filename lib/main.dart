import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/auth_screen.dart';
import 'screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://gcjpqjbzmhessgmmjpzp.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdjanBxamJ6bWhlc3NnbW1qcHpwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODk5ODczNTMsImV4cCI6MjEwNTU2MzM1M30.1DKLiL7ARv8NqClyK858R-sA1xxBjAT2KACUFIPLwMA',
  );

  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Family App',
      theme: ThemeData(
        colorSchemeSeed: Colors.teal,
        useMaterial3: true,
      ),
      home: const AuthGate(),
    );
  }
}

// Listens to Supabase's auth state and swaps screens automatically.
// This is the ONLY place that decides "logged in or not" — the screens
// themselves never need to navigate manually after login/logout.
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: supabase.auth.onAuthStateChange,
      builder: (context, snapshot) {
        final session = snapshot.data?.session ?? supabase.auth.currentSession;

        if (session != null) {
          return const HomeScreen();
        }
        return const AuthScreen();
      },
    );
  }
}