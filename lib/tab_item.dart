import 'package:flutter/material.dart';

enum TabItem {
  home(
    title: 'ホーム',
    icon: Icons.home,
  ),

  timeline(
    title: 'タイムライン',
    icon: Icons.timeline,
  ),

  settings(
    title: '設定',
    icon: Icons.settings,
  );

  const TabItem({
    required this.title,
    required this.icon,
  });

  /// タイトル
  final String title;

  /// アイコン
  final IconData icon;
}
