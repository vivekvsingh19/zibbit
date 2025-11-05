import 'package:flutter/material.dart';
import 'package:memeapp/core/app_theme.dart' show AppTheme;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Battle Arena'),
        actions: [
          IconButton(
            icon: const Icon(Icons.diamond_outlined),
            onPressed: () {}, // Premium currency display
          ),
          IconButton(
            icon: const Icon(Icons.stars),
            onPressed: () {}, // Battle points display
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Quick Match Card
            _buildBattleCard(
              context,
              title: 'Quick Match',
              description: 'Jump into a random battle!',
              icon: Icons.flash_on,
              color: AppTheme.vibrantBlue,
              onTap: () {},
            ),
            const SizedBox(height: 16),
            // Ranked Match Card
            _buildBattleCard(
              context,
              title: 'Ranked Battle',
              description: 'Compete for leaderboard positions',
              icon: Icons.military_tech,
              color: AppTheme.vibrantGreen,
              onTap: () {},
            ),
            const SizedBox(height: 16),
            // Daily Challenges Section
            Card(
              color: AppTheme.cardBg,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Daily Challenges',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildChallengeItem('Win 3 Battles', '50 coins', 0.6),
                    const SizedBox(height: 8),
                    _buildChallengeItem('Create 1 Meme', '30 coins', 0.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBattleCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      color: AppTheme.cardBg,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 32),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(color: Colors.white.withOpacity(0.7)),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChallengeItem(String challenge, String reward, double progress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(challenge),
            Text(
              reward,
              style: TextStyle(
                color: AppTheme.vibrantGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.white.withOpacity(0.1),
          valueColor: AlwaysStoppedAnimation<Color>(AppTheme.vibrantBlue),
        ),
      ],
    );
  }
}
