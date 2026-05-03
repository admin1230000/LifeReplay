// lib/presentation/screens/home_screen.dart

import 'package:flutter/material.dart';

import '../widgets/app_scaffold.dart';
import 'home/widgets/home_action_buttons.dart';
import 'home/widgets/home_hero_header.dart';
import 'home/widgets/how_it_works_card.dart';

/// Ana ekran – uygulamanin giris noktasi.
///
/// Structure (top to bottom):
/// 1. Hero header (icon + title + subtitle)
/// 2. Primary action buttons (Yeni Simulasyon + Gecmis Kararlar)
/// 3. How it works info card
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AppScaffold(
      title: 'LifeReplay',
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── 1. Hero header ────────────────────────────────────
            SizedBox(height: size.height * 0.04),
            const HomeHeroHeader(),
            SizedBox(height: size.height * 0.06),

            // ── 2. Action buttons ─────────────────────────────────
            const HomeActionButtons(),
            SizedBox(height: size.height * 0.06),

            // ── 3. How it works card ──────────────────────────────
            const HowItWorksCard(),
          ],
        ),
      ),
    );
  }
}
