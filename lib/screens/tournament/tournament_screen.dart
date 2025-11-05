import 'package:flutter/material.dart';
import 'package:memeapp/core/app_theme.dart';
import 'package:memeapp/models/tournament.dart';

class TournamentScreen extends StatefulWidget {
  const TournamentScreen({super.key});

  @override
  State<TournamentScreen> createState() => _TournamentScreenState();
}

class _TournamentScreenState extends State<TournamentScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Sample tournament data
  final List<Tournament> tournaments = [
    Tournament(
      id: '1',
      name: 'Movie Memes Monday',
      theme: '🎬 Movies',
      prize: '10,000 coins + Legendary Template',
      startTime: DateTime.now().add(const Duration(hours: 2)),
      endTime: DateTime.now().add(const Duration(hours: 26)),
      participantsCount: 45,
      maxParticipants: 64,
      status: 'upcoming',
    ),
    Tournament(
      id: '2',
      name: 'Gaming Memes Championship',
      theme: '🎮 Gaming',
      prize: '15,000 coins + Exclusive Effects Pack',
      startTime: DateTime.now(),
      endTime: DateTime.now().add(const Duration(hours: 48)),
      participantsCount: 64,
      maxParticipants: 64,
      status: 'active',
    ),
  ];

  // Sample bracket data
  final List<TournamentBracket> brackets = [
    TournamentBracket(
      roundName: 'Quarter Finals',
      matches: [
        {
          'player1': 'MemeKing',
          'player2': 'DankMaster',
          'votes1': 245,
          'votes2': 198,
          'timeLeft': '1:30',
        },
        {
          'player1': 'MemeQueen',
          'player2': 'MemeLord',
          'votes1': 312,
          'votes2': 289,
          'timeLeft': '2:15',
        },
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tournaments'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Active'),
            Tab(text: 'Upcoming'),
            Tab(text: 'Past'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTournamentList('active'),
          _buildTournamentList('upcoming'),
          _buildTournamentList('completed'),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showTournamentRules(context),
        icon: const Icon(Icons.emoji_events),
        label: const Text('Join Tournament'),
        backgroundColor: AppTheme.vibrantGreen,
      ),
    );
  }

  Widget _buildTournamentList(String status) {
    final filteredTournaments = tournaments
        .where((t) => t.status == status)
        .toList();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredTournaments.length,
      itemBuilder: (context, index) {
        final tournament = filteredTournaments[index];
        return _buildTournamentCard(tournament);
      },
    );
  }

  Widget _buildTournamentCard(Tournament tournament) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: AppTheme.cardBg,
      child: Column(
        children: [
          // Tournament Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.vibrantBlue.withOpacity(0.8),
                  AppTheme.vibrantGreen.withOpacity(0.8),
                ],
              ),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tournament.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Theme: ${tournament.theme}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildStatusChip(tournament.status),
              ],
            ),
          ),

          // Tournament Details
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Prize Pool
                Row(
                  children: [
                    const Icon(Icons.emoji_events, color: Colors.amber),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Prize: ${tournament.prize}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Participants
                Row(
                  children: [
                    const Icon(Icons.people),
                    const SizedBox(width: 8),
                    Text(
                      'Participants: ${tournament.participantsCount}/${tournament.maxParticipants}',
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Time
                Row(
                  children: [
                    const Icon(Icons.timer),
                    const SizedBox(width: 8),
                    Text('Ends: ${_formatDateTime(tournament.endTime)}'),
                  ],
                ),
                const SizedBox(height: 16),

                // Action Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _viewTournamentDetails(tournament),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.vibrantBlue,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      'View Details',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color chipColor;
    String label;

    switch (status) {
      case 'active':
        chipColor = Colors.green;
        label = 'Active';
        break;
      case 'upcoming':
        chipColor = AppTheme.vibrantBlue;
        label = 'Upcoming';
        break;
      case 'completed':
        chipColor = Colors.grey;
        label = 'Completed';
        break;
      default:
        chipColor = Colors.grey;
        label = 'Unknown';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: chipColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: chipColor),
      ),
      child: Text(
        label,
        style: TextStyle(color: chipColor, fontWeight: FontWeight.bold),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    // Simple formatter - you might want to use intl package for better formatting
    return '${dateTime.day}/${dateTime.month} ${dateTime.hour}:${dateTime.minute}';
  }

  void _viewTournamentDetails(Tournament tournament) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => _TournamentDetailsScreen(
          tournament: tournament,
          brackets: brackets,
        ),
      ),
    );
  }

  void _showTournamentRules(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tournament Rules'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text('1. Entry fee: 1,000 coins'),
              Text('2. Create tournament-themed memes only'),
              Text('3. One submission per round'),
              Text('4. No offensive or inappropriate content'),
              Text('5. Voting period: 2 hours per round'),
              Text('6. Winners advance to next round'),
              Text('7. Final round winner takes the prize pool'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement tournament join logic
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.vibrantGreen,
            ),
            child: const Text('Join Tournament'),
          ),
        ],
      ),
    );
  }
}

class _TournamentDetailsScreen extends StatelessWidget {
  final Tournament tournament;
  final List<TournamentBracket> brackets;

  const _TournamentDetailsScreen({
    required this.tournament,
    required this.brackets,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tournament.name)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Tournament Info Card
          Card(
            color: AppTheme.cardBg,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Theme: ${tournament.theme}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('Prize: ${tournament.prize}'),
                  Text(
                    'Participants: ${tournament.participantsCount}/${tournament.maxParticipants}',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Bracket View
          const Text(
            'Tournament Bracket',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Render brackets
          ...brackets.map((bracket) => _buildBracketRound(bracket)),
        ],
      ),
    );
  }

  Widget _buildBracketRound(TournamentBracket bracket) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            bracket.roundName,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        ...bracket.matches.map((match) => _buildMatchCard(match)),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildMatchCard(Map<String, dynamic> match) {
    return Card(
      color: AppTheme.cardBg,
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(match['player1']),
                Text('${match['votes1']} votes'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(match['player2']),
                Text('${match['votes2']} votes'),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Time Left: ${match['timeLeft']}',
              style: const TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
