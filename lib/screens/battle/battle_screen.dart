import 'package:flutter/material.dart';
import 'package:memeapp/core/app_theme.dart';
import 'package:memeapp/screens/create/meme_creator_screen.dart';

class BattleScreen extends StatefulWidget {
  const BattleScreen({super.key});

  @override
  State<BattleScreen> createState() => _BattleScreenState();
}

class _BattleScreenState extends State<BattleScreen> {
  // Placeholder battle data - in real app, these would come from backend
  final List<Map<String, dynamic>> currentBattles = [
    {
      'player1': 'MemeKing',
      'player2': 'DankMaster',
      'votes1': 45,
      'votes2': 38,
      'timeLeft': '2:30',
      'prize': '500 coins',
    },
    {
      'player1': 'MemeLord',
      'player2': 'MemeQueen',
      'votes1': 67,
      'votes2': 72,
      'timeLeft': '1:45',
      'prize': '1000 coins',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meme Battles'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _createNewMeme(context),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Active Battles Section
          const Text(
            'Active Battles',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ...currentBattles.map((battle) => _buildBattleCard(battle)),

          const SizedBox(height: 24),

          // Start New Battle Button
          ElevatedButton(
            onPressed: () => _startNewBattle(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.vibrantGreen,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text(
              'Start New Battle',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBattleCard(Map<String, dynamic> battle) {
    final totalVotes = battle['votes1'] + battle['votes2'];
    final progress1 = totalVotes > 0 ? battle['votes1'] / totalVotes : 0.5;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: AppTheme.cardBg,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Battle Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Prize: ${battle['prize']}',
                  style: TextStyle(
                    color: AppTheme.vibrantGreen,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.timer, size: 16, color: Colors.red),
                      const SizedBox(width: 4),
                      Text(
                        battle['timeLeft'],
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Battle Content
            Row(
              children: [
                // Player 1 Meme
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(battle['player1'] + "'s Meme"),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        battle['player1'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                // VS
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppTheme.vibrantBlue.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      'VS',
                      style: TextStyle(
                        color: AppTheme.vibrantBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Player 2 Meme
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(battle['player2'] + "'s Meme"),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        battle['player2'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Voting Progress
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Stack(
                children: [
                  Container(height: 24, color: Colors.red.withOpacity(0.3)),
                  FractionallySizedBox(
                    widthFactor: progress1,
                    child: Container(
                      height: 24,
                      color: AppTheme.vibrantBlue.withOpacity(0.3),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Vote Count
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${battle['votes1']} votes'),
                Text('${battle['votes2']} votes'),
              ],
            ),
            const SizedBox(height: 16),

            // Vote Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _vote(battle['player1']),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.vibrantBlue,
                    ),
                    child: const Text('Vote Left'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _vote(battle['player2']),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text('Vote Right'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _createNewMeme(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MemeCreatorScreen()),
    );
  }

  void _startNewBattle(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Start New Battle'),
        content: const Text(
          'Select a meme from your collection to start a battle. Entry fee: 100 coins',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _createNewMeme(context);
            },
            child: const Text('Create New Meme'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement battle creation logic
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.vibrantBlue,
            ),
            child: const Text('Select Meme'),
          ),
        ],
      ),
    );
  }

  void _vote(String player) {
    // TODO: Implement voting logic
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Voted for $player!')));
  }
}
