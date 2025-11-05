import 'package:flutter/material.dart';
import 'package:memeapp/core/app_theme.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  // Sample trending hashtags
  final List<String> _trendingTags = [
    'gamingmemes',
    'programminghumor',
    'dankdaily',
    'memeoftheday',
    'funnymoments',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              floating: true,
              snap: true,
              title: _isSearching ? _buildSearchField() : const Text('Explore'),
              actions: [
                IconButton(
                  icon: Icon(_isSearching ? Icons.close : Icons.search),
                  onPressed: () {
                    setState(() {
                      _isSearching = !_isSearching;
                      if (!_isSearching) {
                        _searchController.clear();
                      }
                    });
                  },
                ),
              ],
              bottom: TabBar(
                controller: _tabController,
                isScrollable: true,
                tabs: const [
                  Tab(text: 'For You'),
                  Tab(text: 'Trending'),
                  Tab(text: 'Latest'),
                  Tab(text: 'Following'),
                ],
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildForYouTab(),
            _buildTrendingTab(),
            _buildLatestTab(),
            _buildFollowingTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      autofocus: true,
      decoration: InputDecoration(
        hintText: 'Search memes, creators, or tags...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
      ),
      style: const TextStyle(color: Colors.white),
      onChanged: (value) {
        // TODO: Implement search functionality
      },
    );
  }

  Widget _buildForYouTab() {
    return CustomScrollView(
      slivers: [
        // Trending Hashtags
        SliverToBoxAdapter(child: _buildTrendingHashtags()),
        // Meme Grid
        SliverPadding(
          padding: const EdgeInsets.all(1),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) => _buildMemeGridItem(index),
              childCount: 30, // Sample count
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTrendingHashtags() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: _trendingTags.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(right: 8),
            child: Chip(
              label: Text(
                '#${_trendingTags[index]}',
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: AppTheme.cardBg,
            ),
          );
        },
      ),
    );
  }

  Widget _buildMemeGridItem(int index) {
    return InkWell(
      onTap: () => _showMemeDetails(index),
      child: Container(
        color: AppTheme.cardBg,
        child: Center(child: Text('Meme $index')),
      ),
    );
  }

  Widget _buildTrendingTab() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return _buildTrendingItem(index);
      },
    );
  }

  Widget _buildTrendingItem(int index) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      color: AppTheme.cardBg,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppTheme.vibrantBlue.withOpacity(0.2),
          child: Text('#${index + 1}'),
        ),
        title: Text('#trending_meme_${index + 1}'),
        subtitle: Text('${1000 - (index * 100)} posts today'),
        trailing: const Icon(Icons.trending_up),
      ),
    );
  }

  Widget _buildLatestTab() {
    return const Center(child: Text('Latest Memes'));
  }

  Widget _buildFollowingTab() {
    return const Center(child: Text('Following Feed'));
  }

  void _showMemeDetails(int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.cardBg,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        builder: (context, scrollController) => Column(
          children: [
            AppBar(
              title: const Text('Meme Details'),
              leading: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Expanded(
              child: ListView(
                controller: scrollController,
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      color: Colors.black12,
                      child: Center(child: Text('Meme $index Content')),
                    ),
                  ),
                  // Add meme details, comments, etc.
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
