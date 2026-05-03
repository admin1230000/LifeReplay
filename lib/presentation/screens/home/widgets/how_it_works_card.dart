// lib/presentation/screens/home/widgets/how_it_works_card.dart

import 'package:flutter/material.dart';

/// An elevated info card explaining how the app works.
///
/// Displays a header with an info icon and "Nasil Calisir?" title,
/// followed by four numbered steps with bullet-point styling.
class HowItWorksCard extends StatelessWidget {
  const HowItWorksCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ──────────────────────────────────────────────
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: const Color(0xFF6C63FF).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.info_outline,
                    color: Color(0xFF6C63FF),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Nasil Calisir?',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // ── Steps ───────────────────────────────────────────────
            _buildStep(
              number: '1',
              text: 'Kararinizi ve parametrelerinizi girin.',
            ),
            const SizedBox(height: 12),
            _buildStep(
              number: '2',
              text: 'Yapay zeka 3 farkli senaryo olustursun.',
            ),
            const SizedBox(height: 12),
            _buildStep(
              number: '3',
              text: 'Her senaryonun puanini ve onerisini gorun.',
            ),
            const SizedBox(height: 12),
            _buildStep(
              number: '4',
              text: 'Detayli analizlerle en iyi karari verin.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep({
    required String number,
    required String text,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Number badge
        Container(
          width: 28,
          height: 28,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xFF6C63FF),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            number,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                height: 1.4,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
