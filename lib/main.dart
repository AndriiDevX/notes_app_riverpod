import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('notes');
  runApp(ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        chipTheme: ChipThemeData(
          backgroundColor: const Color(0xFFE0E5EC),
          selectedColor: const Color(0xFFA3BCB6),
          secondarySelectedColor: const Color(0xFFA3BCB6),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          labelStyle: const TextStyle(color: Color(0xFF2D3436)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side: BorderSide.none,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFBC8F71),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
