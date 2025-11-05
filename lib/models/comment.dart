class Comment {
  final String id;
  final String userId;
  final String username;
  final String userAvatar;
  final String content;
  final DateTime createdAt;
  final int likes;
  final bool isLiked;
  final List<Comment> replies;

  Comment({
    required this.id,
    required this.userId,
    required this.username,
    required this.userAvatar,
    required this.content,
    required this.createdAt,
    this.likes = 0,
    this.isLiked = false,
    this.replies = const [],
  });

  Comment copyWith({
    int? likes,
    bool? isLiked,
    List<Comment>? replies,
  }) {
    return Comment(
      id: id,
      userId: userId,
      username: username,
      userAvatar: userAvatar,
      content: content,
      createdAt: createdAt,
      likes: likes ?? this.likes,
      isLiked: isLiked ?? this.isLiked,
      replies: replies ?? this.replies,
    );
  }
}