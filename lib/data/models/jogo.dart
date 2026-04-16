class Jogo {
  final int id;
  final String home;
  final String away;
  final String league;
  final String time;
  final String date;
  final Map<String, dynamic> raw;

  const Jogo({
    required this.id,
    required this.home,
    required this.away,
    required this.league,
    required this.time,
    required this.date,
    required this.raw,
  });

  factory Jogo.fromJson(Map<String, dynamic> json) {
    // ignore: avoid_print
    print('[Jogo.fromJson] Id=${json['Id']} (${json['Id'].runtimeType}), Home=${json['Home']}');
    return Jogo(
      id: int.tryParse(json['Id']?.toString() ?? '') ?? 0,
      home: json['Home'] as String? ?? '',
      away: json['Away'] as String? ?? '',
      league: json['League'] as String? ?? '',
      time: json['Time'] as String? ?? '',
      date: json['Date'] as String? ?? '',
      raw: json,
    );
  }

  /// Retorna apenas os campos de odds (exclui campos de identificação)
  Map<String, dynamic> get odds {
    const excluidos = {
      'Id', 'Home', 'Away', 'League', 'Season', 'Round', 'Date', 'Time',
    };
    return Map.fromEntries(
      raw.entries.where((e) => !excluidos.contains(e.key)),
    );
  }

  /// Horário formatado (apenas HH:mm)
  String get horario {
    if (time.length >= 5) return time.substring(0, 5);
    return time;
  }
}
