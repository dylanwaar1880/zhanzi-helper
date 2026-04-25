import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/home_screen_v2.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 捕获Flutter框架错误
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    debugPrint('Flutter Error: ${details.exception}');
  };
  
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
      home: const SafeArea(
        child: HomeScreenV2(),
      ),
      builder: (context, widget) {
        // 错误边界
        Widget errorWidget = const Center(
          child: Text('加载出错，请重启应用'),
        );
        if (widget != null) {
          try {
            return widget;
          } catch (e) {
            debugPrint('Widget build error: $e');
            return errorWidget;
          }
        }
        return errorWidget;
      },
    );
  }
}
