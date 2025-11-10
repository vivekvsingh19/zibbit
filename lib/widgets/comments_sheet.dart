import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:memeapp/core/app_theme.dart';
import 'package:memeapp/models/comment.dart';
import 'package:memeapp/models/meme_post.dart';

class CommentsSheet extends StatefulWidget {
  final MemePost post;

  const CommentsSheet({super.key, required this.post});

  @override
  State<CommentsSheet> createState() => _CommentsSheetState();
}

class _CommentsSheetState extends State<CommentsSheet> {
  final TextEditingController _commentController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  Comment? _replyingTo;

  // Sample comments data
  final List<Comment> _comments = [
    Comment(
      id: '1',
      userId: 'user1',
      username: 'MemeKing',
      userAvatar: 'https://placeholder.com/avatar1',
      content: '😂 This is hilarious!',
      createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
      likes: 42,
      replies: [
        Comment(
          id: '1.1',
          userId: 'user2',
          username: 'DankMaster',
          userAvatar: 'https://placeholder.com/avatar2',
          content: 'Ikr! Made my day 🔥',
          createdAt: DateTime.now().subtract(const Duration(minutes: 15)),
          likes: 12,
        ),
      ],
    ),
  ];

  @override
  void dispose() {
    _commentController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        children: [
          // Header
          _buildHeader(),

          // Comments List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _comments.length,
              itemBuilder: (context, index) =>
                  _buildCommentItem(_comments[index]),
            ),
          ),

          // Reply indicator
          if (_replyingTo != null) _buildReplyingTo(),

          // Comment Input
          _buildCommentInput(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.white.withOpacity(0.1)),
        ),
      ),
      child: Row(
        children: [
          const Text(
            'Comments',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Iconsax.close_circle),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentItem(Comment comment) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(comment.userAvatar),
              radius: 16,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        comment.username,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _getTimeAgo(comment.createdAt),
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(comment.content),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildActionButton(
                        icon: comment.isLiked ? Iconsax.heart : Iconsax.heart,
                        label: comment.likes.toString(),
                        color: comment.isLiked ? Colors.red : null,
                        onTap: () => _likeComment(comment),
                      ),
                      const SizedBox(width: 16),
                      _buildActionButton(
                        icon: Iconsax.redo,
                        label: 'Reply',
                        onTap: () => _startReply(comment),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        // Replies
        if (comment.replies.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 44, top: 8),
            child: Column(
              children: comment.replies
                  .map((reply) => _buildCommentItem(reply))
                  .toList(),
            ),
          ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    Color? color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: color ?? Colors.white.withOpacity(0.8),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReplyingTo() {
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.blue.withOpacity(0.1),
      child: Row(
        children: [
          const Icon(Icons.reply, size: 16),
          const SizedBox(width: 8),
          Text('Replying to ${_replyingTo!.username}'),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => setState(() => _replyingTo = null),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentInput() {
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 8,
        bottom: MediaQuery.of(context).viewInsets.bottom + 8,
      ),
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.1))),
      ),
      child: Row(
        children: [
          const CircleAvatar(radius: 16, child: Icon(Icons.person)),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: _commentController,
              focusNode: _focusNode,
              decoration: InputDecoration(
                hintText: _replyingTo != null
                    ? 'Reply to ${_replyingTo!.username}...'
                    : 'Add a comment...',
                border: InputBorder.none,
              ),
              maxLines: 5,
              minLines: 1,
            ),
          ),
          TextButton(
            onPressed: _submitComment,
            child: Text(
              'Post',
              style: TextStyle(
                color: _commentController.text.isEmpty
                    ? Colors.white.withOpacity(0.5)
                    : AppTheme.vibrantBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getTimeAgo(DateTime dateTime) {
    final difference = DateTime.now().difference(dateTime);
    if (difference.inDays > 0) {
      return '${difference.inDays}d';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m';
    } else {
      return 'just now';
    }
  }

  void _likeComment(Comment comment) {
    final index = _comments.indexOf(comment);
    if (index != -1) {
      setState(() {
        _comments[index] = comment.copyWith(
          isLiked: !comment.isLiked,
          likes: comment.isLiked ? comment.likes - 1 : comment.likes + 1,
        );
      });
    }
  }

  void _startReply(Comment comment) {
    setState(() => _replyingTo = comment);
    _focusNode.requestFocus();
  }

  void _submitComment() {
    if (_commentController.text.isEmpty) return;

    final newComment = Comment(
      id: DateTime.now().toString(),
      userId: 'currentUser',
      username: 'CurrentUser',
      userAvatar: 'https://placeholder.com/currentuser',
      content: _commentController.text,
      createdAt: DateTime.now(),
    );

    setState(() {
      if (_replyingTo != null) {
        final parentIndex = _comments.indexOf(_replyingTo!);
        if (parentIndex != -1) {
          final updatedReplies = [..._replyingTo!.replies, newComment];
          _comments[parentIndex] = _replyingTo!.copyWith(
            replies: updatedReplies,
          );
        }
        _replyingTo = null;
      } else {
        _comments.insert(0, newComment);
      }
      _commentController.clear();
    });
  }
}
