// lib/presentation/widgets/scenario_card.dart

import 'package:flutter/material.dart';

import '../../domain/entities/scenario.dart';

/// A card widget that displays a single scenario's type, description,
/// probability, effects, and recommendation.
class ScenarioCard extends StatelessWidget {
  final Scenario scenario;
  final int index;

  const ScenarioCard({
    super.key,
    required this.scenario,
    required this.index,
  });

  Color _typeColor(ScenarioType type) {
    switch (type) {
      case ScenarioType.good:
        return Colors.green;
      case ScenarioType.neutral:
        return Colors.blue;
      case ScenarioType.bad:
        return Colors.red;
    }
  }

  IconData _typeIcon(ScenarioType type) {
    switch (type) {
      case ScenarioType.good:
        return Icons.emoji_events;
      case ScenarioType.neutral:
        return Icons.trending_up;
      case ScenarioType.bad:
        return Icons.warning_amber_rounded;
    }
  }

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
    final color = _typeColor(scenario.type);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row: type badge + icon
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${index + 1}. ${_typeLabel(scenario.type)}',
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
                Icon(_typeIcon(scenario.type), color: color, size: 28),
              ],
            ),
            const SizedBox(height: 12),

            // Description
            Text(
              scenario.description,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 12),

            // Positive effects
            if (scenario.positiveEffects.isNotEmpty) ...[
              Text(
                'Olumlu Etkiler:',
                style: theme.textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.green[700],
                ),
              ),
              const SizedBox(height: 4),
              ...scenario.positiveEffects.map(
                (e) => Padding(
                  padding: const EdgeInsets.only(left: 8, bottom: 2),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('• ', style: TextStyle(color: Colors.green)),
                      Expanded(
                        child: Text(
                          e,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],

            // Negative effects
            if (scenario.negativeEffects.isNotEmpty) ...[
              Text(
                'Olumsuz Etkiler:',
                style: theme.textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.red[700],
                ),
              ),
              const SizedBox(height: 4),
              ...scenario.negativeEffects.map(
                (e) => Padding(
                  padding: const EdgeInsets.only(left: 8, bottom: 2),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('• ', style: TextStyle(color: Colors.red)),
                      Expanded(
                        child: Text(
                          e,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],

            // Recommendation
            if (scenario.recommendation.isNotEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.lightbulb_outline,
                      color: theme.colorScheme.primary,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        scenario.recommendation,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 12),

            // Probability bar
            Row(
              children: [
                Text(
                  'Olasilik: ${(scenario.probability * 100).toStringAsFixed(0)}%',
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: LinearProgressIndicator(
                      value: scenario.probability,
                      backgroundColor: Colors.grey[200],
                      color: color,
                      minHeight: 10,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
