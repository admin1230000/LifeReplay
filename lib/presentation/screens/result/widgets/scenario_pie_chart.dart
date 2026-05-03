// lib/presentation/screens/result/widgets/scenario_pie_chart.dart

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entities/scenario.dart';

/// A pie chart that visualizes the probability distribution across the
/// three scenarios (good, neutral, bad). The center text shows the
/// overall risk score. Touching a section shows a tooltip with the
/// scenario name and its probability.
class ScenarioPieChart extends StatefulWidget {
  final List<Scenario> scenarios;
  final double riskScore;

  const ScenarioPieChart({
    super.key,
    required this.scenarios,
    required this.riskScore,
  });

  @override
  State<ScenarioPieChart> createState() => _ScenarioPieChartState();
}

class _ScenarioPieChartState extends State<ScenarioPieChart> {
  int? _touchedIndex;

  Color _sectionColor(ScenarioType type) {
    switch (type) {
      case ScenarioType.good:
        return const Color(0xFF4CAF50);
      case ScenarioType.neutral:
        return const Color(0xFFFF9800);
      case ScenarioType.bad:
        return const Color(0xFFF44336);
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

    if (widget.scenarios.isEmpty) {
      return const SizedBox.shrink();
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Senaryo Dagitimi',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 220,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  PieChart(
                    PieChartData(
                      sections: _buildSections(),
                      centerSpaceRadius: 60,
                      sectionsSpace: 2,
                      pieTouchData: PieTouchData(
                        touchCallback: (event, pieTouchResponse) {
                          if (!event.isInterestedForInteractions ||
                              pieTouchResponse == null ||
                              pieTouchResponse.touchedSection == null) {
                            setState(() => _touchedIndex = -1);
                            return;
                          }
                          setState(() {
                            _touchedIndex = pieTouchResponse
                                .touchedSection!.touchedSectionIndex;
                          });
                        },
                      ),
                    ),
                  ),
                  // Center text: risk score
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Risk',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.grey[500],
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '%${(widget.riskScore * 100).toStringAsFixed(0)}',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF6C63FF),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Legend chips
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.scenarios.asMap().entries.map((entry) {
                final index = entry.key;
                final scenario = entry.value;
                final color = _sectionColor(scenario.type);
                final isTouched = _touchedIndex == index;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: isTouched
                          ? color.withValues(alpha: 0.2)
                          : color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '${_typeLabel(scenario.type)} '
                          '${(scenario.probability * 100).toStringAsFixed(0)}%',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: color,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> _buildSections() {
    return widget.scenarios.asMap().entries.map((entry) {
      final index = entry.key;
      final scenario = entry.value;
      final isTouched = _touchedIndex == index;
      final radius = isTouched ? 48.0 : 40.0;

      return PieChartSectionData(
        color: _sectionColor(scenario.type),
        value: scenario.probability,
        title: '',
        radius: radius,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();
  }
}
