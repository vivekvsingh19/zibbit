import 'package:flutter/material.dart';
import 'package:memeapp/core/app_theme.dart';
import 'package:memeapp/models/meme_post.dart';

class MemeFeedScreen extends StatefulWidget {
  const MemeFeedScreen({super.key});

  @override
  State<MemeFeedScreen> createState() => _MemeFeedScreenState();
}

class _MemeFeedScreenState extends State<MemeFeedScreen> {
  // Simulated posts data - in real app, this would come from a backend
  final List<MemePost> _posts = [
    MemePost(
      id: '1',
      creatorId: 'user1',
      creatorName: 'MemeKing',
      creatorAvatar: 'https://placeholder.com/avatar1',
      memeImageUrl: 'https://placeholder.com/meme1',
      caption: 'When the code finally works 😅 #coding #programming',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      likes: 1234,
      comments: 89,
      tags: ['coding', 'programming'],
    ),
    MemePost(
      id: '2',
      creatorId: 'user2',
      creatorName: 'DankMaster',
      creatorAvatar: 'https://placeholder.com/avatar2',
      memeImageUrl: 'https://placeholder.com/meme2',
      caption: 'Gaming life be like... #gaming #gamer',
      createdAt: DateTime.now().subtract(const Duration(hours: 4)),
      likes: 2345,
      comments: 156,
      tags: ['gaming', 'gamer'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meme Feed'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_box_outlined),
            onPressed: () {
              // TODO: Navigate to meme creation screen
            },
          ),
          IconButton(
            icon: const Icon(Icons.message_outlined),
            onPressed: () {
              // TODO: Navigate to messages screen
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // TODO: Implement refresh logic
        },
        child: ListView.builder(
          itemCount: _posts.length,
          itemBuilder: (context, index) => _buildMemePost(_posts[index]),
        ),
      ),
    );
  }

  Widget _buildMemePost(MemePost post) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      color: AppTheme.cardBg,
      elevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Post Header
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(post.creatorAvatar),
              backgroundColor: AppTheme.vibrantBlue.withOpacity(0.2),
            ),
            title: Text(
              post.creatorName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              _getTimeAgo(post.createdAt),
              style: TextStyle(color: Colors.white.withOpacity(0.6)),
            ),
            trailing: _buildFollowButton(post),
          ),

          // Meme Image
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              color: Colors.black12,
              child: Image.network(
                post.memeImageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              ),
            ),
          ),

          // Action Buttons
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                _buildActionButton(
                  icon: post.isLiked ? Icons.favorite : Icons.favorite_border,
                  color: post.isLiked ? Colors.red : null,
                  onPressed: () => _toggleLike(post),
                ),
                _buildActionButton(
                  icon: Icons.chat_bubble_outline,
                  onPressed: () => _showComments(post),
                ),
                _buildActionButton(
                  icon: Icons.share_outlined,
                  onPressed: () => _shareMeme(post),
                ),
                const Spacer(),
                _buildActionButton(
                  icon: post.isBookmarked
                      ? Icons.bookmark
                      : Icons.bookmark_border,
                  onPressed: () => _toggleBookmark(post),
                ),
              ],
            ),
          ),

          // Likes Count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              '${post.likes} likes',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          // Caption and Tags
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${post.creatorName} ',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: post.caption),
                    ],
                  ),
                ),
                if (post.tags.isNotEmpty) const SizedBox(height: 4),
                Wrap(
                  spacing: 4,
                  children: post.tags.map((tag) {
                    return Text(
                      '#$tag',
                      style: TextStyle(
                        color: AppTheme.vibrantBlue,
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          // Comments Preview
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: InkWell(
              onTap: () => _showComments(post),
              child: Text(
                'View all ${post.comments} comments',
                style: TextStyle(color: Colors.white.withOpacity(0.6)),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    Color? color,
    required VoidCallback onPressed,
  }) {
    return IconButton(
      icon: Icon(icon),
      color: color,
      onPressed: onPressed,
      splashRadius: 20,
    );
  }

  Widget _buildFollowButton(MemePost post) {
    return TextButton(
      onPressed: () => _toggleFollow(post),
      style: TextButton.styleFrom(
        backgroundColor: post.isFollowing
            ? Colors.transparent
            : AppTheme.vibrantBlue,
        side: post.isFollowing ? BorderSide(color: AppTheme.vibrantBlue) : null,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        minimumSize: const Size(80, 32),
      ),
      child: Text(
        post.isFollowing ? 'Following' : 'Follow',
        style: TextStyle(
          color: post.isFollowing ? AppTheme.vibrantBlue : Colors.white,
        ),
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

  void _toggleLike(MemePost post) {
    final index = _posts.indexOf(post);
    setState(() {
      _posts[index] = post.copyWith(
        isLiked: !post.isLiked,
        likes: post.isLiked ? post.likes - 1 : post.likes + 1,
      );
    });
  }

  void _toggleBookmark(MemePost post) {
    final index = _posts.indexOf(post);
    setState(() {
      _posts[index] = post.copyWith(isBookmarked: !post.isBookmarked);
    });
  }

  void _toggleFollow(MemePost post) {
    final index = _posts.indexOf(post);
    setState(() {
      _posts[index] = post.copyWith(isFollowing: !post.isFollowing);
    });
  }

  void _showComments(MemePost post) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.cardBg,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        builder: (context, scrollController) => Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Comments',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: 0, // TODO: Implement comments
                itemBuilder: (context, index) => const SizedBox(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _shareMeme(MemePost post) {
    // TODO: Implement share functionality
  }
}
