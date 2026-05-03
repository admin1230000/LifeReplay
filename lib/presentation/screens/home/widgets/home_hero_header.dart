// lib/presentation/screens/home/widgets/home_hero_header.dart

import 'package:flutter/material.dart';

/// The top hero section of the home screen.
///
/// Displays a large brain/gear icon inside a subtle purple glow circle,
/// the "LifeReplay" title in bold, and a descriptive subtitle.
class HomeHeroHeader extends StatelessWidget {
  const HomeHeroHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // ── Icon with glow background ──────────────────────────────
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                const Color(0xFF6C63FF).withValues(alpha: 0.15),
                const Color(0xFF6C63FF).withValues(alpha: 0.03),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6C63FF).withValues(alpha: 0.15),
                blurRadius: 30,
                spreadRadius: 5,
              ),
            ],
          ),
          child: const Icon(
            Icons.psychology,
            size: 64,
            color: Color(0xFF6C63FF),
          ),
        ),
        const SizedBox(height: 20),

        // ── Title ──────────────────────────────────────────────────
        Text(
          'LifeReplay',
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF6C63FF),
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 10),

        // ── Subtitle ───────────────────────────────────────────────
        Text(
          'Hayatinizin onemli kararlarini\nsimule edin ve analiz edin.',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: Colors.grey[500],
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
