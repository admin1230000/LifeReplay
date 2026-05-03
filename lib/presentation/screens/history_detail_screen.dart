// lib/presentation/screens/history_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/scenario.dart';
import '../providers/providers.dart';
import 'result/widgets/best_scenario_banner.dart';
import 'result/widgets/decision_summary_card.dart';
import 'result/widgets/scenario_card.dart';
import 'result/widgets/scenario_pie_chart.dart';

/// Displays the full detail of a historical decision (parameters, scenarios,
/// risk score, etc.) fetched from the local database by its ID.
/// This screen is independent of the live simulation state, so navigating
/// here does not overwrite the result in the Sonuc tab.
class HistoryDetailScreen extends ConsumerWidget {
  final String decisionId;

  const HistoryDetailScreen({super.key, required this.decisionId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final detailAsync = ref.watch(historyDetailProvider(decisionId));

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('Karar Detayi'),
        backgroundColor: const Color(0xFF6C63FF),
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () {
            if (GoRouter.of(context).canPop()) {
              context.pop();
            } else {
              context.go('/');
            }
          },
        ),
      ),
      body: detailAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => _buildError(theme, error.toString()),
        data: (output) {
          if (output == null) {
            return _buildError(theme, 'Veri bulunamadi.');
          }
          return _buildContent(
            theme,
            output.decision,
            output.scenarios,
          );
        },
      ),
    );
  }

  Widget _buildContent(
    ThemeData theme,
    dynamic decision,
    List<Scenario> scenarios,
  ) {
    // Find the scenario with highest probability
    final bestScenario = scenarios.isEmpty
        ? null
        : scenarios.reduce(
            (a, b) => a.probability >= b.probability ? a : b,
          );

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 16),

          // Decision summary card
          DecisionSummaryCard(decision: decision),
          const SizedBox(height: 12),

          // Best scenario banner
          if (bestScenario != null) ...[
            BestScenarioBanner(bestScenario: bestScenario),
            const SizedBox(height: 8),
          ],

          // Pie chart
          ScenarioPieChart(
            scenarios: scenarios,
            riskScore: decision.riskScore,
          ),
          const SizedBox(height: 8),

          // Scenario cards
          ...scenarios.asMap().entries.map((entry) {
            return ScenarioCard(
              scenario: entry.value,
              index: entry.key,
            );
          }),

          const SizedBox(height: 16),
        ],
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
              message,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
