import 'package:flutter/material.dart';
import 'package:memeapp/core/app_theme.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shop')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Premium Subscription Card
          _buildSubscriptionCard(context),
          const SizedBox(height: 24),

          // Rewarded Ad Offers Section
          _buildRewardedAdSection(context),
          const SizedBox(height: 24),

          // Premium Currency Packages
          _buildCurrencyPackages(context),
        ],
      ),
    );
  }

  Widget _buildSubscriptionCard(BuildContext context) {
    return Card(
      color: AppTheme.cardBg,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [
              AppTheme.vibrantBlue.withOpacity(0.8),
              AppTheme.vibrantGreen.withOpacity(0.8),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.star, color: Colors.yellow),
                SizedBox(width: 8),
                Text(
                  'Premium Subscription',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildFeatureItem('No Ads - Pure Gaming Experience'),
            _buildFeatureItem('Exclusive Premium Card Templates'),
            _buildFeatureItem('Priority Matchmaking'),
            _buildFeatureItem('2x Battle Points'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppTheme.vibrantBlue,
                padding: const EdgeInsets.symmetric(vertical: 12),
                minimumSize: const Size(double.infinity, 0),
              ),
              child: const Text(
                'Subscribe Now - \$4.99/month',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRewardedAdSection(BuildContext context) {
    return Card(
      color: AppTheme.cardBg,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Rewarded Ad Offers',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildRewardedAdItem(
              'Watch a video to earn 50 coins',
              Icons.monetization_on,
              AppTheme.vibrantGreen,
            ),
            const SizedBox(height: 12),
            _buildRewardedAdItem(
              'Watch a video to unlock a template',
              Icons.card_giftcard,
              AppTheme.vibrantBlue,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrencyPackages(BuildContext context) {
    return Card(
      color: AppTheme.cardBg,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Premium Currency',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildCurrencyPackageItem('500 Coins', '\$0.99', 'Best Value!'),
            const SizedBox(height: 8),
            _buildCurrencyPackageItem('1000 Coins', '\$1.99', ''),
            const SizedBox(height: 8),
            _buildCurrencyPackageItem('2500 Coins', '\$4.99', 'Popular'),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.white, size: 20),
          const SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }

  Widget _buildRewardedAdItem(String text, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: color.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 12),
          Expanded(child: Text(text)),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              foregroundColor: Colors.white,
            ),
            child: const Text('Watch'),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrencyPackageItem(String amount, String price, String tag) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.vibrantBlue.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.monetization_on, color: Colors.amber),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  amount,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                if (tag.isNotEmpty)
                  Text(
                    tag,
                    style: TextStyle(
                      color: AppTheme.vibrantGreen,
                      fontSize: 12,
                    ),
                  ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.vibrantBlue,
              foregroundColor: Colors.white,
            ),
            child: Text(price),
          ),
        ],
      ),
    );
  }
}
