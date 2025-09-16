import 'package:flutter/foundation.dart';
import '../../domain/entities/pessoa.dart';

import '../../domain/usecases/add_pessoa.dart';
import '../../domain/usecases/get_all_pessoa.dart';
import '../../domain/usecases/update_pessoa.dart';
import '../../domain/usecases/delete_pessoa.dart';

class PessoasViewModel extends ChangeNotifier {
  final AddPessoa _addPessoa;
  final GetAllPessoas _getAllPessoas;
  final UpdatePessoa _updatePessoa;
  final DeletePessoa _deletePessoa;

  PessoasViewModel({
    required AddPessoa addPessoa,
    required GetAllPessoas getAllPessoas,
    required UpdatePessoa updatePessoa,
    required DeletePessoa deletePessoa,
  }) : _addPessoa = addPessoa,
       _getAllPessoas = getAllPessoas,
       _updatePessoa = updatePessoa,
       _deletePessoa = deletePessoa;

  List<Pessoa> _pessoas = [];
  bool _isLoading = false;
  String? _error;
  bool _isSaving = false;
  int? _editingId;

  List<Pessoa> get pessoas => _pessoas;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isSaving => _isSaving;
  int? get editingId => _editingId;
  bool get isEditing => _editingId != null;

  Future<void> loadPessoas() async {
    _setLoading(true);
    _setError(null);

    try {
      _pessoas = await _getAllPessoas();
    } catch (e) {
      _setError('Erro ao carregar pessoas: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> addPessoa(String nome, int idade) async {
    _setSaving(true);
    _setError(null);

    try {
      final pessoa = Pessoa(nome: nome, idade: idade);
      await _addPessoa(pessoa);
      await loadPessoas();
      return true;
    } catch (e) {
      _setError('Erro ao adicionar pessoa: ${e.toString()}');
      return false;
    } finally {
      _setSaving(false);
    }
  }

  Future<bool> updatePessoa(String nome, int idade) async {
    if (_editingId == null) return false;

    _setSaving(true);
    _setError(null);

    try {
      final pessoa = Pessoa(id: _editingId, nome: nome, idade: idade);
      await _updatePessoa(pessoa);
      await loadPessoas();
      clearEditing();
      return true;
    } catch (e) {
      _setError('Erro ao atualizar pessoa: ${e.toString()}');
      return false;
    } finally {
      _setSaving(false);
    }
  }

  Future<bool> deletePessoa(int id) async {
    _setError(null);

    try {
      await _deletePessoa(id);
      await loadPessoas();

      if (_editingId == id) {
        clearEditing();
      }

      return true;
    } catch (e) {
      _setError('Erro ao remover pessoa: ${e.toString()}');
      return false;
    }
  }

  void setEditingPessoa(Pessoa pessoa) {
    _editingId = pessoa.id;
    notifyListeners();
  }

  void clearEditing() {
    _editingId = null;
    notifyListeners();
  }

  void clearError() {
    _setError(null);
  }

  Pessoa? get editingPessoa {
    if (_editingId == null) return null;
    try {
      return _pessoas.firstWhere((p) => p.id == _editingId);
    } catch (e) {
      return null;
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setSaving(bool saving) {
    _isSaving = saving;
    notifyListeners();
  }

  void _setError(String? error) {
    _error = error;
    notifyListeners();
  }
}
