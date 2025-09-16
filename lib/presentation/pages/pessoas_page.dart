import 'package:flutter/material.dart';
import '../../core/di/dependency_injection.dart';
import '../viewmodels/pessoas_viewmodel.dart';
import '../widgets/pessoa_form.dart';
import '../widgets/pessoa_list.dart';

/// Página principal para gerenciamento de pessoas
/// Implementa Clean Architecture com Dependency Injection
class PessoasPage extends StatefulWidget {
  const PessoasPage({super.key});

  @override
  State<PessoasPage> createState() => _PessoasPageState();
}

class _PessoasPageState extends State<PessoasPage> {
  late final PessoasViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    // Dependency Injection - GetIt
    _viewModel = serviceLocator<PessoasViewModel>();
    _loadData();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  /// Carrega dados iniciais
  Future<void> _loadData() async {
    await _viewModel.loadPessoas();
  }

  /// Manipula salvamento (add/update)
  Future<bool> _handleSave(String nome, int idade) async {
    bool success;

    if (_viewModel.isEditing) {
      success = await _viewModel.updatePessoa(nome, idade);
      if (success && mounted) {
        _showSuccessSnackBar('Pessoa atualizada com sucesso!');
      }
    } else {
      success = await _viewModel.addPessoa(nome, idade);
      if (success && mounted) {
        _showSuccessSnackBar('Pessoa adicionada com sucesso!');
      }
    }

    // Mostra erro se houver
    if (!success && mounted && _viewModel.error != null) {
      _showErrorSnackBar(_viewModel.error!);
      _viewModel.clearError();
    }

    return success;
  }

  /// Manipula exclusão
  Future<void> _handleDelete(int id) async {
    final success = await _viewModel.deletePessoa(id);

    if (!mounted) return;

    if (success) {
      _showSuccessSnackBar('Pessoa removida com sucesso!');
    } else if (_viewModel.error != null) {
      _showErrorSnackBar(_viewModel.error!);
      _viewModel.clearError();
    }
  }

  /// Manipula edição
  void _handleEdit(pessoa) {
    _viewModel.setEditingPessoa(pessoa);
  }

  /// Cancela edição
  void _handleCancelEdit() {
    _viewModel.clearEditing();
  }

  /// Mostra mensagem de sucesso
  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// Mostra mensagem de erro
  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pessoas (SQLite)'),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'Recarregar lista',
            onPressed: _loadData,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Formulário de entrada
            ListenableBuilder(
              listenable: _viewModel,
              builder: (context, child) {
               return PessoaForm(
                onSave: _handleSave,
                onCancel: _viewModel.isEditing ? _handleCancelEdit : null,
                editingPessoa: _viewModel.editingPessoa,
                isLoading: _viewModel.isSaving,
              );
              },
            ),

            const Divider(height: 1),

            // Lista de pessoas
            Expanded(
              child: ListenableBuilder(
                listenable: _viewModel,
                builder: (context, child) {
                  return PessoaList(
                    pessoas: _viewModel.pessoas,
                    isLoading: _viewModel.isLoading,
                    error: _viewModel.error,
                    onEdit: _handleEdit,
                    onDelete: _handleDelete,
                    onRefresh: _loadData,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}