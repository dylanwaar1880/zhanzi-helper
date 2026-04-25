import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/home_screen_v2.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  
  runApp(const ZhanZhanApp());
}

class ZhanZhanApp extends StatelessWidget {
  const ZhanZhanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '地藏占察轮',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4682B4)),
        useMaterial3: false,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 0,
        ),
      ),
      home: const HomeScreenV2(),
    );
  }
}
