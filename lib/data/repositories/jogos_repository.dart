import '../models/jogo.dart';
import '../services/api_service.dart';

class JogosRepository {
  final ApiService _apiService;

  const JogosRepository(this._apiService);

  /// Busca todos os jogos do dia para a fonte e data informadas.
  Future<List<Jogo>> getJogosDoDia({
    required String fonte,
    required String data,
  }) async {
    final json = await _apiService.get('dados/jogos-do-dia/$fonte/$data');
    final lista = json['dados'] as List<dynamic>? ?? [];
    return lista
        .map((e) => Jogo.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// Busca um jogo específico pelo ID dentro da lista do dia.
  Future<Jogo?> getJogoPorId({
    required int id,
    required String fonte,
    required String data,
  }) async {
    final jogos = await getJogosDoDia(fonte: fonte, data: data);
    try {
      return jogos.firstWhere((j) => j.id == id);
    } catch (_) {
      return null;
    }
  }
}
