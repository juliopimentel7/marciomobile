import 'package:flutter/foundation.dart';
import '../../data/models/jogo.dart';
import '../../data/repositories/jogos_repository.dart';

enum JogosStatus { idle, loading, success, error }

class JogosProvider extends ChangeNotifier {
  final JogosRepository _repository;

  JogosProvider(this._repository) {
    // Carrega os dados com os valores padrão ao inicializar
    fetch();
  }

  JogosStatus _status = JogosStatus.idle;
  List<Jogo> _jogos = [];
  String _erro = '';
  String _fonte = 'footystats';
  DateTime _data = DateTime.now();

  JogosStatus get status => _status;
  List<Jogo> get jogos => _jogos;
  String get erro => _erro;
  String get fonte => _fonte;
  DateTime get data => _data;

  /// Data formatada como yyyy-MM-dd para a API
  String get dataFormatada {
    return '${_data.year.toString().padLeft(4, '0')}'
        '-${_data.month.toString().padLeft(2, '0')}'
        '-${_data.day.toString().padLeft(2, '0')}';
  }

  /// Atualiza a fonte e recarrega
  Future<void> setFonte(String novaFonte) async {
    if (_fonte == novaFonte) return;
    _fonte = novaFonte;
    await fetch();
  }

  /// Atualiza a data e recarrega
  Future<void> setData(DateTime novaData) async {
    _data = novaData;
    await fetch();
  }

  /// Busca os jogos do dia com os filtros atuais
  Future<void> fetch() async {
    _status = JogosStatus.loading;
    _erro = '';
    notifyListeners();

    try {
      _jogos = await _repository.getJogosDoDia(
        fonte: _fonte,
        data: dataFormatada,
      );
      _status = JogosStatus.success;
    } catch (e) {
      _erro = 'Não foi possível carregar os jogos para "$_fonte".\n'
          'Verifique se esta fonte está disponível.';
      _status = JogosStatus.error;
    }

    notifyListeners();
  }
}
