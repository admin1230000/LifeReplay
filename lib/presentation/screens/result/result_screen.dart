// lib/presentation/screens/result/result_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/providers.dart';
import 'widgets/best_scenario_banner.dart';
import 'widgets/decision_summary_card.dart';
import 'widgets/result_action_bar.dart';
import 'widgets/scenario_card.dart';
import 'widgets/scenario_pie_chart.dart';

/// The main result screen that displays the simulation outcome.
///
/// Structure (top to bottom):
/// 1. SliverAppBar (collapsible) with purple background
/// 2. Decision summary card
/// 3. Best scenario banner
/// 4. Pie chart with risk score center
/// 5. Scenario cards (3 items)
/// 6. Sticky bottom action bar
class ResultScreen extends ConsumerWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final simState = ref.watch(simulationControllerProvider);

    // ── Initial state ──────────────────────────────────────────────
    if (simState is SimulationInitial) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.analytics_outlined, size: 64, color: Colors.grey[400]),
              const SizedBox(height: 16),
              Text(
                'Henuz bir simulasyon yapilmadi.',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[500],
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.go('/parameters'),
                child: const Text('Yeni Simulasyon Baslat'),
              ),
            ],
          ),
        ),
      );
    }

    // ── Loading state ──────────────────────────────────────────────
    if (simState is SimulationLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // ── Error state ────────────────────────────────────────────────
    if (simState is SimulationError) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                const SizedBox(height: 16),
                Text(
                  'Bir hata olustu',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  simState.message,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    ref.read(simulationControllerProvider.notifier).reset();
                    context.go('/parameters');
                  },
                  child: const Text('Tekrar Dene'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // ── Success state ──────────────────────────────────────────────
    final success = simState as SimulationSuccess;
    final scenarios = success.scenarios;
    final decision = success.decision;

    // Find the scenario with highest probability
    final bestScenario = scenarios.isEmpty
        ? null
        : scenarios.reduce(
            (a, b) => a.probability >= b.probability ? a : b,
          );

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          // ── Scrollable content ────────────────────────────────────
          Expanded(
            child: CustomScrollView(
              slivers: [
                // SliverAppBar
                SliverAppBar(
                  expandedHeight: 120,
                  collapsedHeight: 64,
                  floating: true,
                  pinned: true,
                  backgroundColor: const Color(0xFF6C63FF),
                  foregroundColor: Colors.white,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new,
                        color: Colors.white, size: 20),
                    onPressed: () {
                      if (GoRouter.of(context).canPop()) {
                        context.pop();
                      } else {
                        context.go('/');
                      }
                    },
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding: const EdgeInsets.only(
                      left: 16,
                      bottom: 16,
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Sonuc',
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          decision.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Content
                SliverList(
                  delegate: SliverChildListDelegate([
                    const SizedBox(height: 16),

                    // 2. Decision summary card
                    DecisionSummaryCard(decision: decision),
                    const SizedBox(height: 12),

                    // 3. Best scenario banner
                    if (bestScenario != null) ...[
                      BestScenarioBanner(bestScenario: bestScenario),
                      const SizedBox(height: 8),
                    ],

                    // 4. Pie chart
                    ScenarioPieChart(
                      scenarios: scenarios,
                      riskScore: decision.riskScore,
                    ),
                    const SizedBox(height: 8),

                    // 5. Scenario cards
                    ...scenarios.asMap().entries.map((entry) {
                      return ScenarioCard(
                        scenario: entry.value,
                        index: entry.key,
                      );
                    }),

                    const SizedBox(height: 16),
                  ]),
                ),
              ],
            ),
          ),

          // 6. Sticky bottom action bar
          const ResultActionBar(),
        ],
      ),
    );
  }
}
