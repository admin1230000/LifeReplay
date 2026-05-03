// lib/presentation/screens/parameters/widgets/decision_info_card.dart

import 'package:flutter/material.dart';

/// A white elevated card containing the two decision text fields:
/// "Karar Basligi" and "Kategori".
///
/// Each field uses a filled #F8F9FA background with no border,
/// a prefix icon, and rounded 12px corners.
class DecisionInfoCard extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController categoryController;
  final String? Function(String?)? titleValidator;
  final String? Function(String?)? categoryValidator;

  const DecisionInfoCard({
    super.key,
    required this.titleController,
    required this.categoryController,
    this.titleValidator,
    this.categoryValidator,
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
                    Icons.edit_note,
                    color: Color(0xFF6C63FF),
                    size: 18,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'Karar Bilgileri',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // ── Title field ─────────────────────────────────────────
            _buildField(
              controller: titleController,
              hint: 'Orn: Is teklifini kabul etmeli miyim?',
              icon: Icons.edit,
              validator: titleValidator,
            ),
            const SizedBox(height: 12),

            // ── Category field ──────────────────────────────────────
            _buildField(
              controller: categoryController,
              hint: 'Orn: Finans, Kariyer, Saglik',
              icon: Icons.category,
              validator: categoryValidator,
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
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
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
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
        prefixIcon: Icon(icon, size: 20, color: Colors.grey[500]),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }
}
