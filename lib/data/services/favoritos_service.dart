import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/jogo.dart';

class FavoritosService {
  final FirebaseFirestore _db;
  final FirebaseAuth _auth;

  FavoritosService({FirebaseFirestore? db, FirebaseAuth? auth})
      : _db = db ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  /// Garante que o usuário está autenticado anonimamente
  Future<String> _userId() async {
    if (_auth.currentUser != null) return _auth.currentUser!.uid;
    final credential = await _auth.signInAnonymously();
    return credential.user!.uid;
  }

  CollectionReference<Map<String, dynamic>> _colecao(String uid) =>
      _db.collection('favoritos').doc(uid).collection('jogos');

  /// ID único do favorito: combina fonte + id do jogo
  String _docId(String fonte, int jogoId) => '${fonte}_$jogoId';

  /// Stream em tempo real dos favoritos do usuário
  Stream<List<JogoFavorito>> stream() async* {
    final uid = await _userId();
    yield* _colecao(uid)
        .orderBy('savedAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((d) => JogoFavorito.fromFirestore(d)).toList());
  }

  /// Adiciona um jogo aos favoritos
  Future<void> adicionar(Jogo jogo, String fonte) async {
    final uid = await _userId();
    final docId = _docId(fonte, jogo.id);
    await _colecao(uid).doc(docId).set({
      'jogoId': jogo.id,
      'home': jogo.home,
      'away': jogo.away,
      'league': jogo.league,
      'date': jogo.date,
      'time': jogo.time,
      'fonte': fonte,
      'savedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Remove um jogo dos favoritos
  Future<void> remover(String fonte, int jogoId) async {
    final uid = await _userId();
    await _colecao(uid).doc(_docId(fonte, jogoId)).delete();
  }

  /// Verifica se um jogo específico está favoritado
  Future<bool> isFavorito(String fonte, int jogoId) async {
    final uid = await _userId();
    final doc = await _colecao(uid).doc(_docId(fonte, jogoId)).get();
    return doc.exists;
  }
}

/// Modelo simples para um jogo favoritado (sem todos os campos de odds)
class JogoFavorito {
  final int jogoId;
  final String home;
  final String away;
  final String league;
  final String date;
  final String time;
  final String fonte;

  const JogoFavorito({
    required this.jogoId,
    required this.home,
    required this.away,
    required this.league,
    required this.date,
    required this.time,
    required this.fonte,
  });

  factory JogoFavorito.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final d = doc.data()!;
    return JogoFavorito(
      jogoId: d['jogoId'] as int,
      home: d['home'] as String,
      away: d['away'] as String,
      league: d['league'] as String,
      date: d['date'] as String,
      time: d['time'] as String,
      fonte: d['fonte'] as String,
    );
  }

  String get horario => time.length >= 5 ? time.substring(0, 5) : time;
}
