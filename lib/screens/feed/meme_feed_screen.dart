import 'package:flutter/material.dart';
import 'package:memeapp/core/app_theme.dart';
import 'package:memeapp/models/meme_post.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

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
      creatorAvatar: 'https://i.pravatar.cc/150?img=1',
      memeImageUrl: 'https://picsum.photos/600/600?random=1',
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
      creatorAvatar: 'https://i.pravatar.cc/150?img=2',
      memeImageUrl: 'https://picsum.photos/600/600?random=2',
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
            icon: const Icon((IconsaxPlusLinear.add_square)),
            onPressed: () {
              // TODO: Navigate to meme creation screen
            },
          ),
          IconButton(
            icon: const Icon(IconsaxPlusLinear.message),
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
    return Column(
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

        // Meme Image with Caption Overlay
        AspectRatio(
          aspectRatio: 1,
          child: Container(
            color: AppTheme.darkSurfaceLight,
            child: Stack(
              children: [
                Image.network(
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
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: AppTheme.darkSurfaceLight,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.image_not_supported_outlined,
                              size: 48,
                              color: AppTheme.darkTextTertiary,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Image not available',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                // Caption Overlay - Bottom Gradient
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.8),
                          Colors.black.withOpacity(0.4),
                          Colors.transparent,
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Stack(
                          children: [
                            // Shadow/Outline effect
                            Text(
                              post.caption.replaceAll(RegExp(r'#\w+'), '').trim(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    offset: Offset(2, 2),
                                    blurRadius: 2,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            // Main text
                            Text(
                              post.caption.replaceAll(RegExp(r'#\w+'), '').trim(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    offset: Offset(1, 1),
                                    blurRadius: 1,
                                    color: Colors.black87,
                                  ),
                                ],
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Action Buttons
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              _buildActionButton(
                icon: post.isLiked
                    ? (IconsaxPlusBold.heart)
                    : (IconsaxPlusLinear.heart),
                color: post.isLiked ? Colors.red : null,
                onPressed: () => _toggleLike(post),
              ),
              _buildActionButton(
                icon: IconsaxPlusLinear.message,
                onPressed: () => _showComments(post),
              ),
              _buildActionButton(
                icon: IconsaxPlusLinear.share,
                onPressed: () => _shareMeme(post),
              ),
              const Spacer(),
              _buildActionButton(
                icon: post.isBookmarked
                    ? IconsaxPlusBold.bookmark
                    : IconsaxPlusLinear.bookmark,
                onPressed: () => _toggleBookmark(post),
              ),
            ],
          ),
        ),

        // Creator Name and Caption
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '${post.creatorName} ',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Likes Count - Instagram Style (no box)
        Padding(
          padding: const EdgeInsets.only(
            left: 12.0,
            right: 12.0,
            top: 8.0,
            bottom: 4.0,
          ),
          child: Text(
            '${post.likes} likes',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ),

        // Tags
        if (post.tags.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Wrap(
              spacing: 4,
              children: post.tags.map((tag) {
                return RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '#',
                        style: TextStyle(
                          color: AppTheme.vibrantBlue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: tag,
                        style: TextStyle(
                          color: AppTheme.vibrantBlue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
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
        Divider(
          height: 16,
          thickness: 0.5,
          color: Colors.white.withOpacity(0.1),
        ),
      ],
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
