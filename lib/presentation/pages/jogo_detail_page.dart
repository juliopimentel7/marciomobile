import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/jogo.dart';
import '../../data/repositories/jogos_repository.dart';
import '../../data/services/api_service.dart';

class JogoDetailPage extends StatefulWidget {
  final int jogoId;
  final String fonte;
  final String data;

  const JogoDetailPage({
    super.key,
    required this.jogoId,
    required this.fonte,
    required this.data,
  });

  @override
  State<JogoDetailPage> createState() => _JogoDetailPageState();
}

class _JogoDetailPageState extends State<JogoDetailPage> {
  late final JogosRepository _repository;

  Jogo? _jogo;
  bool _carregando = true;
  String? _erro;

  @override
  void initState() {
    super.initState();
    _repository = JogosRepository(ApiService());
    _carregarJogo();
  }

  Future<void> _carregarJogo() async {
    try {
      final jogo = await _repository.getJogoPorId(
        id: widget.jogoId,
        fonte: widget.fonte,
        data: widget.data,
      );
      if (mounted) {
        setState(() {
          _jogo = jogo;
          _carregando = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _erro = 'Não foi possível carregar os dados do jogo.';
          _carregando = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.textSecondary),
          onPressed: () => Navigator.pop(context),
          tooltip: 'Voltar',
        ),
        title: _jogo == null
            ? const Text('Carregando...')
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${_jogo!.home} vs ${_jogo!.away}',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textPrimary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${_jogo!.league} · ${_jogo!.date}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.textSecondary,
                      fontWeight: FontWeight.w400,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(height: 1, thickness: 1, color: AppTheme.border),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_carregando) {
      return const Center(
        child: CircularProgressIndicator(color: AppTheme.primary),
      );
    }

    if (_erro != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            _erro!,
            style: const TextStyle(color: Colors.red, fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (_jogo == null) {
      return const Center(
        child: Text(
          'Jogo não encontrado.',
          style: TextStyle(color: AppTheme.textSecondary, fontSize: 14),
        ),
      );
    }

    final odds = _jogo!.odds.entries.toList();

    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
          sliver: SliverToBoxAdapter(
            child: Text(
              'ODDS',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: AppTheme.textMuted,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 2.2,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final entry = odds[index];
                return _OddCard(label: entry.key, value: entry.value);
              },
              childCount: odds.length,
            ),
          ),
        ),
        const SliverPadding(padding: EdgeInsets.only(bottom: 24)),
      ],
    );
  }
}

class _OddCard extends StatelessWidget {
  final String label;
  final dynamic value;

  const _OddCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final displayValue = (value == null) ? '—' : value.toString();

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              color: AppTheme.textMuted,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            displayValue,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
