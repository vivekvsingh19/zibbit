import 'package:flutter/material.dart';
import 'package:memeapp/core/app_theme.dart';
import 'package:memeapp/models/user_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Sample user data
  final UserProfile _user = UserProfile(
    id: 'user1',
    username: 'memelegend',
    displayName: 'Meme Legend',
    bio:
        'Professional meme creator 🎨\nTournament champion 🏆\nMaking people laugh since 2023 😂',
    avatarUrl: 'https://placeholder.com/avatar1',
    followers: 10500,
    following: 420,
    totalPosts: 69,
    totalLikes: 42000,
    badges: ['Tournament Champion', 'Verified Creator', 'Top Memer'],
    isVerified: true,
    stats: UserStats(
      memesCreated: 150,
      battlesWon: 45,
      tournamentsWon: 3,
      totalVotes: 25000,
      winRate: 0.75,
    ),
  );

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
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 320,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: _buildProfileHeader(),
              ),
              bottom: TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: 'Memes'),
                  Tab(text: 'Battles'),
                  Tab(text: 'Stats'),
                ],
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [_buildMemesGrid(), _buildBattlesTab(), _buildStatsTab()],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          // Avatar and Stats
          Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(_user.avatarUrl),
                  ),
                  if (_user.isVerified)
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.verified,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatColumn('Posts', _user.totalPosts.toString()),
                    _buildStatColumn(
                      'Followers',
                      _formatNumber(_user.followers),
                    ),
                    _buildStatColumn(
                      'Following',
                      _formatNumber(_user.following),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Name and Bio
          Text(
            _user.displayName,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            '@${_user.username}',
            style: TextStyle(color: Colors.white.withOpacity(0.8)),
          ),
          const SizedBox(height: 8),
          Text(_user.bio),
          const SizedBox(height: 16),

          // Badges
          SizedBox(
            height: 32,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _user.badges.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.vibrantBlue.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppTheme.vibrantBlue),
                  ),
                  child: Text(
                    _user.badges[index],
                    style: const TextStyle(fontSize: 12),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),

          // Edit Profile Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // TODO: Navigate to edit profile screen
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.cardBg,
                side: BorderSide(color: Colors.white.withOpacity(0.2)),
              ),
              child: const Text('Edit Profile'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String label, String value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(label, style: TextStyle(color: Colors.white.withOpacity(0.8))),
      ],
    );
  }

  Widget _buildMemesGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(1),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      itemCount: _user.totalPosts,
      itemBuilder: (context, index) {
        return Container(
          color: AppTheme.cardBg,
          child: Center(child: Text('Meme ${index + 1}')),
        );
      },
    );
  }

  Widget _buildBattlesTab() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: AppTheme.cardBg,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: index % 2 == 0
                  ? AppTheme.vibrantBlue.withOpacity(0.2)
                  : Colors.red.withOpacity(0.2),
              child: Icon(
                index % 2 == 0 ? Icons.emoji_events : Icons.close,
                color: index % 2 == 0 ? AppTheme.vibrantBlue : Colors.red,
              ),
            ),
            title: Text(
              index % 2 == 0 ? 'Victory' : 'Defeat',
              style: TextStyle(
                color: index % 2 == 0 ? AppTheme.vibrantBlue : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text('vs. Opponent ${index + 1}'),
            trailing: Text('${100 + index} votes'),
          ),
        );
      },
    );
  }

  Widget _buildStatsTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildStatCard('Battle Performance', [
          _buildStatItem('Battles Won', _user.stats.battlesWon.toString()),
          _buildStatItem(
            'Win Rate',
            '${(_user.stats.winRate * 100).toStringAsFixed(1)}%',
          ),
          _buildStatItem(
            'Total Votes Received',
            _formatNumber(_user.stats.totalVotes),
          ),
        ]),
        const SizedBox(height: 16),
        _buildStatCard('Tournament Achievement', [
          _buildStatItem(
            'Tournaments Won',
            _user.stats.tournamentsWon.toString(),
          ),
          _buildStatItem('Best Placement', '1st'),
          _buildStatItem('Tournament Points', '1,234'),
        ]),
        const SizedBox(height: 16),
        _buildStatCard('Content Creation', [
          _buildStatItem('Memes Created', _user.stats.memesCreated.toString()),
          _buildStatItem('Total Likes', _formatNumber(_user.totalLikes)),
          _buildStatItem('Average Likes', '612'),
        ]),
      ],
    );
  }

  Widget _buildStatCard(String title, List<Widget> stats) {
    return Card(
      color: AppTheme.cardBg,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...stats,
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.white.withOpacity(0.8))),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }
}
