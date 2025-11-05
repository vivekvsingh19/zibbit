class MemePost {
  final String id;
  final String creatorId;
  final String creatorName;
  final String creatorAvatar;
  final String memeImageUrl;
  final String caption;
  final DateTime createdAt;
  final int likes;
  final int comments;
  final bool isLiked;
  final bool isBookmarked;
  final bool isFollowing;
  final List<String> tags;

  MemePost({
    required this.id,
    required this.creatorId,
    required this.creatorName,
    required this.creatorAvatar,
    required this.memeImageUrl,
    required this.caption,
    required this.createdAt,
    required this.likes,
    required this.comments,
    this.isLiked = false,
    this.isBookmarked = false,
    this.isFollowing = false,
    this.tags = const [],
  });

  MemePost copyWith({
    bool? isLiked,
    bool? isBookmarked,
    bool? isFollowing,
    int? likes,
    int? comments,
  }) {
    return MemePost(
      id: id,
      creatorId: creatorId,
      creatorName: creatorName,
      creatorAvatar: creatorAvatar,
      memeImageUrl: memeImageUrl,
      caption: caption,
      createdAt: createdAt,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      isLiked: isLiked ?? this.isLiked,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      isFollowing: isFollowing ?? this.isFollowing,
      tags: tags,
    );
  }
}