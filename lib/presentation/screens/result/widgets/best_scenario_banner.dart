// lib/presentation/screens/result/widgets/best_scenario_banner.dart

import 'package:flutter/material.dart';

import '../../../../domain/entities/scenario.dart';

/// A banner highlighting the scenario with the highest probability.
/// Shows a trophy icon, "En Iyi Senaryo" label, scenario type name,
/// and a score badge.
class BestScenarioBanner extends StatelessWidget {
  final Scenario bestScenario;

  const BestScenarioBanner({super.key, required this.bestScenario});

  String _typeLabel(ScenarioType type) {
    switch (type) {
      case ScenarioType.good:
        return 'Iyi Senaryo';
      case ScenarioType.neutral:
        return 'Notr Senaryo';
      case ScenarioType.bad:
        return 'Kotu Senaryo';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.green.withValues(alpha: 0.08),
            Colors.green.withValues(alpha: 0.03),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.green.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          // Trophy icon
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.amber.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.emoji_events,
              color: Colors.amber,
              size: 26,
            ),
          ),
          const SizedBox(width: 12),
          // Labels
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'En Iyi Senaryo',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: Colors.green[700],
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _typeLabel(bestScenario.type),
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // Score badge
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${(bestScenario.probability * 100).toStringAsFixed(0)} puan',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
