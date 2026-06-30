import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'core/app_colors.dart';
import 'core/app_text_styles.dart';
import 'data/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('notes');
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        chipTheme: ChipThemeData(
          backgroundColor: AppColors.chipBackground,
          selectedColor: AppColors.chipSelected,
          secondarySelectedColor: AppColors.chipSelected,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          labelStyle: AppTextStyles.chipLabel,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side: BorderSide.none,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.fabBackground,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
