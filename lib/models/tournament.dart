class Tournament {
  final String id;
  final String name;
  final String theme;
  final String prize;
  final DateTime startTime;
  final DateTime endTime;
  final int participantsCount;
  final int maxParticipants;
  final String status; // 'upcoming', 'active', 'completed'

  Tournament({
    required this.id,
    required this.name,
    required this.theme,
    required this.prize,
    required this.startTime,
    required this.endTime,
    required this.participantsCount,
    required this.maxParticipants,
    required this.status,
  });
}

class TournamentBracket {
  final String roundName;
  final List<Map<String, dynamic>> matches;

  TournamentBracket({required this.roundName, required this.matches});
}
