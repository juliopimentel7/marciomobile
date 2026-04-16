class AppConstants {
  // API
  static const String apiBaseUrl = 'https://api.futpythontrader.com/api/';
  static const String apiToken = '6dbf5dc2c6d9ff8883a370fc16381d4c4a001f3a';

  // Fontes disponíveis
  static const List<Map<String, String>> fontes = [
    {'label': 'FootyStats', 'value': 'footystats'},
    {'label': 'BetFair', 'value': 'betfair'},
    {'label': 'Bet365', 'value': 'bet365'},
  ];

  // Campos excluídos na tela de odds (mesmos do web)
  static const Set<String> camposExcluidos = {
    'Id',
    'Home',
    'Away',
    'League',
    'Season',
    'Round',
    'Date',
    'Time',
  };
}
