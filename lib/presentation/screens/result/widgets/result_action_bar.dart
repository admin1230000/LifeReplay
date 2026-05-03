// lib/presentation/screens/result/widgets/result_action_bar.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../providers/providers.dart';

/// A sticky bottom action bar with two buttons:
/// - "Yeni Karar" (outlined) — resets the simulation and navigates to parameters
/// - "Analizi Gor" (filled) — navigates to the analytics screen
class ResultActionBar extends ConsumerWidget {
  const ResultActionBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: Row(
            children: [
              // Yeni Karar (outlined)
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      ref.read(simulationControllerProvider.notifier).reset();
                      context.go('/parameters');
                    },
                    icon: const Icon(Icons.add, size: 20),
                    label: const Text('Yeni Karar'),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: BorderSide(
                        color: const Color(0xFF6C63FF).withValues(alpha: 0.4),
                      ),
                      foregroundColor: const Color(0xFF6C63FF),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Analizi Gor (filled)
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: () => context.go('/analytics'),
                    icon: const Icon(Icons.bar_chart, size: 20),
                    label: const Text('Analizi Gor'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C63FF),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
