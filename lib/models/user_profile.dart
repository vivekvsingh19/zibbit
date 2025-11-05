class UserProfile {
  final String id;
  final String username;
  final String displayName;
  final String bio;
  final String avatarUrl;
  final int followers;
  final int following;
  final int totalPosts;
  final int totalLikes;
  final List<String> badges;
  final bool isVerified;
  final UserStats stats;

  UserProfile({
    required this.id,
    required this.username,
    required this.displayName,
    this.bio = '',
    required this.avatarUrl,
    this.followers = 0,
    this.following = 0,
    this.totalPosts = 0,
    this.totalLikes = 0,
    this.badges = const [],
    this.isVerified = false,
    required this.stats,
  });
}

class UserStats {
  final int memesCreated;
  final int battlesWon;
  final int tournamentsWon;
  final int totalVotes;
  final double winRate;

  UserStats({
    this.memesCreated = 0,
    this.battlesWon = 0,
    this.tournamentsWon = 0,
    this.totalVotes = 0,
    this.winRate = 0.0,
  });
}