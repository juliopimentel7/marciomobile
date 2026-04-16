import 'package:flutter/foundation.dart';
import '../../data/models/jogo.dart';
import '../../data/services/favoritos_service.dart';

class FavoritosProvider extends ChangeNotifier {
  final FavoritosService _service;

  FavoritosProvider(this._service);

  List<JogoFavorito> _favoritos = [];
  final Set<String> _favoritosIds = {};

  List<JogoFavorito> get favoritos => _favoritos;

  /// Inicia o stream do Firestore e mantém a lista sincronizada
  void init() {
    _service.stream().listen((lista) {
      _favoritos = lista;
      _favoritosIds
        ..clear()
        ..addAll(lista.map((f) => '${f.fonte}_${f.jogoId}'));
      notifyListeners();
    });
  }

  bool isFavorito(String fonte, int jogoId) =>
      _favoritosIds.contains('${fonte}_$jogoId');

  Future<void> toggle(Jogo jogo, String fonte) async {
    if (isFavorito(fonte, jogo.id)) {
      await _service.remover(fonte, jogo.id);
    } else {
      await _service.adicionar(jogo, fonte);
    }
    // O stream atualiza _favoritos automaticamente
  }
}
