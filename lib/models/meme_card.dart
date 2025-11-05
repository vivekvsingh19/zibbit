class MemeCard {
  final String id;
  final String name;
  final String imageUrl;
  final int powerLevel;
  final String rarity; // common, rare, epic, legendary
  final bool isPremium;
  final Map<String, int> stats; // e.g., {'humor': 80, 'viral': 70, 'defense': 60}

  MemeCard({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.powerLevel,
    required this.rarity,
    this.isPremium = false,
    required this.stats,
  });

  factory MemeCard.fromJson(Map<String, dynamic> json) {
    return MemeCard(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      powerLevel: json['powerLevel'],
      rarity: json['rarity'],
      isPremium: json['isPremium'] ?? false,
      stats: Map<String, int>.from(json['stats']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'powerLevel': powerLevel,
      'rarity': rarity,
      'isPremium': isPremium,
      'stats': stats,
    };
  }
}