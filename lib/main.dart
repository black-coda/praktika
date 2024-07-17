import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/utils/router/router_manager.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/view/screens/dashboard_screen.dart';
import 'authentication/controller/supabse_provider.dart';

void main() async {
  await Supabase.initialize(
    url: 'https://wtwjpaqdemodwqbobosx.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Ind0d2pwYXFkZW1vZHdxYm9ib3N4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjEyMjc1ODYsImV4cCI6MjAzNjgwMzU4Nn0.iXxczNo2brN3i8xLoZ1agec-5cNvajvn4HVOmdyFWNA',
  );
  runApp(const ProviderScope(child: AppEntry()));
}

class AppEntry extends ConsumerWidget {
  const AppEntry({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xff1A1A1A),
        textTheme: GoogleFonts.unboundedTextTheme(),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xff1A1A1A),
        ),
        // useMaterial3: true,
      ),
      home: const App(),
      // routerConfig: ref.watch(routerManagerProvider),
    );
  }
}
