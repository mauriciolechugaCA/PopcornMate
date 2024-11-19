import 'package:flutter/material.dart';
import 'package:popcornmate_app/navigation/main_navigation.dart';
import 'package:popcornmate_app/theme/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PopcornMate',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        // scaffoldBackgroundColor: AppColors.secondary,
        colorScheme: Theme.of(context).colorScheme.copyWith(
          primary: AppColors.accent,
          secondary: AppColors.highlight,
        ),
        useMaterial3: true,
      ),
      home: const MainNavigation(),
    );
  }
}