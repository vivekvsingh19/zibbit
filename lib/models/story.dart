class Story {
  final String id;
  final String userId;
  final String username;
  final String userAvatar;
  final String mediaUrl;
  final DateTime createdAt;
  final bool isViewed;
  final StoryType type;

  Story({
    required this.id,
    required this.userId,
    required this.username,
    required this.userAvatar,
    required this.mediaUrl,
    required this.createdAt,
    this.isViewed = false,
    this.type = StoryType.image,
  });
}

enum StoryType {
  image,
  video,
  meme,
}