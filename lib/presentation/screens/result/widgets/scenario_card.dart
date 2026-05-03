// lib/presentation/screens/result/widgets/scenario_card.dart

import 'package:flutter/material.dart';

import '../../../../domain/entities/scenario.dart';

/// A card that displays a single scenario with expandable description,
/// positive/negative effects, and a recommendation box.
class ScenarioCard extends StatefulWidget {
  final Scenario scenario;
  final int index;

  const ScenarioCard({
    super.key,
    required this.scenario,
    required this.index,
  });

  @override
  State<ScenarioCard> createState() => _ScenarioCardState();
}

class _ScenarioCardState extends State<ScenarioCard> {
  bool _showFullDescription = false;

  Color _typeColor(ScenarioType type) {
    switch (type) {
      case ScenarioType.good:
        return const Color(0xFF4CAF50);
      case ScenarioType.neutral:
        return const Color(0xFFFF9800);
      case ScenarioType.bad:
        return const Color(0xFFF44336);
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
        return 'Iyi';
      case ScenarioType.neutral:
        return 'Notr';
      case ScenarioType.bad:
        return 'Kotu';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = _typeColor(widget.scenario.type);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header row ──────────────────────────────────────────
            Row(
              children: [
                Icon(_typeIcon(widget.scenario.type), color: color, size: 24),
                const SizedBox(width: 8),
                Text(
                  _typeLabel(widget.scenario.type),
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const Spacer(),
                // Probability badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '% ${(widget.scenario.probability * 100).toStringAsFixed(0)}',
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // ── Description (expandable) ────────────────────────────
            GestureDetector(
              onTap: () => setState(() => _showFullDescription = !_showFullDescription),
              child: AnimatedCrossFade(
                duration: const Duration(milliseconds: 200),
                crossFadeState: _showFullDescription
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                firstChild: Text(
                  widget.scenario.description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[700],
                  ),
                ),
                secondChild: Text(
                  widget.scenario.description,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ),
            if (widget.scenario.description.length > 120)
              GestureDetector(
                onTap: () => setState(() => _showFullDescription = !_showFullDescription),
                child: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    _showFullDescription ? 'Daha az goster' : 'Devamini oku',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 12),

            // ── Positive effects ────────────────────────────────────
            if (widget.scenario.positiveEffects.isNotEmpty) ...[
              Text(
                'Olumlu Etkiler',
                style: theme.textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.green[700],
                ),
              ),
              const SizedBox(height: 4),
              ...widget.scenario.positiveEffects.map(
                (e) => Padding(
                  padding: const EdgeInsets.only(left: 4, bottom: 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.check_circle,
                          size: 16, color: Colors.green[500]),
                      const SizedBox(width: 6),
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

            // ── Negative effects ────────────────────────────────────
            if (widget.scenario.negativeEffects.isNotEmpty) ...[
              Text(
                'Olumsuz Etkiler',
                style: theme.textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.red[700],
                ),
              ),
              const SizedBox(height: 4),
              ...widget.scenario.negativeEffects.map(
                (e) => Padding(
                  padding: const EdgeInsets.only(left: 4, bottom: 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.cancel, size: 16, color: Colors.red[400]),
                      const SizedBox(width: 6),
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

            // ── Recommendation box ──────────────────────────────────
            if (widget.scenario.recommendation.isNotEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF6C63FF).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.lightbulb_outline,
                      color: const Color(0xFF6C63FF),
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Oneri',
                            style: theme.textTheme.labelSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF6C63FF),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            widget.scenario.recommendation,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: const Color(0xFF6C63FF),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
