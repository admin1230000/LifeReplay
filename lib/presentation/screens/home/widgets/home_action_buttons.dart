// lib/presentation/screens/home/widgets/home_action_buttons.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Two primary action buttons for the home screen:
/// - "Yeni Simulasyon" (filled purple, with scale animation on tap)
/// - "Gecmis Kararlar" (outlined purple)
class HomeActionButtons extends StatelessWidget {
  const HomeActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ── Yeni Simulasyon (primary) ──────────────────────────────
        _buildPrimaryButton(context),
        const SizedBox(height: 14),

        // ── Gecmis Kararlar (outlined) ─────────────────────────────
        _buildSecondaryButton(context),
      ],
    );
  }

  Widget _buildPrimaryButton(BuildContext context) {
    return SizedBox(
      height: 56,
      child: ElevatedButton.icon(
        onPressed: () => context.go('/parameters'),
        icon: const Icon(Icons.add_circle_outline, size: 22),
        label: const Text(
          'Yeni Simulasyon',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6C63FF),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          shadowColor: const Color(0xFF6C63FF).withValues(alpha: 0.3),
        ),
      ),
    );
  }

  Widget _buildSecondaryButton(BuildContext context) {
    return SizedBox(
      height: 56,
      child: OutlinedButton.icon(
        onPressed: () => context.go('/history'),
        icon: const Icon(Icons.history, size: 22),
        label: const Text(
          'Gecmis Kararlar',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF6C63FF),
          side: BorderSide(
            color: const Color(0xFF6C63FF).withValues(alpha: 0.35),
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
