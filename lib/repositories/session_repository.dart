import 'dart:math';

import '../models/game_session.dart';

/// Preserva as partidas ao navegar entre telas durante a sessão do app.
class SessionRepository {
  SessionRepository._();

  static final instance = SessionRepository._();
  final _random = Random();
  final List<GameSession> _sessions = [];

  List<GameSession> get sessions => List.unmodifiable(_sessions);

  void create({required String name, required int participants}) {
    if (_sessions.length >= 90000) {
      throw StateError('Todos os códigos de sala estão em uso.');
    }

    var number = 10000 + _random.nextInt(90000);
    final usedCodes = _sessions.map((session) => session.code).toSet();
    while (usedCodes.contains(number.toString())) {
      number = number == 99999 ? 10000 : number + 1;
    }

    _sessions.add(
      GameSession(
        name: name,
        participants: participants,
        code: number.toString(),
      ),
    );
  }
}
