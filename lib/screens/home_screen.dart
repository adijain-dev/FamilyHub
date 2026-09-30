import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Placeholder for now. Next step after this is the
// "Create or Join Family" screen — this file is where that logic
// will eventually decide what to show.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;
    final email = supabase.auth.currentUser?.email ?? 'unknown user';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Family App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await supabase.auth.signOut();
              // No navigation needed — AuthGate handles the switch back
              // to AuthScreen automatically.
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Logged in as $email\n\nCreate/Join Family screen goes here next.'),
      ),
    );
  }
}