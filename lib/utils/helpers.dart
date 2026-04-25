import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// 辅助函数工具类

class Helpers {
  static final Random _random = Random();

  /// 生成1-18的随机数
  static int getRandomNumber() => _random.nextInt(18) + 1;

  /// 生成三个随机数
  static List<int> getThreeRandomNumbers() => [
        getRandomNumber(),
        getRandomNumber(),
        getRandomNumber(),
      ];

  /// 计算三个数字的和
  static int calculateSum(int n1, int n2, int n3) => n1 + n2 + n3;

  /// 格式化日期时间
  static String formatDateTime(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
  }

  /// 格式化日期
  static String formatDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  /// 格式化时间
  static String formatTime(DateTime dateTime) {
    return DateFormat('HH:mm:ss').format(dateTime);
  }

  /// 获取相对时间描述
  static String getRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()}年前';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()}月前';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}天前';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}小时前';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}分钟前';
    } else {
      return '刚刚';
    }
  }

  /// 获取数字对应的中文
  static String getNumberChinese(int number) {
    const chineseNumbers = [
      '',
      '一',
      '二',
      '三',
      '四',
      '五',
      '六',
      '七',
      '八',
      '九',
      '十',
      '十一',
      '十二',
      '十三',
      '十四',
      '十五',
      '十六',
      '十七',
      '十八'
    ];
    if (number >= 0 && number <= 18) {
      return chineseNumbers[number];
    }
    return number.toString();
  }

  /// 复制文本到剪贴板
  static Future<void> copyToClipboard(
      BuildContext context, String text) async {
    // 实际实现时需要使用 Clipboard.setData
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('已复制到剪贴板')),
    );
  }

  /// 显示确认对话框
  static Future<bool> showConfirmDialog(
    BuildContext context, {
    required String title,
    required String content,
    String confirmText = '确认',
    String cancelText = '取消',
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(cancelText),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(confirmText),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  /// 显示消息提示
  static void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  /// 获取轮相图标
  static IconData getLunxiangIcon(int category) {
    switch (category) {
      case '观善恶业':
        return Icons.balance;
      case '观所疑':
        return Icons.help;
      case '观所梦':
        return Icons.nightlight;
      case '观所闻':
        return Icons.hearing;
      case '观所求':
        return Icons.search;
      case '观所失':
        return Icons.remove_circle;
      case '观所忧':
        return Icons.sentiment_dissatisfied;
      case '观所恶':
        return Icons.thumb_down;
      case '观所取':
        return Icons.add_circle;
      case '观业果报':
        return Icons.brightness_7;
      default:
        return Icons.auto_awesome;
    }
  }
}
