import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'utils/theme.dart';
import 'utils/constants.dart';
import 'services/storage_service.dart';
import 'services/database_service.dart';
import 'providers/zhanzi_provider.dart';
import 'screens/home_screen.dart';
import 'screens/history_screen.dart';
import 'screens/lunxiang_list_screen.dart';
import 'screens/she_wen_screen.dart';
import 'screens/settings_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 设置状态栏样式
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  // 初始化存储服务
  await StorageService().init();

  // 初始化数据库
  await DatabaseService().database;

  runApp(const ZhanZhanApp());
}

class ZhanZhanApp extends StatelessWidget {
  const ZhanZhanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ZhanziProvider()..init()),
      ],
      child: Consumer<ZhanziProvider>(
        builder: (context, provider, _) {
          return MaterialApp(
            title: AppConstants.appName,
            debugShowCheckedModeBanner: false,

            // 主题配置
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.system,

            // 路由配置
            initialRoute: '/',
            routes: {
              '/': (context) => const HomeScreen(),
              '/history': (context) => const HistoryScreen(),
              '/lunxiang': (context) => const LunxiangListScreen(),
              '/shewen': (context) => const SheWenScreen(),
              '/settings': (context) => const SettingsScreen(),
            },

            // 统一错误处理
            builder: (context, child) {
              return MediaQuery(
                // 防止文字大小随系统设置变化
                data: MediaQuery.of(context).copyWith(
                  textScaler: TextScaler.noScaling,
                ),
                child: child ?? const SizedBox.shrink(),
              );
            },
          );
        },
      ),
    );
  }
}
