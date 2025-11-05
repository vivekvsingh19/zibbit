import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:memeapp/services/ai_service.dart';

class AIController extends ChangeNotifier {
  final AITournamentManager _tournamentManager = AITournamentManager();
  Timer? _tournamentTimer;
  Timer? _battleTimer;

  List<Map<String, dynamic>> activeTournaments = [];
  List<Map<String, dynamic>> activeBattles = [];

  AIController() {
    _initializeAutomation();
  }

  void _initializeAutomation() {
    // Generate new tournament every 24 hours
    _tournamentTimer = Timer.periodic(
      const Duration(hours: 24),
      (_) => _generateNewTournament(),
    );

    // Update battles every 5 minutes
    _battleTimer = Timer.periodic(
      const Duration(minutes: 5),
      (_) => _updateBattles(),
    );

    // Initial generation
    _generateNewTournament();
    _updateBattles();
  }

  void _generateNewTournament() {
    final newTournament = _tournamentManager.generateTournament();
    final rounds = _tournamentManager.generateTournamentRounds(
      newTournament['participants'],
    );

    newTournament['rounds'] = rounds;
    activeTournaments.add(newTournament);

    // Remove completed tournaments
    activeTournaments.removeWhere((tournament) {
      final endTime = tournament['startTime'].add(tournament['duration']);
      return DateTime.now().isAfter(endTime);
    });

    notifyListeners();
  }

  void _updateBattles() {
    // Remove completed battles
    activeBattles.removeWhere((battle) {
      return DateTime.now().isAfter(battle['endTime']);
    });

    // Generate new battles if needed
    while (activeBattles.length < 5) {
      final meme1 = AIMemeGenerator.generateMeme('Random');
      final meme2 = AIMemeGenerator.generateMeme('Random');

      activeBattles.add({
        'meme1': meme1,
        'meme2': meme2,
        'startTime': DateTime.now(),
        'endTime': DateTime.now().add(const Duration(minutes: 30)),
        'votes': AIBattleManager.simulateBattleVotes(),
      });
    }

    // Update votes for existing battles
    for (var battle in activeBattles) {
      if (!DateTime.now().isAfter(battle['endTime'])) {
        battle['votes'] = AIBattleManager.simulateBattleVotes();
      }
    }

    notifyListeners();
  }

  // Get active tournament data
  List<Map<String, dynamic>> getActiveTournaments() {
    return activeTournaments.where((tournament) {
      final endTime = tournament['startTime'].add(tournament['duration']);
      return DateTime.now().isBefore(endTime);
    }).toList();
  }

  // Get upcoming tournament data
  List<Map<String, dynamic>> getUpcomingTournaments() {
    return activeTournaments.where((tournament) {
      return DateTime.now().isBefore(tournament['startTime']);
    }).toList();
  }

  // Get active battles
  List<Map<String, dynamic>> getActiveBattles() {
    return activeBattles.where((battle) {
      return DateTime.now().isBefore(battle['endTime']);
    }).toList();
  }

  @override
  void dispose() {
    _tournamentTimer?.cancel();
    _battleTimer?.cancel();
    super.dispose();
  }
}
