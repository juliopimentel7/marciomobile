import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_theme.dart';
import '../providers/jogos_provider.dart';
import '../widgets/jogo_card.dart';
import '../widgets/sidebar_drawer.dart';
import '../widgets/skeleton_loader.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      drawer: const SidebarDrawer(),
      appBar: _buildAppBar(context),
      body: const _HomeBody(),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppTheme.surface,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: Builder(
        builder: (ctx) => IconButton(
          icon: const Icon(Icons.menu, color: AppTheme.textSecondary),
          onPressed: () => Scaffold.of(ctx).openDrawer(),
          tooltip: 'Abrir menu',
        ),
      ),
      title: Consumer<JogosProvider>(
        builder: (_, provider, __) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Jogos do Dia',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppTheme.textPrimary,
              ),
            ),
            Text(
              '${provider.fonte} · ${provider.dataFormatada}',
              style: const TextStyle(
                fontSize: 12,
                color: AppTheme.textSecondary,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
      actions: [
        Consumer<JogosProvider>(
          builder: (_, provider, __) => IconButton(
            icon: const Icon(Icons.refresh_outlined, color: AppTheme.textSecondary),
            onPressed: provider.status == JogosStatus.loading
                ? null
                : () => provider.fetch(),
            tooltip: 'Atualizar',
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Divider(height: 1, thickness: 1, color: AppTheme.border),
      ),
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody();

  @override
  Widget build(BuildContext context) {
    return Consumer<JogosProvider>(
      builder: (_, provider, __) {
        switch (provider.status) {
          case JogosStatus.loading:
          case JogosStatus.idle:
            return const SkeletonLoader();

          case JogosStatus.error:
            return _ErrorState(
              message: provider.erro,
              onRetry: provider.fetch,
            );

          case JogosStatus.success:
            if (provider.jogos.isEmpty) {
              return const _EmptyState();
            }
            return _JogosList(jogos: provider.jogos);
        }
      },
    );
  }
}

class _JogosList extends StatelessWidget {
  final List jogos;
  const _JogosList({required this.jogos});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: jogos.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, index) => JogoCard(jogo: jogos[index]),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Text(
          'Nenhum jogo encontrado.',
          style: TextStyle(color: AppTheme.textSecondary, fontSize: 14),
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorState({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.wifi_off_outlined, size: 48, color: AppTheme.textMuted),
            const SizedBox(height: 16),
            Text(
              message,
              style: const TextStyle(color: AppTheme.textSecondary, fontSize: 14),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh, size: 16),
              label: const Text('Tentar novamente'),
            ),
          ],
        ),
      ),
    );
  }
}
