// lib/presentation/screens/parameters_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/repositories/decision_repository.dart';
import '../providers/providers.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/loading_overlay.dart';
import '../widgets/parameter_tile.dart';
import 'parameters/widgets/decision_info_card.dart';
import 'parameters/widgets/parameter_input_card.dart';

/// Parameter screen where the user enters the decision title, category,
/// and key/value/unit parameters.
class ParametersScreen extends ConsumerStatefulWidget {
  const ParametersScreen({super.key});

  @override
  ConsumerState<ParametersScreen> createState() => _ParametersScreenState();
}

class _ParametersScreenState extends ConsumerState<ParametersScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _categoryController = TextEditingController();

  // New parameter entry fields
  final _paramKeyController = TextEditingController();
  final _paramValueController = TextEditingController();
  final _paramUnitController = TextEditingController();

  // Added parameters
  final List<_ParamEntry> _parameters = [];

  @override
  void dispose() {
    _titleController.dispose();
    _categoryController.dispose();
    _paramKeyController.dispose();
    _paramValueController.dispose();
    _paramUnitController.dispose();
    super.dispose();
  }

  void _addParameter() {
    final key = _paramKeyController.text.trim();
    if (key.isEmpty) {
      _showSnackBar('Lutfen bir kriter girin.');
      return;
    }

    setState(() {
      _parameters.add(_ParamEntry(
        key: key,
        value: _paramValueController.text.trim(),
        unit: _paramUnitController.text.trim(),
      ));
      _paramKeyController.clear();
      _paramValueController.clear();
      _paramUnitController.clear();
    });
  }

  void _removeParameter(int index) {
    setState(() {
      _parameters.removeAt(index);
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
    );
  }

  Future<void> _startSimulation() async {
    if (!_formKey.currentState!.validate()) return;

    if (_parameters.isEmpty) {
      _showSnackBar('En az bir kriter eklemelisiniz.');
      return;
    }

    final title = _titleController.text.trim();
    final category = _categoryController.text.trim();

    final paramInputs = _parameters
        .map((p) => ParameterInput(
              key: p.key,
              value: p.value,
              unit: p.unit,
            ))
        .toList();

    await ref.read(simulationControllerProvider.notifier).run(
          title: title,
          category: category,
          parameters: paramInputs,
        );

    if (!mounted) return;

    final state = ref.read(simulationControllerProvider);
    if (state is SimulationSuccess) {
      context.go('/result');
    } else if (state is SimulationError) {
      _showSnackBar('Hata: ${state.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final simState = ref.watch(simulationControllerProvider);

    return Stack(
      children: [
        AppScaffold(
          title: 'Karar Kriterleri',
          showBack: true,
          body: Column(
            children: [
              // Scrollable form content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // A. Decision Info Card
                        DecisionInfoCard(
                          titleController: _titleController,
                          categoryController: _categoryController,
                          titleValidator: (v) =>
                              (v == null || v.trim().isEmpty)
                                  ? 'Baslik gerekli'
                                  : null,
                          categoryValidator: (v) =>
                              (v == null || v.trim().isEmpty)
                                  ? 'Kategori gerekli'
                                  : null,
                        ),
                        const SizedBox(height: 16),

                        // B. Added Parameters List
                        if (_parameters.isNotEmpty) ...[
                          _buildAddedParametersHeader(),
                          const SizedBox(height: 8),
                          ..._parameters.asMap().entries.map((entry) {
                            final i = entry.key;
                            final p = entry.value;
                            return ParameterTile(
                              keyName: p.key,
                              value: p.value,
                              unit: p.unit,
                              onDelete: () => _removeParameter(i),
                            );
                          }),
                          const SizedBox(height: 16),
                        ],

                        // C. Add New Parameter Card
                        ParameterInputCard(
                          keyController: _paramKeyController,
                          valueController: _paramValueController,
                          unitController: _paramUnitController,
                          onAdd: _addParameter,
                        ),

                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),

              // Start Simulation button (sticky at bottom)
              _buildBottomBar(),
            ],
          ),
        ),

        // ── Loading overlay ────────────────────────────────────
        if (simState is SimulationLoading)
          const LoadingOverlay(
            message:
                'Senaryolar olusturuluyor...\nBu birkac saniye surebilir.',
          ),
      ],
    );
  }

  Widget _buildAddedParametersHeader() {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: const Color(0xFF6C63FF).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.list_alt,
            color: Color(0xFF6C63FF),
            size: 18,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          'Eklenen Kriterler (${_parameters.length})',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
            fontSize: 14,
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () => setState(() => _parameters.clear()),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.red.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Temizle',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.red[500],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton.icon(
              onPressed: _startSimulation,
              icon: const Icon(Icons.rocket_launch, size: 22),
              label: const Text(
                'Simulasyonu Baslat',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
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
          ),
        ),
      ),
    );
  }
}

/// Internal model for a parameter entry in the form.
class _ParamEntry {
  final String key;
  final String value;
  final String unit;

  const _ParamEntry({
    required this.key,
    required this.value,
    required this.unit,
  });
}
