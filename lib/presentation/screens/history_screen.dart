// lib/presentation/screens/history_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/providers.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/history_card.dart';

/// Gecmis ekrani - daha once yapilan tum simulasyonlari listeler.
/// Reaktif olarak calisir: yeni bir simulasyon kaydedildiginde
/// liste otomatik olarak guncellenir.
class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final historyAsync = ref.watch(decisionHistoryStreamProvider);

    return AppScaffold(
      title: 'Gecmis Kararlar',
      body: historyAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => _buildError(theme, error.toString()),
        data: (decisions) => _buildDecisionsList(theme, decisions, context, ref),
      ),
    );
  }

  Widget _buildDecisionsList(
    ThemeData theme,
    List<dynamic> decisions,
    BuildContext context,
    WidgetRef ref,
  ) {
    if (decisions.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.inbox_outlined, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'Henuz kaydedilmis bir karariniz yok.',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: Colors.grey[500],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/parameters'),
              child: const Text('Ilk Simulasyonu Baslat'),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        // Stream provider auto-refreshes, but we keep RefreshIndicator for UX
        await Future.delayed(const Duration(milliseconds: 300));
      },
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: decisions.length,
        itemBuilder: (context, index) {
          final decision = decisions[index];
          return HistoryCard(
            decision: decision,
            onTap: () {
              context.push('/history/${decision.id}');
            },
          );
        },
      ),
    );
  }

  Widget _buildError(ThemeData theme, String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
            const SizedBox(height: 16),
            Text(
              'Gecmis yuklenirken hata olustu.',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
