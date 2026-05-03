// lib/presentation/screens/parameters/widgets/parameter_input_card.dart

import 'package:flutter/material.dart';

/// A white elevated card for adding a new decision criterion.
///
/// Contains three text fields (Kriter, Miktar/Derece, Birim) with modern
/// borderless styling, and a soft "Kriter Ekle" button.
class ParameterInputCard extends StatelessWidget {
  static const _suggestions = [
    'Maas',
    'Zaman',
    'Maliyet',
    'Risk',
    'Kariyer',
    'Stres',
    'Eglence',
  ];

  final TextEditingController keyController;
  final TextEditingController valueController;
  final TextEditingController unitController;
  final VoidCallback onAdd;

  const ParameterInputCard({
    super.key,
    required this.keyController,
    required this.valueController,
    required this.unitController,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
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
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: const Color(0xFF6C63FF).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.tune,
                    color: Color(0xFF6C63FF),
                    size: 18,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'Kriter Ekle',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // ── Key field ───────────────────────────────────────────
            _buildField(
              controller: keyController,
              hint: 'Kriter (Orn: Maas, Mesafe, Sure)',
              icon: Icons.flag_outlined,
            ),
            const SizedBox(height: 8),

            // ── Suggestion chips ────────────────────────────────────
            SizedBox(
              height: 32,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _suggestions.length,
                separatorBuilder: (_, _) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final label = _suggestions[index];
                  return ActionChip(
                    label: Text(
                      label,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF6C63FF),
                      ),
                    ),
                    onPressed: () {
                      keyController.text = label;
                      keyController.selection = TextSelection.fromPosition(
                        TextPosition(offset: label.length),
                      );
                    },
                    backgroundColor:
                        const Color(0xFF6C63FF).withValues(alpha: 0.1),
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                  );
                },
              ),
            ),
            const SizedBox(height: 10),

            // ── Value field ─────────────────────────────────────────
            _buildField(
              controller: valueController,
              hint: 'Miktar / Derece (Istege bagli)',
              icon: Icons.pin,
            ),
            const SizedBox(height: 10),

            // ── Unit field ──────────────────────────────────────────
            _buildField(
              controller: unitController,
              hint: 'Birim (Orn: TL, Ay, %)',
              icon: Icons.straighten,
            ),
            const SizedBox(height: 16),

            // ── Add button ──────────────────────────────────────────
            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton.icon(
                onPressed: onAdd,
                icon: const Icon(Icons.add, size: 18),
                label: const Text(
                  'Kriter Ekle',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFF6C63FF).withValues(alpha: 0.1),
                  foregroundColor: const Color(0xFF6C63FF),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
  }) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(fontSize: 15),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
        filled: true,
        fillColor: const Color(0xFFF8F9FA),
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFF6C63FF),
            width: 1.5,
          ),
        ),
        prefixIcon: Icon(icon, size: 20, color: Colors.grey[500]),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }
}
