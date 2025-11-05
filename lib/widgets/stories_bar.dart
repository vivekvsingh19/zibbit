import 'package:flutter/material.dart';
import 'package:memeapp/core/app_theme.dart';
import 'package:memeapp/models/story.dart';

class StoriesBar extends StatelessWidget {
  final List<Story> stories;
  final VoidCallback onAddStory;

  const StoriesBar({
    super.key,
    required this.stories,
    required this.onAddStory,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        children: [
          // Add Story Button
          _buildAddStoryButton(),
          const SizedBox(width: 12),
          // Stories List
          ...stories.map((story) => _buildStoryItem(context, story)),
        ],
      ),
    );
  }

  Widget _buildAddStoryButton() {
    return Column(
      children: [
        GestureDetector(
          onTap: onAddStory,
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.cardBg,
              border: Border.all(
                color: AppTheme.vibrantBlue,
                width: 2,
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.add,
                size: 30,
                color: AppTheme.vibrantBlue,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Add Story',
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildStoryItem(BuildContext context, Story story) {
    return GestureDetector(
      onTap: () => _viewStory(context, story),
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        child: Column(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: story.isViewed
                    ? null
                    : LinearGradient(
                        colors: [
                          AppTheme.vibrantBlue,
                          AppTheme.vibrantGreen,
                        ],
                      ),
                border: story.isViewed
                    ? Border.all(
                        color: Colors.grey.withOpacity(0.5),
                        width: 2,
                      )
                    : null,
              ),
              padding: const EdgeInsets.all(2),
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.cardBg,
                ),
                padding: const EdgeInsets.all(2),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(story.userAvatar),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              story.username,
              style: TextStyle(
                fontSize: 12,
                color: story.isViewed
                    ? Colors.grey
                    : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _viewStory(BuildContext context, Story story) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StoryViewScreen(story: story),
      ),
    );
  }
}

class StoryViewScreen extends StatefulWidget {
  final Story story;

  const StoryViewScreen({
    super.key,
    required this.story,
  });

  @override
  State<StoryViewScreen> createState() => _StoryViewScreenState();
}

class _StoryViewScreenState extends State<StoryViewScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _progressController;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Navigator.pop(context);
        }
      });
    _progressController.forward();
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTapDown: (details) {
          final screenWidth = MediaQuery.of(context).size.width;
          if (details.globalPosition.dx < screenWidth / 2) {
            // Tapped left side - go back
            Navigator.pop(context);
          } else {
            // Tapped right side - skip to next
            Navigator.pop(context);
          }
        },
        child: Stack(
          children: [
            // Progress Bar
            Positioned(
              top: MediaQuery.of(context).padding.top,
              left: 0,
              right: 0,
              child: AnimatedBuilder(
                animation: _progressController,
                builder: (context, child) {
                  return LinearProgressIndicator(
                    value: _progressController.value,
                    backgroundColor: Colors.grey.withOpacity(0.2),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Colors.white,
                    ),
                  );
                },
              ),
            ),

            // Story Content
            Center(
              child: Image.network(
                widget.story.mediaUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const CircularProgressIndicator();
                },
              ),
            ),

            // User Info
            Positioned(
              top: MediaQuery.of(context).padding.top + 20,
              left: 12,
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.story.userAvatar),
                    radius: 20,
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.story.username,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '${DateTime.now().difference(widget.story.createdAt).inHours}h ago',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}