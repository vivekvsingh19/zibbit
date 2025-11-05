import 'package:flutter/material.dart';
import 'package:memeapp/controllers/ai_controller.dart';
import 'package:provider/provider.dart';
import 'package:memeapp/core/app_theme.dart';
import 'package:memeapp/screens/battle/battle_screen.dart' show BattleScreen;
import 'package:memeapp/screens/feed/meme_feed_screen.dart';
import 'package:memeapp/screens/shop/shop_screen.dart';
import 'package:memeapp/screens/tournament/tournament_screen.dart';
import 'package:memeapp/widgets/bottom_nav_scaffold.dart';

import 'screens/profile/profile_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AIController(),
      child: const MemeMogulApp(),
    ),
  );
}

class MemeMogulApp extends StatelessWidget {
  const MemeMogulApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meme Mogul',
      theme: AppTheme.themeData,
      home: const MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Main app screens
    final List<Widget> screens = [
      const MemeFeedScreen(), // Social feed
      const BattleScreen(), // Battle screen
      const TournamentScreen(), // Tournaments
      const ProfileScreen(), // User profile
      const ShopScreen(), // Monetization
    ];

    return BottomNavScaffold(screens: screens);
  }
}
