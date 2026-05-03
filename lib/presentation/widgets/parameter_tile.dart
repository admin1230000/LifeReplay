// lib/presentation/widgets/parameter_tile.dart

import 'package:flutter/material.dart';

/// A modern compact tile that displays a single parameter's key, value,
/// and unit, with a red delete icon.
///
/// Styled as a white chip with a subtle border and rounded corners.
class ParameterTile extends StatelessWidget {
  final String keyName;
  final String value;
  final String unit;
  final VoidCallback? onDelete;

  const ParameterTile({
    super.key,
    required this.keyName,
    required this.value,
    required this.unit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.withValues(alpha: 0.15),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            // ── Purple dot indicator ────────────────────────────────
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Color(0xFF6C63FF),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 10),

            // ── Key name ────────────────────────────────────────────
            Text(
              keyName,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),

            // ── Value + unit ────────────────────────────────────────
            if (value.isNotEmpty || unit.isNotEmpty) ...[
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF6C63FF).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '${value.isNotEmpty ? value : ''}'
                  '${value.isNotEmpty && unit.isNotEmpty ? ' ' : ''}'
                  '$unit',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: const Color(0xFF6C63FF),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],

            const Spacer(),

            // ── Delete button ───────────────────────────────────────
            if (onDelete != null)
              GestureDetector(
                onTap: onDelete,
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.close,
                    size: 16,
                    color: Colors.red,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
